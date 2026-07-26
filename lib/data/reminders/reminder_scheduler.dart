/// Low-level notification scheduling port. Implementations may be faked in tests.
abstract interface class ReminderScheduler {
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
    bool listenForActions = true,
  });

  Future<bool> requestPermission();

  /// Refresh local timezone / DST tables before rescheduling.
  Future<void> prepareForReconcile();

  Future<void> scheduleCareReminder({
    required String taskId,
    required String title,
    required String body,
    required DateTime when,
  });

  Future<void> cancel(String taskId);

  Future<void> cancelAll();

  Future<List<String>> pendingTaskIds();

  /// Action that launched the app from a notification (cold start), if any.
  Future<({String taskId, ReminderAction action})?> takeLaunchAction();
}

enum ReminderAction { done, snooze, skip, open }
