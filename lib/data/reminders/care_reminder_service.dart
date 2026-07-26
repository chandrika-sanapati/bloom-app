import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/entities.dart';
import 'package:bloom/data/domain/settings_repository.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';

/// Projects persisted [CareTask] rows into local notifications.
///
/// Notifications are never the source of truth — SQLite tasks are.
class CareReminderService {
  CareReminderService({
    required this._care,
    required this._settings,
    required this._scheduler,
    this.onDataMutated,
  });

  final CareRepository _care;
  final SettingsRepository _settings;
  final ReminderScheduler _scheduler;
  final void Function()? onDataMutated;

  Future<void> initialize({bool listenForActions = true}) async {
    await _scheduler.initialize(
      onAction: listenForActions ? _onNotificationAction : null,
      listenForActions: listenForActions,
    );
    if (!listenForActions) {
      return;
    }
    final launch = await _scheduler.takeLaunchAction();
    if (launch != null) {
      await handleAction(launch.taskId, launch.action);
    }
  }

  Future<void> _onNotificationAction(
    String taskId,
    ReminderAction action,
  ) async {
    await handleAction(taskId, action);
  }

  /// Request permission in context (e.g. when enabling reminders in Settings).
  Future<bool> enableReminders() async {
    final granted = await _scheduler.requestPermission();
    await _settings.setRemindersEnabled(granted);
    if (granted) {
      await reconcile();
    } else {
      await _scheduler.cancelAll();
    }
    return granted;
  }

  Future<void> disableReminders() async {
    await _settings.setRemindersEnabled(false);
    await _scheduler.cancelAll();
  }

  /// Cancel all Bloom care reminders and reschedule from every open SQLite task.
  Future<void> reconcile() async {
    final enabled = await _settings.getRemindersEnabled();
    await _scheduler.cancelAll();
    if (!enabled) {
      return;
    }

    final openTasks = await _care.listOpenCareTasks();
    final records = {
      for (final record in await _care.listUserPlantRecords())
        record.plant.id: record,
    };

    for (final task in openTasks) {
      final plantName =
          records[task.userPlantId]?.plant.displayName ?? 'Your plant';
      await _scheduler.scheduleCareReminder(
        taskId: task.id,
        title: '$plantName needs care',
        body: task.actionLabel,
        when: task.dueAt,
      );
    }
  }

  Future<void> handleAction(String taskId, ReminderAction action) async {
    switch (action) {
      case ReminderAction.done:
        await completeTask(taskId);
      case ReminderAction.snooze:
        await snoozeTask(taskId);
      case ReminderAction.skip:
        await skipTask(taskId);
      case ReminderAction.open:
        break;
    }
  }

  Future<void> completeTask(String taskId) async {
    final task = await _care.getCareTask(taskId);
    if (task == null) {
      return;
    }
    final key = _actionKeyForDue('done', task.id, task.dueAt);
    if (await _hasEvent(task.userPlantId, key)) {
      await _scheduler.cancel(taskId);
      _emitMutation();
      return;
    }
    if (!task.isDone) {
      await _care.upsertCareTask(
        CareTask(
          id: task.id,
          userPlantId: task.userPlantId,
          actionLabel: task.actionLabel,
          urgency: task.urgency,
          dueAt: task.dueAt,
          isDone: true,
        ),
      );
      await _care.addCareEvent(
        CareEvent(
          id: key,
          userPlantId: task.userPlantId,
          kind: CareActionKind.check,
          label: '${task.actionLabel} done',
          occurredAt: DateTime.now(),
        ),
      );
    }
    await _scheduler.cancel(taskId);
    _emitMutation();
  }

