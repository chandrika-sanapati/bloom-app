// Spike domain entities. No persistence-package imports.

enum SpikePlantDifficulty { easy, moderate }

enum SpikeCareUrgency { overdue, dueToday, upcoming, done }

enum SpikeCareActionKind { water, fertilise, prune, check, light }

class SpikePlantSpecies {
  const SpikePlantSpecies({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final SpikePlantDifficulty difficulty;
}

class SpikeUserPlant {
  const SpikeUserPlant({
    required this.id,
    required this.speciesId,
    required this.displayName,
    required this.statusLabel,
    this.notes,
  });

  final String id;
  final String speciesId;
  final String displayName;
  final String statusLabel;

  /// Added in schema v2 migration spike.
  final String? notes;
}

class SpikeCarePlanItem {
  const SpikeCarePlanItem({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.title,
    required this.cadenceLabel,
    required this.sortOrder,
  });

  final String id;
  final String userPlantId;
  final SpikeCareActionKind kind;
  final String title;
  final String cadenceLabel;
  final int sortOrder;
}

class SpikeCareTask {
  const SpikeCareTask({
    required this.id,
    required this.userPlantId,
    required this.actionLabel,
    required this.urgency,
    required this.dueAt,
    required this.isDone,
  });

  final String id;
  final String userPlantId;
  final String actionLabel;
  final SpikeCareUrgency urgency;
  final DateTime dueAt;
  final bool isDone;
}

class SpikeCareEvent {
  const SpikeCareEvent({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.label,
    required this.occurredAt,
  });

  final String id;
  final String userPlantId;
  final SpikeCareActionKind kind;
  final String label;
  final DateTime occurredAt;
}
