import 'package:bloom/spikes/persistence/data/drift/bloom_spike_database.dart';
import 'package:bloom/spikes/persistence/domain/entities.dart';

SpikePlantDifficulty difficultyFromDb(int value) =>
    SpikePlantDifficulty.values[value];

int difficultyToDb(SpikePlantDifficulty value) => value.index;

SpikeCareUrgency urgencyFromDb(int value) => SpikeCareUrgency.values[value];

int urgencyToDb(SpikeCareUrgency value) => value.index;

SpikeCareActionKind actionKindFromDb(int value) =>
    SpikeCareActionKind.values[value];

int actionKindToDb(SpikeCareActionKind value) => value.index;

SpikePlantSpecies mapSpecies(PlantSpeciesRow row) {
  return SpikePlantSpecies(
    id: row.id,
    commonName: row.commonName,
    scientificName: row.scientificName,
    difficulty: difficultyFromDb(row.difficulty),
  );
}

SpikeUserPlant mapUserPlant(UserPlantRow row) {
  return SpikeUserPlant(
    id: row.id,
    speciesId: row.speciesId,
    displayName: row.displayName,
    statusLabel: row.statusLabel,
    notes: row.notes,
  );
}

SpikeCarePlanItem mapCarePlanItem(CarePlanItemRow row) {
  return SpikeCarePlanItem(
    id: row.id,
    userPlantId: row.userPlantId,
    kind: actionKindFromDb(row.kind),
    title: row.title,
    cadenceLabel: row.cadenceLabel,
    sortOrder: row.sortOrder,
  );
}

SpikeCareTask mapCareTask(CareTaskRow row) {
  return SpikeCareTask(
    id: row.id,
    userPlantId: row.userPlantId,
    actionLabel: row.actionLabel,
    urgency: urgencyFromDb(row.urgency),
    dueAt: row.dueAt,
    isDone: row.isDone,
  );
}

SpikeCareEvent mapCareEvent(CareEventRow row) {
  return SpikeCareEvent(
    id: row.id,
    userPlantId: row.userPlantId,
    kind: actionKindFromDb(row.kind),
    label: row.label,
    occurredAt: row.occurredAt,
  );
}
