import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/care/care_plan_merge.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('preserves user-modified cadences across catalog merges', () {
    final existing = [
      const domain.CarePlanItem(
        id: 'plan-water',
        userPlantId: 'plant-1',
        kind: domain.CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Water when leaves droop',
        sortOrder: 0,
        suggestedCadenceLabel: 'When the top of the soil feels dry',
        isUserModified: true,
      ),
      const domain.CarePlanItem(
        id: 'plan-light',
        userPlantId: 'plant-1',
        kind: domain.CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
        sortOrder: 1,
        suggestedCadenceLabel: 'Bright indirect light',
        isUserModified: false,
      ),
    ];

    const catalog = [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Water every 10–14 days when dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium to bright indirect light',
      ),
    ];

    final merged = CarePlanMerge.mergeCatalogSuggestions(
      userPlantId: 'plant-1',
      existing: existing,
      catalog: catalog,
    );

    expect(merged, hasLength(2));
    expect(merged[0].cadenceLabel, 'Water when leaves droop');
    expect(merged[0].isUserModified, isTrue);
    expect(merged[0].suggestedCadenceLabel, catalog[0].cadenceLabel);
    expect(merged[1].cadenceLabel, catalog[1].cadenceLabel);
    expect(merged[1].isUserModified, isFalse);
  });

  test('detects cadence edits against the suggestion', () {
    expect(
      CarePlanMerge.isModifiedRelativeToSuggestion(
        cadenceLabel: 'Custom',
        suggestedCadenceLabel: 'Default',
      ),
      isTrue,
    );
    expect(
      CarePlanMerge.isModifiedRelativeToSuggestion(
        cadenceLabel: 'Default',
        suggestedCadenceLabel: 'Default',
      ),
      isFalse,
    );
  });
}
