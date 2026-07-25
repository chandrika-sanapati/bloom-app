import 'package:bloom/data/local/shared_preferences_settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('round-trips units, reminders, and seed flag', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = SharedPreferencesSettingsRepository(prefs);

    expect(await repo.getUnits(), isNull);
    expect(await repo.getRemindersEnabled(), isFalse);
    expect(await repo.getHasSeededSampleData(), isFalse);

    await repo.setUnits('metric');
    await repo.setRemindersEnabled(false);
    await repo.setHasSeededSampleData(true);

    expect(await repo.getUnits(), 'metric');
    expect(await repo.getRemindersEnabled(), isFalse);
    expect(await repo.getHasSeededSampleData(), isTrue);

    await repo.clearAll();
    expect(await repo.getUnits(), isNull);
    expect(await repo.getRemindersEnabled(), isFalse);
    expect(await repo.getHasSeededSampleData(), isFalse);
  });
}
