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
  });

  final CareRepository _care;
  final SettingsRepository _settings;
  final ReminderScheduler _scheduler;

  Future<void> initialize() {
    return _scheduler.initialize(onAction: _handleAction);
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

  /// Cancel all Bloom care reminders and reschedule from open SQLite tasks.
  Future<void> reconcile() async {
    final enabled = await _settings.getRemindersEnabled();
    await _scheduler.cancelAll();
    if (!enabled) {
      return;
    }

    final openTasks = await _care.listOpenTasksForToday();
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

  Future<void> _handleAction(String taskId, ReminderAction action) async {
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
    final key = _actionKey('done', task);
    if (await _hasEvent(task.userPlantId, key)) {
      await _scheduler.cancel(taskId);
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
  }

  Future<void> snoozeTask(
    String taskId, {
    Duration delay = const Duration(hours: 1),
  }) async {
    final task = await _care.getCareTask(taskId);
    if (task == null || task.isDone) {
      return;
    }
    final key = _actionKey('snooze', task);
    if (await _hasEvent(task.userPlantId, key)) {
      return;
    }
    final snoozedUntil = DateTime.now().add(delay);
    await _care.upsertCareTask(
      CareTask(
        id: task.id,
        userPlantId: task.userPlantId,
        actionLabel: task.actionLabel,
        urgency: CareUrgency.upcoming,
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
  }

  Future<void> skipTask(String taskId) async {
    final task = await _care.getCareTask(taskId);
    if (task == null) {
      return;
    }
    final key = _actionKey('skip', task);
    if (await _hasEvent(task.userPlantId, key)) {
      await _scheduler.cancel(taskId);
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
  }

  Future<bool> _hasEvent(String userPlantId, String eventId) async {
    final events = await _care.listCareEvents(userPlantId);
    return events.any((event) => event.id == eventId);
  }

  static String _actionKey(String action, CareTask task) {
    return 'action-$action-${task.id}-${task.dueAt.millisecondsSinceEpoch}';
  }
}
