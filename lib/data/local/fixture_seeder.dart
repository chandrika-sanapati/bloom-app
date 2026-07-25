import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/data/domain/settings_repository.dart';
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';

/// Seeds sample collection data once so the UI is explorable offline.
class FixtureSeeder {
  FixtureSeeder(this._care, this._settings);

  final CareRepository _care;
  final SettingsRepository _settings;

  Future<void> seedIfNeeded() async {
    if (await _settings.getHasSeededSampleData()) {
      return;
    }
    final existing = await _care.listUserPlants();
    if (existing.isNotEmpty) {
      await _settings.setHasSeededSampleData(true);
      return;
    }
    await seedAll();
    await _settings.setHasSeededSampleData(true);
  }

  Future<void> seedAll() async {
    for (final plant in BloomFixtures.plants) {
      final speciesId = 'species-${plant.id}';
      await _care.upsertSpecies(
        domain.PlantSpecies(
          id: speciesId,
          commonName: plant.commonName,
          scientificName: plant.scientificName,
          difficulty: _difficulty(plant.difficulty),
          overview: plant.overview,
          accentArgb: plant.accent.toARGB32(),
        ),
      );
      await _care.upsertUserPlant(
        domain.UserPlant(
          id: plant.id,
          speciesId: speciesId,
          displayName: plant.commonName,
          statusLabel: plant.statusLabel,
        ),
      );

      final planItems = BloomFixtures.carePlanForPlant(plant.id);
      await _care.replaceCarePlan(
        userPlantId: plant.id,
        items: [
          for (var i = 0; i < planItems.length; i++)
            domain.CarePlanItem(
              id: 'plan-${plant.id}-$i',
              userPlantId: plant.id,
              kind: _actionKind(planItems[i].kind),
              title: planItems[i].title,
              cadenceLabel: planItems[i].cadenceLabel,
              sortOrder: i,
            ),
        ],
      );
    }

    final now = DateTime.now();
    for (final task in BloomFixtures.tasks) {
      await _care.upsertCareTask(
        domain.CareTask(
          id: task.id,
          userPlantId: task.plantId,
          actionLabel: task.actionLabel,
          urgency: _urgency(task.urgency),
          dueAt: _dueAt(task.urgency, now),
          isDone: false,
        ),
      );
    }

    for (final event in BloomFixtures.history) {
      await _care.addCareEvent(
        domain.CareEvent(
          id: event.id,
          userPlantId: event.plantId,
          kind: _actionKind(event.kind),
          label: event.label,
          occurredAt: event.occurredOn,
        ),
      );
    }
  }

  /// Re-opens the sample Today tasks (marks them not done).
  Future<void> restoreSampleTasks() async {
    final now = DateTime.now();
    for (final task in BloomFixtures.tasks) {
      await _care.upsertCareTask(
        domain.CareTask(
          id: task.id,
          userPlantId: task.plantId,
          actionLabel: task.actionLabel,
          urgency: _urgency(task.urgency),
          dueAt: _dueAt(task.urgency, now),
          isDone: false,
        ),
      );
    }
  }

  static domain.PlantDifficulty _difficulty(PlantDifficulty value) {
    return switch (value) {
      PlantDifficulty.easy => domain.PlantDifficulty.easy,
      PlantDifficulty.moderate => domain.PlantDifficulty.moderate,
    };
  }

  static domain.CareUrgency _urgency(CareUrgency value) {
    return switch (value) {
      CareUrgency.overdue => domain.CareUrgency.overdue,
      CareUrgency.dueToday => domain.CareUrgency.dueToday,
      CareUrgency.upcoming => domain.CareUrgency.upcoming,
      CareUrgency.done => domain.CareUrgency.done,
    };
  }

  static domain.CareActionKind _actionKind(CareActionKind value) {
    return switch (value) {
      CareActionKind.water => domain.CareActionKind.water,
      CareActionKind.fertilise => domain.CareActionKind.fertilise,
      CareActionKind.prune => domain.CareActionKind.prune,
      CareActionKind.check => domain.CareActionKind.check,
      CareActionKind.light => domain.CareActionKind.light,
    };
  }

  static DateTime _dueAt(CareUrgency urgency, DateTime now) {
    return switch (urgency) {
      CareUrgency.overdue => now.subtract(const Duration(days: 1)),
      CareUrgency.dueToday => now,
      CareUrgency.upcoming => now.add(const Duration(days: 3)),
      CareUrgency.done => now.subtract(const Duration(days: 2)),
    };
  }
}
