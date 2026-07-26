import 'package:bloom/data/auth/auth_config.dart';
import 'package:bloom/data/auth/auth_repository.dart';
import 'package:bloom/data/auth/disabled_auth_repository.dart';
import 'package:bloom/data/auth/supabase_auth_repository.dart';
import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/settings_repository.dart';
import 'package:bloom/data/identification/identify_repository.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/local/drift/drift_care_repository.dart';
import 'package:bloom/data/local/fixture_seeder.dart';
import 'package:bloom/data/local/shared_preferences_settings_repository.dart';
import 'package:bloom/data/reminders/care_reminder_service.dart';
import 'package:bloom/data/reminders/flutter_reminder_scheduler.dart';
import 'package:bloom/data/reminders/recording_reminder_scheduler.dart';
import 'package:bloom/data/reminders/reminder_scheduler.dart';
import 'package:bloom/shared/plants/plant_photo_store.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloomServices {
  BloomServices({
    required this.care,
    required this.settings,
    required this.seeder,
    required this.reminders,
    IdentifyRepository? identify,
    AuthRepository? auth,
    this.photos = const PlantPhotoStore(),
  }) : identify = identify ?? resolveIdentifyRepository(),
       auth = auth ?? resolveAuthRepository();

  final CareRepository care;
  final SettingsRepository settings;
  final FixtureSeeder seeder;
  final CareReminderService reminders;
  final IdentifyRepository identify;
  final AuthRepository auth;
  final PlantPhotoStore photos;

  /// Bumped when collection/tasks change so shell tabs can refresh.
  final ValueNotifier<int> dataRevision = ValueNotifier(0);

  void notifyDataChanged() {
    dataRevision.value++;
    // Fire-and-forget reconcile so Today/add-plant keep notifications aligned.
    reminders.reconcile();
  }

  /// Clears SQLite care data, preferences, photos, and scheduled reminders.
  /// Leaves an empty collection (does not reseed sample plants).
  Future<void> deleteAllLocalData() async {
    final plants = await care.listUserPlants();
    await reminders.disableReminders();
    await care.deleteAllData();
    await settings.clearAll();
    for (final plant in plants) {
      await photos.deletePhoto(plant.photoPath);
    }
    notifyDataChanged();
  }

  /// Removes one plant from the collection and reconciles reminders.
  Future<void> deleteUserPlant(String userPlantId) async {
    final plant = await care.getUserPlant(userPlantId);
    await care.deleteUserPlant(userPlantId);
    await photos.deletePhoto(plant?.photoPath);
    notifyDataChanged();
  }

  static Future<BloomServices> bootstrap({
    BloomDatabase? database,
    SharedPreferences? preferences,
    ReminderScheduler? reminderScheduler,
    IdentifyRepository? identify,
    AuthRepository? auth,
    bool seedSampleData = false,
  }) async {
    final db = database ?? BloomDatabase.defaults();
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final settings = SharedPreferencesSettingsRepository(prefs);
    final care = DriftCareRepository(db);
    final seeder = FixtureSeeder(care, settings);
    if (seedSampleData) {
      await seeder.seedIfNeeded();
    }

    void Function()? onMutated;
    final reminders = CareReminderService(
      care: care,
      settings: settings,
      scheduler: reminderScheduler ?? FlutterReminderScheduler(),
      onDataMutated: () => onMutated?.call(),
    );

    final services = BloomServices(
      care: care,
      settings: settings,
      seeder: seeder,
      reminders: reminders,
      identify: identify ?? resolveIdentifyRepository(),
      auth: auth ?? resolveAuthRepository(),
    );
    // Reminder mutators already update schedules; only refresh listening UI.
    onMutated = () => services.dataRevision.value++;

    await reminders.initialize();
    await reminders.reconcile();
    return services;
  }

  /// Test helper that never touches platform notification channels.
  ///
  /// Defaults to seeding sample plants so existing UI tests stay stable.
  /// Pass [seedSampleData]: false for clean-slate first-run coverage.
  static Future<BloomServices> bootstrapForTest({
    BloomDatabase? database,
    SharedPreferences? preferences,
    RecordingReminderScheduler? scheduler,
    IdentifyRepository? identify,
    AuthRepository? auth,
    bool seedSampleData = true,
  }) {
    return bootstrap(
      database: database ?? BloomDatabase.memory(),
      preferences: preferences,
      reminderScheduler: scheduler ?? RecordingReminderScheduler(),
      identify: identify,
      auth: auth ?? DisabledAuthRepository(),
      seedSampleData: seedSampleData,
    );
  }
}

AuthRepository resolveAuthRepository() {
  if (!AuthConfig.isConfigured) {
    return DisabledAuthRepository();
  }
  return SupabaseAuthRepository();
}
