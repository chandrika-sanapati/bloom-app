/// Low-level notification scheduling port. Implementations may be faked in tests.
abstract interface class ReminderScheduler {
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
  });

  Future<bool> requestPermission();

  Future<void> scheduleCareReminder({
    required String taskId,
    required String title,
    required String body,
    required DateTime when,
  });

  Future<void> cancel(String taskId);

  Future<void> cancelAll();

  Future<List<String>> pendingTaskIds();
}

enum ReminderAction { done, snooze, skip, open }
