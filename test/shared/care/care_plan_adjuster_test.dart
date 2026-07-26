import 'package:bloom/data/domain/plant_environment.dart';
import 'package:bloom/shared/care/care_plan_adjuster.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const base = [
    FixtureCarePlanItem(
      kind: CareActionKind.water,
      title: 'Water',
      cadenceLabel: 'When the top of the soil feels dry',
    ),
    FixtureCarePlanItem(
      kind: CareActionKind.light,
      title: 'Light',
      cadenceLabel: 'Bright indirect light',
    ),
  ];

  test('default environment keeps catalog cadence bands', () {
    final adjusted = CarePlanAdjuster.adjust(
      base: base,
      environment: PlantEnvironmentAnswers.defaults,
    );

    expect(adjusted[0].cadenceLabel, base[0].cadenceLabel);
    expect(adjusted[1].cadenceLabel, base[1].cadenceLabel);
  });

  test('low light and humid climate stretch watering guidance', () {
    final adjusted = CarePlanAdjuster.adjust(
      base: base,
      environment: const PlantEnvironmentAnswers(
        light: LightLevel.low,
        climate: HomeClimate.humid,
        potting: PottingSize.large,
        experience: ExperienceLevel.novice,
      ),
    );

    expect(adjusted[0].cadenceLabel, contains('stretch the gap in low light'));
    expect(adjusted[0].cadenceLabel, contains('slightly less often if humid'));
    expect(adjusted[0].cadenceLabel, contains('large pots dry slower'));
    expect(adjusted[0].cadenceLabel, contains('check the soil'));
    expect(adjusted[1].cadenceLabel, contains('move a little closer'));
  });
}
