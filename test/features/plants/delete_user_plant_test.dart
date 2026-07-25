import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('deleteUserPlant clears schedules for that plant', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final scheduler = RecordingReminderScheduler();
    final services = await BloomServices.bootstrapForTest(
      database: BloomDatabase.memory(),
      preferences: prefs,
      scheduler: scheduler,
    );

    await services.settings.setRemindersEnabled(true);
    await services.reminders.reconcile();
    expect(scheduler.scheduled.containsKey('task-snake-water'), isTrue);

    await services.deleteUserPlant('plant-snake');

    expect(await services.care.getUserPlant('plant-snake'), isNull);
    expect(scheduler.scheduled.containsKey('task-snake-water'), isFalse);
  });
}
