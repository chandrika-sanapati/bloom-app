// Local-first domain entities. No persistence-package imports.

enum PlantDifficulty { easy, moderate }

enum CareUrgency { overdue, dueToday, upcoming, done }

enum CareActionKind { water, fertilise, prune, check, light }

class PlantSpecies {
  const PlantSpecies({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.overview,
    required this.accentArgb,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final PlantDifficulty difficulty;
  final String overview;
  final int accentArgb;
}

class UserPlant {
  const UserPlant({
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
  final String? notes;
}

class CarePlanItem {
  const CarePlanItem({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.title,
    required this.cadenceLabel,
    required this.sortOrder,
  });

  final String id;
  final String userPlantId;
  final CareActionKind kind;
  final String title;
  final String cadenceLabel;
  final int sortOrder;
}

class CareTask {
  const CareTask({
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
  final CareUrgency urgency;
  final DateTime dueAt;
  final bool isDone;
}

class CareEvent {
  const CareEvent({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.label,
    required this.occurredAt,
  });

  final String id;
  final String userPlantId;
  final CareActionKind kind;
  final String label;
  final DateTime occurredAt;
}

/// User plant joined with its species for collection/detail UI.
class UserPlantRecord {
  const UserPlantRecord({required this.plant, required this.species});

  final UserPlant plant;
  final PlantSpecies species;
}
