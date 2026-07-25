/// Display/unit preference for care copy (temperature, lengths).
enum MeasurementUnits {
  metric,
  imperial;

  static const MeasurementUnits defaultUnits = MeasurementUnits.metric;

  static MeasurementUnits fromStorage(String? value) {
    return switch (value) {
      'imperial' => MeasurementUnits.imperial,
      _ => MeasurementUnits.metric,
    };
  }

  String get storageValue => name;

  String get label => switch (this) {
    MeasurementUnits.metric => 'Metric (°C, cm)',
    MeasurementUnits.imperial => 'Imperial (°F, in)',
  };
}
