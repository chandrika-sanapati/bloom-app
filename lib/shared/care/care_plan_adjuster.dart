import 'package:bloom/data/domain/plant_environment.dart';
import 'package:bloom/shared/models/fixture_models.dart';

/// Lightly adjusts catalog cadence bands from environment answers.
///
/// Never invents exact volumes. Skipped/default answers leave the base band.
abstract final class CarePlanAdjuster {
  static List<FixtureCarePlanItem> adjust({
    required List<FixtureCarePlanItem> base,
    required PlantEnvironmentAnswers environment,
  }) {
    return [
      for (final item in base)
        FixtureCarePlanItem(
          kind: item.kind,
          title: item.title,
          cadenceLabel: _adjustCadence(item, environment),
          sourceUrl: item.sourceUrl,
          careContentVersion: item.careContentVersion,
        ),
    ];
  }

  static String _adjustCadence(
    FixtureCarePlanItem item,
    PlantEnvironmentAnswers environment,
  ) {
    var label = item.cadenceLabel;

    if (item.kind == CareActionKind.water) {
      final hints = <String>[];
      switch (environment.light) {
        case LightLevel.low:
          hints.add('stretch the gap in low light');
        case LightLevel.brightIndirect:
          hints.add('check sooner in brighter light');
        case LightLevel.medium:
          break;
      }
      switch (environment.climate) {
        case HomeClimate.humid:
          hints.add('slightly less often if humid');
        case HomeClimate.dry:
          hints.add('soil may dry faster in dry air');
        case HomeClimate.average:
          break;
      }
      switch (environment.potting) {
        case PottingSize.large:
          hints.add('large pots dry slower');
        case PottingSize.small:
          hints.add('small pots dry faster');
        case PottingSize.medium:
          break;
      }
      if (hints.isNotEmpty) {
        label = '$label (${hints.join('; ')})';
      }
    }

    if (item.kind == CareActionKind.light &&
        environment.light == LightLevel.low) {
      label =
          '$label — if leaves stretch, move a little closer to a bright window';
    }

    if (environment.experience == ExperienceLevel.novice &&
        item.kind == CareActionKind.water) {
      label =
          '$label. When unsure, wait and check the soil rather than watering '
          'on a fixed day';
    }

    return label;
  }
}
