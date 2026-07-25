import 'package:bloom/data/reminders/reminder_scheduler.dart';

/// In-memory scheduler for unit tests (no platform channels).
class RecordingReminderScheduler implements ReminderScheduler {
  final scheduled = <String, DateTime>{};
  var permissionGranted = true;
  var initializeCalls = 0;
  void Function(String taskId, ReminderAction action)? onAction;

  @override
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
  }) async {
    initializeCalls += 1;
    this.onAction = onAction;
  }

  @override
  Future<bool> requestPermission() async => permissionGranted;

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

  void emulateAction(String taskId, ReminderAction action) {
    onAction?.call(taskId, action);
  }
}