  Future<void> snoozeTask(
    String taskId, {
    Duration delay = const Duration(hours: 1),
    DateTime? until,
  }) async {
    final task = await _care.getCareTask(taskId);
    if (task == null || task.isDone) {
      return;
    }
    final snoozedUntil = until ?? DateTime.now().add(delay);
    final key = _actionKeyForDue('snooze', task.id, snoozedUntil);
    if (await _hasEvent(task.userPlantId, key)) {
      return;
    }
    await _care.upsertCareTask(
      CareTask(
        id: task.id,
        userPlantId: task.userPlantId,
        actionLabel: task.actionLabel,
        urgency: urgencyForDueAt(snoozedUntil),
        dueAt: snoozedUntil,
        isDone: false,
      ),
    );
    await _care.addCareEvent(
      CareEvent(
        id: key,
        userPlantId: task.userPlantId,
        kind: CareActionKind.check,
        label: '${task.actionLabel} snoozed',
        occurredAt: DateTime.now(),
      ),
    );
    await _scheduler.cancel(taskId);
    if (await _settings.getRemindersEnabled()) {
      final record = await _care.getUserPlantRecord(task.userPlantId);
      await _scheduler.scheduleCareReminder(
        taskId: task.id,
        title: '${record?.plant.displayName ?? 'Your plant'} needs care',
        body: task.actionLabel,
        when: snoozedUntil,
      );
    }
    _emitMutation();
  }

  Future<void> skipTask(String taskId) async {
    final task = await _care.getCareTask(taskId);
    if (task == null) {
      return;
    }
    final key = _actionKeyForDue('skip', task.id, task.dueAt);
    if (await _hasEvent(task.userPlantId, key)) {
      await _scheduler.cancel(taskId);
      _emitMutation();
      return;
    }
    if (!task.isDone) {
      await _care.upsertCareTask(
        CareTask(
          id: task.id,
          userPlantId: task.userPlantId,
          actionLabel: task.actionLabel,
          urgency: task.urgency,
          dueAt: task.dueAt,
          isDone: true,
        ),
      );
      await _care.addCareEvent(
        CareEvent(
          id: key,
          userPlantId: task.userPlantId,
          kind: CareActionKind.check,
          label: '${task.actionLabel} skipped',
          occurredAt: DateTime.now(),
        ),
      );
    }
    await _scheduler.cancel(taskId);
    _emitMutation();
  }

  Future<void> rescheduleTask(String taskId, DateTime dueAt) async {
    final task = await _care.getCareTask(taskId);
    if (task == null || task.isDone) {
      return;
    }
    final key = _actionKeyForDue('reschedule', task.id, dueAt);
    if (await _hasEvent(task.userPlantId, key)) {
      return;
    }
    await _care.upsertCareTask(
      CareTask(
        id: task.id,
        userPlantId: task.userPlantId,
        actionLabel: task.actionLabel,
        urgency: urgencyForDueAt(dueAt),
        dueAt: dueAt,
        isDone: false,
      ),
    );
    await _care.addCareEvent(
      CareEvent(
        id: key,
        userPlantId: task.userPlantId,
        kind: CareActionKind.check,
        label: '${task.actionLabel} rescheduled',
        occurredAt: DateTime.now(),
      ),
    );
    await _scheduler.cancel(taskId);
    if (await _settings.getRemindersEnabled()) {
      final record = await _care.getUserPlantRecord(task.userPlantId);
      await _scheduler.scheduleCareReminder(
        taskId: task.id,
        title: '${record?.plant.displayName ?? 'Your plant'} needs care',
        body: task.actionLabel,
        when: dueAt,
      );
    }
    _emitMutation();
  }

  void _emitMutation() {
    onDataMutated?.call();
  }

  Future<bool> _hasEvent(String userPlantId, String eventId) async {
    final events = await _care.listCareEvents(userPlantId);
    return events.any((event) => event.id == eventId);
  }

  static String _actionKeyForDue(String action, String taskId, DateTime dueAt) {
    return 'action-$action-$taskId-${dueAt.millisecondsSinceEpoch}';
  }

  /// Calendar-day urgency for a due timestamp.
  static CareUrgency urgencyForDueAt(DateTime dueAt, {DateTime? now}) {
    final current = now ?? DateTime.now();
    final startToday = DateTime(current.year, current.month, current.day);
    final startDue = DateTime(dueAt.year, dueAt.month, dueAt.day);
    if (startDue.isBefore(startToday)) {
      return CareUrgency.overdue;
    }
    if (startDue == startToday) {
      return CareUrgency.dueToday;
    }
    return CareUrgency.upcoming;
  }
}
