import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/settings_repository.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/local/drift/drift_care_repository.dart';
import 'package:bloom/data/local/fixture_seeder.dart';
import 'package:bloom/data/local/shared_preferences_settings_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BloomServices {
  BloomServices({
    required this.care,
    required this.settings,
    required this.seeder,
  });

  final CareRepository care;
  final SettingsRepository settings;
  final FixtureSeeder seeder;

  /// Bumped when collection/tasks change so shell tabs can refresh.
  final ValueNotifier<int> dataRevision = ValueNotifier(0);

  void notifyDataChanged() {
    dataRevision.value++;
  }

  static Future<BloomServices> bootstrap({
    BloomDatabase? database,
    SharedPreferences? preferences,
  }) async {
    final db = database ?? BloomDatabase.defaults();
    final prefs = preferences ?? await SharedPreferences.getInstance();
    final settings = SharedPreferencesSettingsRepository(prefs);
    final care = DriftCareRepository(db);
    final seeder = FixtureSeeder(care, settings);
    await seeder.seedIfNeeded();
    return BloomServices(care: care, settings: settings, seeder: seeder);
  }
}
