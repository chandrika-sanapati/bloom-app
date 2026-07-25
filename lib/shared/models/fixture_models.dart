import 'package:flutter/material.dart';

enum CareUrgency { overdue, dueToday, upcoming, done }

enum PlantDifficulty { easy, moderate }

class FixtureCareTask {
  const FixtureCareTask({
    required this.id,
    required this.plantName,
    required this.actionLabel,
    required this.urgency,
    required this.accent,
  });

  final String id;
  final String plantName;
  final String actionLabel;
  final CareUrgency urgency;
  final Color accent;
}

class FixturePlant {
  const FixturePlant({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.statusLabel,
    required this.accent,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final PlantDifficulty difficulty;
  final String statusLabel;
  final Color accent;
}

class FixtureCatalogEntry {
  const FixtureCatalogEntry({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.accent,
  });

  final String id;
  final String commonName;
  final String scientificName;
  final PlantDifficulty difficulty;
  final Color accent;
}
