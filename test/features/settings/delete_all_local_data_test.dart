import 'package:bloom/data/bloom_services.dart';
import 'package:bloom/data/domain/measurement_units.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('deleteAllLocalData wipes SQLite, prefs, and schedules', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final scheduler = RecordingReminderScheduler();
    final services = await BloomServices.bootstrapForTest(
      database: BloomDatabase.memory(),
      preferences: prefs,
      scheduler: scheduler,
    );

    await services.settings.setUnits(MeasurementUnits.imperial.storageValue);
    await services.reminders.enableReminders();
    expect(await services.care.listUserPlants(), isNotEmpty);
    expect(scheduler.scheduled, isNotEmpty);

    await services.deleteAllLocalData();

    expect(await services.care.listUserPlants(), isEmpty);
    expect(await services.care.listOpenTasksForToday(), isEmpty);
    expect(await services.settings.getUnits(), isNull);
    expect(await services.settings.getRemindersEnabled(), isFalse);
    expect(await services.settings.getHasSeededSampleData(), isFalse);
    expect(scheduler.scheduled, isEmpty);
  });
}
