import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/settings_repository.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/local/drift/drift_care_repository.dart';
import 'package:bloom/data/local/fixture_seeder.dart';
import 'package:bloom/data/local/shared_preferences_settings_repository.dart';
import 'package:bloom/data/reminders/care_reminder_service.dart';
import 'package:bloom/data/reminders/flutter_reminder_scheduler.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloomServices {
  BloomServices({
    required this.care,
    required this.settings,
    required this.seeder,
    required this.reminders,
  });

  final CareRepository care;
  final SettingsRepository settings;
  final FixtureSeeder seeder;
  final CareReminderService reminders;

  /// Bumped when collection/tasks change so shell tabs can refresh.
  final ValueNotifier<int> dataRevision = ValueNotifier(0);

  void notifyDataChanged() {
    dataRevision.value++;
    // Fire-and-forget reconcile so Today/add-plant keep notifications aligned.
    reminders.reconcile();
  }

  /// Clears SQLite care data, preferences, and scheduled reminders.
  /// Leaves an empty collection (does not reseed sample plants).
  Future<void> deleteAllLocalData() async {
    await reminders.disableReminders();
    await care.deleteAllData();
    await settings.clearAll();
    notifyDataChanged();
  }

  static Future<BloomServices> bootstrap({
    BloomDatabase? database,
    SharedPreferences? preferences,
    ReminderScheduler? reminderScheduler,
  }) async {
    final db = database ?? BloomDatabase.defaults();
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final settings = SharedPreferencesSettingsRepository(prefs);
    final care = DriftCareRepository(db);
    final seeder = FixtureSeeder(care, settings);
    await seeder.seedIfNeeded();

    final reminders = CareReminderService(
      care: care,
      settings: settings,
      scheduler: reminderScheduler ?? FlutterReminderScheduler(),
    );
    await reminders.initialize();
    await reminders.reconcile();

    return BloomServices(
      care: care,
      settings: settings,
      seeder: seeder,
      reminders: reminders,
    );
  }

  /// Test helper that never touches platform notification channels.
  static Future<BloomServices> bootstrapForTest({
    BloomDatabase? database,
    SharedPreferences? preferences,
    RecordingReminderScheduler? scheduler,
  }) {
    return bootstrap(
      database: database ?? BloomDatabase.memory(),
      preferences: preferences,
      reminderScheduler: scheduler ?? RecordingReminderScheduler(),
    );
  }
}
