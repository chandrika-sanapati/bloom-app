import 'package:bloom/data/domain/entities.dart' as domain;
import 'package:bloom/shared/fixtures/bloom_fixtures.dart';
import 'package:bloom/shared/models/fixture_models.dart';
import 'package:flutter/material.dart';

FixtureCareTask toFixtureTask({
  required domain.CareTask task,
  required String plantName,
  required Color accent,
}) {
  return FixtureCareTask(
    id: task.id,
    plantId: task.userPlantId,
    plantName: plantName,
    actionLabel: task.actionLabel,
    urgency: toFixtureUrgency(
      task.isDone ? domain.CareUrgency.done : task.urgency,
    ),
    accent: accent,
  );
}

FixturePlant toFixturePlant(domain.UserPlantRecord record) {
  return FixturePlant(
    id: record.plant.id,
    commonName: record.plant.displayName,
    scientificName: record.species.scientificName,
    difficulty: toFixtureDifficulty(record.species.difficulty),
    statusLabel: record.plant.statusLabel,
    accent: Color(record.species.accentArgb),
    overview: record.species.overview,
  );
}

FixtureCarePlanItem toFixturePlanItem(domain.CarePlanItem item) {
  return FixtureCarePlanItem(
    kind: toFixtureActionKind(item.kind),
    title: item.title,
    cadenceLabel: item.cadenceLabel,
  );
}

FixtureCareHistoryEvent toFixtureHistoryEvent(domain.CareEvent event) {
  return FixtureCareHistoryEvent(
    id: event.id,
    plantId: event.userPlantId,
    kind: toFixtureActionKind(event.kind),
    label: event.label,
    occurredOn: event.occurredAt,
  );
}

CareUrgency toFixtureUrgency(domain.CareUrgency value) {
  return switch (value) {
    domain.CareUrgency.overdue => CareUrgency.overdue,
    domain.CareUrgency.dueToday => CareUrgency.dueToday,
    domain.CareUrgency.upcoming => CareUrgency.upcoming,
    domain.CareUrgency.done => CareUrgency.done,
  };
}

PlantDifficulty toFixtureDifficulty(domain.PlantDifficulty value) {
  return switch (value) {
    domain.PlantDifficulty.easy => PlantDifficulty.easy,
    domain.PlantDifficulty.moderate => PlantDifficulty.moderate,
  };
}

CareActionKind toFixtureActionKind(domain.CareActionKind value) {
  return switch (value) {
    domain.CareActionKind.water => CareActionKind.water,
    domain.CareActionKind.fertilise => CareActionKind.fertilise,
    domain.CareActionKind.prune => CareActionKind.prune,
    domain.CareActionKind.check => CareActionKind.check,
    domain.CareActionKind.light => CareActionKind.light,
  };
}

String difficultyLabel(domain.PlantDifficulty difficulty) {
  return BloomFixtures.difficultyLabel(toFixtureDifficulty(difficulty));
}
