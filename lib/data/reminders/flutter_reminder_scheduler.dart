import 'dart:io';

import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class FlutterReminderScheduler implements ReminderScheduler {
  FlutterReminderScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _channelId = 'bloom_care_reminders';
  static const _channelName = 'Care reminders';
  static const _payloadPrefix = 'bloom:task:';

  final FlutterLocalNotificationsPlugin _plugin;
  void Function(String taskId, ReminderAction action)? _onAction;

  @override
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
  }) async {
    _onAction = onAction;
    tz_data.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } on Object {
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    await _plugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _handleResponse,
    );

    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: 'Houseplant care windows from Bloom',
        importance: Importance.defaultImportance,
      ),
    );
  }

  @override
  Future<bool> requestPermission() async {
    if (kIsWeb || !Platform.isAndroid) {
      return true;
    }
    final androidPlugin = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    final granted = await androidPlugin?.requestNotificationsPermission();
    return granted ?? false;
  }

  @override
  Future<void> scheduleCareReminder({
    required String taskId,
    required String title,
    required String body,
    required DateTime when,
  }) async {
    var scheduled = when.toUtc();
    final now = DateTime.now().toUtc();
    if (!scheduled.isAfter(now)) {
      scheduled = now.add(const Duration(minutes: 1));
    }

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        _channelId,
        _channelName,
        channelDescription: 'Houseplant care windows from Bloom',
        actions: const [
          AndroidNotificationAction('done', 'Done'),
          AndroidNotificationAction('snooze', 'Snooze'),
          AndroidNotificationAction('skip', 'Skip'),
        ],
      ),
    );

    await _plugin.zonedSchedule(
      id: _notificationId(taskId),
      title: title,
      body: body,
      scheduledDate: tz.TZDateTime.from(scheduled, tz.local),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: '$_payloadPrefix$taskId',
    );
  }

  @override
  Future<void> cancel(String taskId) {
    return _plugin.cancel(id: _notificationId(taskId));
  }

  @override
  Future<void> cancelAll() => _plugin.cancelAll();

  @override
  Future<List<String>> pendingTaskIds() async {
    final pending = await _plugin.pendingNotificationRequests();
    return [
      for (final request in pending)
        if (request.payload != null &&
            request.payload!.startsWith(_payloadPrefix))
          request.payload!.substring(_payloadPrefix.length),
    ];
  }

  void _handleResponse(NotificationResponse response) {
    final payload = response.payload;
    if (payload == null || !payload.startsWith(_payloadPrefix)) {
      return;
    }
    final taskId = payload.substring(_payloadPrefix.length);
    final action = switch (response.actionId) {
      'done' => ReminderAction.done,
      'snooze' => ReminderAction.snooze,
      'skip' => ReminderAction.skip,
      _ => ReminderAction.open,
    };
    _onAction?.call(taskId, action);
  }

  static int _notificationId(String taskId) {
    return taskId.hashCode & 0x7fffffff;
  }
}
