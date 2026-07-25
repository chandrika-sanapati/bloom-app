import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Shared payload format: `bloom:task:{taskId}`.
abstract final class ReminderPayload {
  static const prefix = 'bloom:task:';

  static String encode(String taskId) => '$prefix$taskId';

  static String? decodeTaskId(String? payload) {
    if (payload == null || !payload.startsWith(prefix)) {
      return null;
    }
    final taskId = payload.substring(prefix.length);
    return taskId.isEmpty ? null : taskId;
  }

  static ReminderAction actionFromId(String? actionId) {
    return switch (actionId) {
      'done' => ReminderAction.done,
      'snooze' => ReminderAction.snooze,
      'skip' => ReminderAction.skip,
      _ => ReminderAction.open,
    };
  }

  static ({String taskId, ReminderAction action})? parseResponse(
    NotificationResponse response,
  ) {
    final taskId = decodeTaskId(response.payload);
    if (taskId == null) {
      return null;
    }
    return (taskId: taskId, action: actionFromId(response.actionId));
  }
}
