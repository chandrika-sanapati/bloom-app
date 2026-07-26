import 'package:bloom/data/reminders/reminder_scheduler.dart';

/// In-memory scheduler for unit tests (no platform channels).
class RecordingReminderScheduler implements ReminderScheduler {
  final scheduled = <String, DateTime>{};
  var permissionGranted = true;
  var initializeCalls = 0;
  void Function(String taskId, ReminderAction action)? onAction;
  ({String taskId, ReminderAction action})? launchAction;

  @override
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
    bool listenForActions = true,
  }) async {
    initializeCalls += 1;
    this.onAction = onAction;
  }

  @override
  Future<bool> requestPermission() async => permissionGranted;

  var prepareForReconcileCalls = 0;

  @override
  Future<void> prepareForReconcile() async {
    prepareForReconcileCalls += 1;
  }

  @override
  Future<void> scheduleCareReminder({
    required String taskId,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    scheduled[taskId] = when;
  }

  @override
  Future<void> cancel(String taskId) async {
    scheduled.remove(taskId);
  }

  @override
  Future<void> cancelAll() async {
    scheduled.clear();
  }

  @override
  Future<List<String>> pendingTaskIds() async => scheduled.keys.toList();

  @override
  Future<({String taskId, ReminderAction action})?> takeLaunchAction() async {
    final action = launchAction;
    launchAction = null;
    return action;
  }

  void emulateAction(String taskId, ReminderAction action) {
    onAction?.call(taskId, action);
  }
}
