import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/domain/entities.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/reminders/care_reminder_service.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late RecordingReminderScheduler scheduler;
  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
    scheduler = RecordingReminderScheduler();
  });

  Future<BloomServices> boot() {
    return BloomServices.bootstrapForTest(
      database: BloomDatabase.memory(),
      preferences: prefs,
      scheduler: scheduler,
    );
  }

  test('reconcile schedules open tasks without duplicates', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();
    final firstCount = scheduler.scheduled.length;
    expect(firstCount, greaterThan(0));
    expect(scheduler.prepareForReconcileCalls, greaterThan(0));

    final prepareCalls = scheduler.prepareForReconcileCalls;
    await services.reminders.reconcile();
    expect(scheduler.scheduled.length, firstCount);
    expect(scheduler.prepareForReconcileCalls, greaterThan(prepareCalls));
  });

  test('urgency follows calendar day across late-evening offsets', () {
    final now = DateTime(2026, 7, 26, 23, 30);
    expect(
      CareReminderService.urgencyForDueAt(DateTime(2026, 7, 26, 8), now: now),
      CareUrgency.dueToday,
    );
    expect(
      CareReminderService.urgencyForDueAt(
        DateTime(2026, 7, 25, 23, 0),
        now: now,
      ),
      CareUrgency.overdue,
    );
    expect(
      CareReminderService.urgencyForDueAt(
        DateTime(2026, 7, 27, 1, 0),
        now: now,
      ),
      CareUrgency.upcoming,
    );
  });

  test('done action is idempotent and cancels reminder', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();

    const taskId = 'task-snake-water';
    expect(scheduler.scheduled.containsKey(taskId), isTrue);

    await services.reminders.completeTask(taskId);
    await services.reminders.completeTask(taskId);

    final task = await services.care.getCareTask(taskId);
    expect(task?.isDone, isTrue);
    expect(scheduler.scheduled.containsKey(taskId), isFalse);

    final events = await services.care.listCareEvents('plant-snake');
    expect(events.where((event) => event.label.contains('done')).length, 1);
  });

  test('snooze reschedules further out', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();

    const taskId = 'task-lily-water';
    final before = await services.care.getCareTask(taskId);
    await services.reminders.snoozeTask(
      taskId,
      delay: const Duration(hours: 2),
    );
    final after = await services.care.getCareTask(taskId);
    expect(after!.dueAt.isAfter(before!.dueAt), isTrue);
    expect(scheduler.scheduled[taskId], isNotNull);
  });

  test('second snooze with a new delay is allowed', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();

    const taskId = 'task-lily-water';
    await services.reminders.snoozeTask(
      taskId,
      delay: const Duration(hours: 1),
    );
    final afterFirst = await services.care.getCareTask(taskId);
    await services.reminders.snoozeTask(
      taskId,
      delay: const Duration(hours: 3),
    );
    final afterSecond = await services.care.getCareTask(taskId);
    expect(afterSecond!.dueAt.isAfter(afterFirst!.dueAt), isTrue);

    final events = await services.care.listCareEvents('plant-lily');
    expect(events.where((event) => event.label.contains('snoozed')).length, 2);
  });

  test('reschedule updates dueAt and reminder', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();

    const taskId = 'task-rubber-fertilise';
    final raw = DateTime.now().add(const Duration(days: 2, hours: 4));
    // SQLite dateTime columns persist second precision.
    final target = DateTime(
      raw.year,
      raw.month,
      raw.day,
      raw.hour,
      raw.minute,
      raw.second,
    );
    await services.reminders.rescheduleTask(taskId, target);
    await services.reminders.rescheduleTask(taskId, target);

    final task = await services.care.getCareTask(taskId);
    expect(task?.dueAt, target);
    expect(scheduler.scheduled[taskId], target);

    final events = await services.care.listCareEvents('plant-rubber');
    expect(
      events.where((event) => event.label.contains('rescheduled')).length,
      1,
    );
  });

  test('skip marks task done once', () async {
    final services = await boot();
    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();

    const taskId = 'task-monstera-check';
    await services.reminders.skipTask(taskId);
    await services.reminders.skipTask(taskId);
    final task = await services.care.getCareTask(taskId);
    expect(task?.isDone, isTrue);
    final events = await services.care.listCareEvents('plant-monstera');
    expect(events.where((e) => e.label.contains('skipped')).length, 1);
  });

  test('disable reminders clears pending schedules', () async {
    final services = await boot();
    await services.reminders.enableReminders();
    expect(scheduler.scheduled, isNotEmpty);
    await services.reminders.disableReminders();
    expect(scheduler.scheduled, isEmpty);
    expect(await services.settings.getRemindersEnabled(), isFalse);
  });
}
