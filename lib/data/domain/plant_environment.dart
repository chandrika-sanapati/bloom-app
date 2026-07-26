/// Environment answers that may adjust suggested care cadences.
///
/// Locked knobs: [`docs/phase2/CARE_CONTENT_DECISION.md`].
enum LightLevel { low, medium, brightIndirect }

enum HomeClimate { dry, average, humid }

enum PottingSize { small, medium, large }

enum ExperienceLevel { novice, someExperience }

class PlantEnvironmentAnswers {
  const PlantEnvironmentAnswers({
    this.light = LightLevel.medium,
    this.climate = HomeClimate.average,
    this.potting = PottingSize.medium,
    this.experience = ExperienceLevel.someExperience,
  });

  final LightLevel light;
  final HomeClimate climate;
  final PottingSize potting;
  final ExperienceLevel experience;

  static const defaults = PlantEnvironmentAnswers();

  bool get isDefault =>
      light == LightLevel.medium &&
      climate == HomeClimate.average &&
      potting == PottingSize.medium &&
      experience == ExperienceLevel.someExperience;

  PlantEnvironmentAnswers copyWith({
    LightLevel? light,
    HomeClimate? climate,
    PottingSize? potting,
    ExperienceLevel? experience,
  }) {
    return PlantEnvironmentAnswers(
      light: light ?? this.light,
      climate: climate ?? this.climate,
      potting: potting ?? this.potting,
      experience: experience ?? this.experience,
    );
  }

  static LightLevel? lightFromWire(String? value) =>
      _enumFromWire(LightLevel.values, value);

  static HomeClimate? climateFromWire(String? value) =>
      _enumFromWire(HomeClimate.values, value);

  static PottingSize? pottingFromWire(String? value) =>
      _enumFromWire(PottingSize.values, value);

  static ExperienceLevel? experienceFromWire(String? value) =>
      _enumFromWire(ExperienceLevel.values, value);

  static T? _enumFromWire<T extends Enum>(List<T> values, String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    for (final item in values) {
      if (item.name == value) {
        return item;
      }
    }
    return null;
  }
}

String lightLevelLabel(LightLevel value) {
  return switch (value) {
    LightLevel.low => 'Low light',
    LightLevel.medium => 'Medium light',
    LightLevel.brightIndirect => 'Bright indirect',
  };
}

String homeClimateLabel(HomeClimate value) {
  return switch (value) {
    HomeClimate.dry => 'Dry',
    HomeClimate.average => 'Average',
    HomeClimate.humid => 'Humid',
  };
}

String pottingSizeLabel(PottingSize value) {
  return switch (value) {
    PottingSize.small => 'Small pot',
    PottingSize.medium => 'Medium pot',
    PottingSize.large => 'Large pot',
  };
}

String experienceLevelLabel(ExperienceLevel value) {
  return switch (value) {
    ExperienceLevel.novice => 'New to plants',
    ExperienceLevel.someExperience => 'Some experience',
  };
}
