import 'dart:async';
import 'dart:io';

import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/local/drift/drift_care_repository.dart';
import 'package:bloom/data/local/shared_preferences_settings_repository.dart';
import 'package:bloom/data/reminders/care_reminder_service.dart';
import 'package:bloom/data/reminders/reminder_action_bridge.dart';
import 'package:bloom/data/reminders/reminder_payload.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class FlutterReminderScheduler implements ReminderScheduler {
  FlutterReminderScheduler({FlutterLocalNotificationsPlugin? plugin})
    : _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  static const _channelId = 'bloom_care_reminders';
  static const _channelName = 'Care reminders';

  final FlutterLocalNotificationsPlugin _plugin;
  void Function(String taskId, ReminderAction action)? _onAction;

  @override
  Future<void> initialize({
    void Function(String taskId, ReminderAction action)? onAction,
    bool listenForActions = true,
  }) async {
    _onAction = onAction;
    await _refreshLocalTimezone();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: android);
    try {
      await _plugin.initialize(
        settings: initSettings,
        onDidReceiveNotificationResponse: listenForActions
            ? _handleResponse
            : null,
        onDidReceiveBackgroundNotificationResponse: listenForActions
            ? bloomNotificationBackground
            : null,
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
    } on Object catch (error, stack) {
      // Hot restart can re-enter plugin init while native state still exists.
      debugPrint('Reminder scheduler init skipped: $error\n$stack');
    }
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
  Future<void> prepareForReconcile() => _refreshLocalTimezone();

  Future<void> _refreshLocalTimezone() async {
    tz_data.initializeTimeZones();
    try {
      final timezoneInfo = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timezoneInfo.identifier));
    } on Object {
      tz.setLocalLocation(tz.UTC);
    }
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
          AndroidNotificationAction('done', 'Done', showsUserInterface: true),
          AndroidNotificationAction(
            'snooze',
            'Snooze',
            showsUserInterface: true,
          ),
          AndroidNotificationAction('skip', 'Skip', showsUserInterface: true),
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
      payload: ReminderPayload.encode(taskId),
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
        ?ReminderPayload.decodeTaskId(request.payload),
    ];
  }

  @override
  Future<({String taskId, ReminderAction action})?> takeLaunchAction() async {
    final details = await _plugin.getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp != true) {
      return null;
    }
    final response = details!.notificationResponse;
    if (response == null) {
      return null;
    }
    return ReminderPayload.parseResponse(response);
  }

  void _handleResponse(NotificationResponse response) {
    final parsed = ReminderPayload.parseResponse(response);
    if (parsed == null) {
      return;
    }
    _onAction?.call(parsed.taskId, parsed.action);
  }

  static int _notificationId(String taskId) {
    return taskId.hashCode & 0x7fffffff;
  }
}

/// Top-level entry for notification actions when a background engine is used.
@pragma('vm:entry-point')
void bloomNotificationBackground(NotificationResponse response) {
  unawaited(_handleBackgroundNotificationResponse(response));
}

Future<void> _handleBackgroundNotificationResponse(
  NotificationResponse response,
) async {
  WidgetsFlutterBinding.ensureInitialized();
  final parsed = ReminderPayload.parseResponse(response);
  if (parsed == null || parsed.action == ReminderAction.open) {
    return;
  }

  final db = BloomDatabase.defaults();
  final care = DriftCareRepository(db);
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.reload();
    final settings = SharedPreferencesSettingsRepository(prefs);
    final scheduler = FlutterReminderScheduler();
    final reminders = CareReminderService(
      care: care,
      settings: settings,
      scheduler: scheduler,
    );
    await reminders.initialize(listenForActions: false);
    await reminders.handleAction(parsed.taskId, parsed.action);
    ReminderActionBridge.notifyUiChanged();
  } finally {
    await care.close();
  }
}
