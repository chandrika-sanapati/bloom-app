import 'package:bloom/data/domain/entities.dart';
import 'package:bloom/data/domain/plant_environment.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';

PlantDifficulty difficultyFromDb(int value) => PlantDifficulty.values[value];

int difficultyToDb(PlantDifficulty value) => value.index;

CareUrgency urgencyFromDb(int value) => CareUrgency.values[value];

int urgencyToDb(CareUrgency value) => value.index;

CareActionKind actionKindFromDb(int value) => CareActionKind.values[value];

int actionKindToDb(CareActionKind value) => value.index;

PlantSpecies mapSpecies(PlantSpeciesRow row) {
  return PlantSpecies(
    id: row.id,
    commonName: row.commonName,
    scientificName: row.scientificName,
    difficulty: difficultyFromDb(row.difficulty),
    overview: row.overview,
    accentArgb: row.accentArgb,
  );
}

UserPlant mapUserPlant(UserPlantRow row) {
  return UserPlant(
    id: row.id,
    speciesId: row.speciesId,
    displayName: row.displayName,
    statusLabel: row.statusLabel,
    notes: row.notes,
    lightLevel: PlantEnvironmentAnswers.lightFromWire(row.lightLevel),
    homeClimate: PlantEnvironmentAnswers.climateFromWire(row.homeClimate),
    pottingSize: PlantEnvironmentAnswers.pottingFromWire(row.pottingSize),
    experienceLevel: PlantEnvironmentAnswers.experienceFromWire(
      row.experienceLevel,
    ),
    photoPath: row.photoPath,
  );
}

CarePlanItem mapCarePlanItem(CarePlanItemRow row) {
  return CarePlanItem(
    id: row.id,
    userPlantId: row.userPlantId,
    kind: actionKindFromDb(row.kind),
    title: row.title,
    cadenceLabel: row.cadenceLabel,
    sortOrder: row.sortOrder,
    suggestedCadenceLabel: row.suggestedCadenceLabel,
    isUserModified: row.isUserModified,
  );
}

CareTask mapCareTask(CareTaskRow row) {
  return CareTask(
    id: row.id,
    userPlantId: row.userPlantId,
    actionLabel: row.actionLabel,
    urgency: urgencyFromDb(row.urgency),
    dueAt: row.dueAt,
    isDone: row.isDone,
  );
}

CareEvent mapCareEvent(CareEventRow row) {
  return CareEvent(
    id: row.id,
    userPlantId: row.userPlantId,
    kind: actionKindFromDb(row.kind),
    label: row.label,
    occurredAt: row.occurredAt,
  );
}
