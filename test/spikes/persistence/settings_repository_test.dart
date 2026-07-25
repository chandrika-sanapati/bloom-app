import 'package:bloom/spikes/persistence/data/shared_preferences_settings_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('round-trips units and reminders preference keys', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final repo = SharedPreferencesSettingsRepository(prefs);

    expect(await repo.getUnits(), isNull);
    expect(await repo.getRemindersEnabled(), isTrue);

    await repo.setUnits('metric');
    await repo.setRemindersEnabled(false);

    expect(await repo.getUnits(), 'metric');
    expect(await repo.getRemindersEnabled(), isFalse);
  });
}
