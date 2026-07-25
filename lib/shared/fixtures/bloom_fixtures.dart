import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter/material.dart';

/// In-memory sample data for the UI skeleton. Not persisted.
abstract final class BloomFixtures {
  static const tasks = <FixtureCareTask>[
    FixtureCareTask(
      id: 'task-snake-water',
      plantName: 'Snake Plant',
      actionLabel: 'Water',
      urgency: CareUrgency.overdue,
      accent: Color(0xFF6B8F71),
    ),
    FixtureCareTask(
      id: 'task-lily-water',
      plantName: 'Peace Lily',
      actionLabel: 'Water',
      urgency: CareUrgency.dueToday,
      accent: Color(0xFF8FAE8B),
    ),
    FixtureCareTask(
      id: 'task-rubber-fertilise',
      plantName: 'Rubber Plant',
      actionLabel: 'Fertilise (suggested)',
      urgency: CareUrgency.dueToday,
      accent: Color(0xFF5C7A6A),
    ),
    FixtureCareTask(
      id: 'task-monstera-check',
      plantName: 'Monstera',
      actionLabel: 'Check soil moisture',
      urgency: CareUrgency.upcoming,
      accent: Color(0xFF4F7F57),
    ),
  ];

  static const plants = <FixturePlant>[
    FixturePlant(
      id: 'plant-snake',
      commonName: 'Snake Plant',
      scientificName: 'Dracaena trifasciata',
      difficulty: PlantDifficulty.easy,
      statusLabel: 'Needs water',
      accent: Color(0xFF6B8F71),
    ),
    FixturePlant(
      id: 'plant-lily',
      commonName: 'Peace Lily',
      scientificName: 'Spathiphyllum',
      difficulty: PlantDifficulty.easy,
      statusLabel: 'Due today',
      accent: Color(0xFF8FAE8B),
    ),
    FixturePlant(
      id: 'plant-rubber',
      commonName: 'Rubber Plant',
      scientificName: 'Ficus elastica',
      difficulty: PlantDifficulty.moderate,
      statusLabel: 'Healthy',
      accent: Color(0xFF5C7A6A),
    ),
    FixturePlant(
      id: 'plant-monstera',
      commonName: 'Monstera',
      scientificName: 'Monstera deliciosa',
      difficulty: PlantDifficulty.moderate,
      statusLabel: 'Due soon',
      accent: Color(0xFF4F7F57),
    ),
  ];

  static const catalog = <FixtureCatalogEntry>[
    FixtureCatalogEntry(
      id: 'catalog-snake',
      commonName: 'Snake Plant',
      scientificName: 'Dracaena trifasciata',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF6B8F71),
    ),
    FixtureCatalogEntry(
      id: 'catalog-pothos',
      commonName: 'Pothos',
      scientificName: 'Epipremnum aureum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF7BA17D),
    ),
    FixtureCatalogEntry(
      id: 'catalog-aloe',
      commonName: 'Aloe Vera',
      scientificName: 'Aloe barbadensis',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF9BB89A),
    ),
    FixtureCatalogEntry(
      id: 'catalog-monstera',
      commonName: 'Monstera',
      scientificName: 'Monstera deliciosa',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF4F7F57),
    ),
    FixtureCatalogEntry(
      id: 'catalog-rubber',
      commonName: 'Rubber Plant',
      scientificName: 'Ficus elastica',
      difficulty: PlantDifficulty.moderate,
      accent: Color(0xFF5C7A6A),
    ),
    FixtureCatalogEntry(
      id: 'catalog-lily',
      commonName: 'Peace Lily',
      scientificName: 'Spathiphyllum',
      difficulty: PlantDifficulty.easy,
      accent: Color(0xFF8FAE8B),
    ),
  ];

  static Color urgencyColor(CareUrgency urgency) {
    return switch (urgency) {
      CareUrgency.overdue => BloomColors.statusOverdue,
      CareUrgency.dueToday => BloomColors.statusDueToday,
      CareUrgency.upcoming => BloomColors.labelTertiary,
      CareUrgency.done => BloomColors.statusHealthy,
    };
  }

  static String urgencyLabel(CareUrgency urgency) {
    return switch (urgency) {
      CareUrgency.overdue => 'Overdue',
      CareUrgency.dueToday => 'Due today',
      CareUrgency.upcoming => 'Upcoming',
      CareUrgency.done => 'Done',
    };
  }

  static IconData urgencyIcon(CareUrgency urgency) {
    return switch (urgency) {
      CareUrgency.overdue => Icons.warning_amber_rounded,
      CareUrgency.dueToday => Icons.schedule,
      CareUrgency.upcoming => Icons.event_outlined,
      CareUrgency.done => Icons.check_circle_outline,
    };
  }

  static String difficultyLabel(PlantDifficulty difficulty) {
    return switch (difficulty) {
      PlantDifficulty.easy => 'Easy',
      PlantDifficulty.moderate => 'Moderate',
    };
  }
}
