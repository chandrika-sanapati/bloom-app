import 'package:flutter/material.dart';

enum CareUrgency { overdue, dueToday, upcoming, done }

enum PlantDifficulty { easy, moderate }

enum CareActionKind { water, fertilise, prune, check, light }

class FixtureCareTask {
  const FixtureCareTask({
    required this.id,
    required this.plantId,
    required this.plantName,
    required this.actionLabel,
    required this.urgency,
    required this.accent,
    this.photoPath,
  });

  final String id;
  final String plantId;
  final String plantName;
  final String actionLabel;
  final CareUrgency urgency;
  final Color accent;
  final String? photoPath;
}

class FixturePlant {
  const FixturePlant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.statusLabel,
    required this.accent,
    required this.overview,
    this.photoPath,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final PlantDifficulty difficulty;
  final String statusLabel;
  final Color accent;
  final String overview;
  final String? photoPath;
}

class FixtureCatalogEntry {
  const FixtureCatalogEntry({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.accent,
    required this.overview,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final PlantDifficulty difficulty;
  final Color accent;
  final String overview;
}

class FixtureCarePlanItem {
  const FixtureCarePlanItem({
    required this.kind,
    required this.title,
    required this.cadenceLabel,
  });

  final CareActionKind kind;
  final String title;

  /// Relative guidance only — no exact volumes.
  final String cadenceLabel;
}

class FixtureCareHistoryEvent {
  const FixtureCareHistoryEvent({
    required this.id,
    required this.plantId,
    required this.kind,
    required this.label,
    required this.occurredOn,
  });

  final String id;
  final String plantId;
  final CareActionKind kind;
  final String label;
  final DateTime occurredOn;
}
