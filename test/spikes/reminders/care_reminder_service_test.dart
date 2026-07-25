import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
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

    await services.reminders.reconcile();
    expect(scheduler.scheduled.length, firstCount);
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
