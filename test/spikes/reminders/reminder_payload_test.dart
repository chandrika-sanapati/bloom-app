import 'package:bloom/data/reminders/reminder_payload.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('encodes and decodes task payloads', () {
    expect(ReminderPayload.encode('task-1'), 'bloom:task:task-1');
    expect(ReminderPayload.decodeTaskId('bloom:task:task-1'), 'task-1');
    expect(ReminderPayload.decodeTaskId('other'), isNull);
  });

  test('parses notification action responses', () {
    final parsed = ReminderPayload.parseResponse(
      const NotificationResponse(
        notificationResponseType:
            NotificationResponseType.selectedNotificationAction,
        payload: 'bloom:task:task-snake-water',
        actionId: 'done',
      ),
    );
    expect(parsed?.taskId, 'task-snake-water');
    expect(parsed?.action, ReminderAction.done);
  });
}
