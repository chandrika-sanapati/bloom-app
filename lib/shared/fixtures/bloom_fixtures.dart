import 'package:bloom/app/theme/bloom_colors.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter/material.dart';

/// In-memory sample data for the UI skeleton. Not persisted.
abstract final class BloomFixtures {
  static const tasks = <FixtureCareTask>[
    FixtureCareTask(
      id: 'task-snake-water',
      plantId: 'plant-snake',
      plantName: 'Snake Plant',
      actionLabel: 'Water',
      urgency: CareUrgency.overdue,
      accent: Color(0xFF6B8F71),
    ),
    FixtureCareTask(
      id: 'task-lily-water',
      plantId: 'plant-lily',
      plantName: 'Peace Lily',
      actionLabel: 'Water',
      urgency: CareUrgency.dueToday,
      accent: Color(0xFF8FAE8B),
    ),
    FixtureCareTask(
      id: 'task-rubber-fertilise',
      plantId: 'plant-rubber',
      plantName: 'Rubber Plant',
      actionLabel: 'Fertilise (suggested)',
      urgency: CareUrgency.dueToday,
      accent: Color(0xFF5C7A6A),
    ),
    FixtureCareTask(
      id: 'task-monstera-check',
      plantId: 'plant-monstera',
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
      overview:
          'A hardy houseplant with stiff, upright leaves. It prefers bright '
          'indirect light and forgiving watering habits — let the soil dry '
          'between drinks.',
    ),
    FixturePlant(
      id: 'plant-lily',
      commonName: 'Peace Lily',
      scientificName: 'Spathiphyllum',
      difficulty: PlantDifficulty.easy,
      statusLabel: 'Due today',
      accent: Color(0xFF8FAE8B),
      overview:
          'Known for glossy leaves and white blooms. Enjoys evenly moist soil '
          'and medium light; drooping leaves often mean it is thirsty.',
    ),
    FixturePlant(
      id: 'plant-rubber',
      commonName: 'Rubber Plant',
      scientificName: 'Ficus elastica',
      difficulty: PlantDifficulty.moderate,
      statusLabel: 'Healthy',
      accent: Color(0xFF5C7A6A),
      overview:
          'A bold indoor tree with thick, shiny leaves. Prefers bright '
          'indirect light and moderate watering once the top soil feels dry.',
    ),
    FixturePlant(
      id: 'plant-monstera',
      commonName: 'Monstera',
      scientificName: 'Monstera deliciosa',
      difficulty: PlantDifficulty.moderate,
      statusLabel: 'Due soon',
      accent: Color(0xFF4F7F57),
      overview:
          'Famous for split leaves. Likes bright indirect light, support to '
          'climb, and watering when the top of the soil has dried out.',
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

  static const carePlans = <String, List<FixtureCarePlanItem>>{
    'plant-snake': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When soil is fully dry — often every 2–3 weeks',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Low to bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Light feed in spring and summer (suggested)',
      ),
    ],
    'plant-lily': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'Keep soil lightly moist; water when leaves droop',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Medium, indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.prune,
        title: 'Prune',
        cadenceLabel: 'Remove spent blooms and yellow leaves as needed',
      ),
    ],
    'plant-rubber': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top soil feels dry',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.fertilise,
        title: 'Fertilise',
        cadenceLabel: 'Monthly in growing season (suggested)',
      ),
    ],
    'plant-monstera': [
      FixtureCarePlanItem(
        kind: CareActionKind.water,
        title: 'Water',
        cadenceLabel: 'When the top of the soil has dried out',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.light,
        title: 'Light',
        cadenceLabel: 'Bright indirect light',
      ),
      FixtureCarePlanItem(
        kind: CareActionKind.check,
        title: 'Support',
        cadenceLabel: 'Provide a stake or moss pole as it climbs',
      ),
    ],
  };

  static final history = <FixtureCareHistoryEvent>[
    FixtureCareHistoryEvent(
      id: 'hist-snake-1',
      plantId: 'plant-snake',
      kind: CareActionKind.water,
      label: 'Watered',
      occurredOn: DateTime(2026, 7, 18),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-snake-2',
      plantId: 'plant-snake',
      kind: CareActionKind.check,
      label: 'Checked soil',
      occurredOn: DateTime(2026, 7, 10),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-snake-3',
      plantId: 'plant-snake',
      kind: CareActionKind.fertilise,
      label: 'Fertilised (suggested)',
      occurredOn: DateTime(2026, 6, 22),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-lily-1',
      plantId: 'plant-lily',
      kind: CareActionKind.water,
      label: 'Watered',
      occurredOn: DateTime(2026, 7, 20),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-lily-2',
      plantId: 'plant-lily',
      kind: CareActionKind.prune,
      label: 'Removed yellow leaf',
      occurredOn: DateTime(2026, 7, 12),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-rubber-1',
      plantId: 'plant-rubber',
      kind: CareActionKind.water,
      label: 'Watered',
      occurredOn: DateTime(2026, 7, 15),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-monstera-1',
      plantId: 'plant-monstera',
      kind: CareActionKind.water,
      label: 'Watered',
      occurredOn: DateTime(2026, 7, 16),
    ),
    FixtureCareHistoryEvent(
      id: 'hist-monstera-2',
      plantId: 'plant-monstera',
      kind: CareActionKind.check,
      label: 'Checked soil moisture',
      occurredOn: DateTime(2026, 7, 8),
    ),
  ];

  static FixturePlant? plantById(String id) {
    for (final plant in plants) {
      if (plant.id == id) {
        return plant;
      }
    }
    return null;
  }

  static List<FixtureCareTask> tasksForPlant(String plantId) {
    return tasks.where((task) => task.plantId == plantId).toList();
  }

  static List<FixtureCarePlanItem> carePlanForPlant(String plantId) {
    return carePlans[plantId] ?? const [];
  }

  static List<FixtureCareHistoryEvent> historyForPlant(String plantId) {
    final events = history.where((event) => event.plantId == plantId).toList()
      ..sort((a, b) => b.occurredOn.compareTo(a.occurredOn));
    return events;
  }

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

  static IconData careActionIcon(CareActionKind kind) {
    return switch (kind) {
      CareActionKind.water => Icons.water_drop_outlined,
      CareActionKind.fertilise => Icons.compost_outlined,
      CareActionKind.prune => Icons.content_cut,
      CareActionKind.check => Icons.touch_app_outlined,
      CareActionKind.light => Icons.wb_sunny_outlined,
    };
  }

  static Color careActionColor(CareActionKind kind) {
    return switch (kind) {
      CareActionKind.water => BloomColors.statusInfo,
      CareActionKind.fertilise => BloomColors.brandGreen,
      CareActionKind.prune => BloomColors.statusHealthy,
      CareActionKind.check => BloomColors.labelTertiary,
      CareActionKind.light => BloomColors.statusDueToday,
    };
  }
}
