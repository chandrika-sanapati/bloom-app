/// Non-relational settings only (not care tasks or history).
abstract interface class SettingsRepository {
  Future<String?> getUnits();

  Future<void> setUnits(String units);

  Future<bool> getRemindersEnabled();

  Future<void> setRemindersEnabled(bool enabled);

  /// True after the first-plan reminder prompt (accept or decline).
  Future<bool> getHasPromptedCareReminders();

  Future<void> setHasPromptedCareReminders(bool value);

  Future<bool> getHasSeededSampleData();

  Future<void> setHasSeededSampleData(bool value);

  /// Removes Bloom preference keys (units, reminders, seed flag).
  Future<void> clearAll();
}
