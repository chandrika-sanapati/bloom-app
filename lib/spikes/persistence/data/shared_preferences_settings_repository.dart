import 'package:bloom/spikes/persistence/domain/settings_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesSettingsRepository implements SettingsRepository {
  SharedPreferencesSettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _unitsKey = 'bloom.spike.units';
  static const _remindersKey = 'bloom.spike.reminders_enabled';

  @override
  Future<String?> getUnits() async => _prefs.getString(_unitsKey);

  @override
  Future<void> setUnits(String units) async {
    await _prefs.setString(_unitsKey, units);
  }

  @override
  Future<bool> getRemindersEnabled() async {
    return _prefs.getBool(_remindersKey) ?? true;
  }

  @override
  Future<void> setRemindersEnabled(bool enabled) async {
    await _prefs.setBool(_remindersKey, enabled);
  }
}
