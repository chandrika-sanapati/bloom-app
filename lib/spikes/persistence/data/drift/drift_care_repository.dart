import 'package:bloom/spikes/persistence/data/drift/bloom_spike_database.dart';
import 'package:bloom/spikes/persistence/data/drift/mappers.dart';
import 'package:bloom/spikes/persistence/domain/care_repository.dart';
import 'package:bloom/spikes/persistence/domain/entities.dart';
import 'package:drift/drift.dart';

class DriftCareRepository implements CareRepository {
  DriftCareRepository(this._db);

  final BloomSpikeDatabase _db;

  @override
  Future<void> upsertSpecies(SpikePlantSpecies species) {
    return _db
        .into(_db.plantSpeciesRows)
        .insertOnConflictUpdate(
          PlantSpeciesRowsCompanion.insert(
            id: species.id,
            commonName: species.commonName,
            scientificName: species.scientificName,
            difficulty: difficultyToDb(species.difficulty),
          ),
        );
  }

  @override
  Future<SpikePlantSpecies?> getSpecies(String id) async {
    final row = await (_db.select(
      _db.plantSpeciesRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapSpecies(row);
  }

  @override
  Future<void> upsertUserPlant(SpikeUserPlant plant) {
    return _db
        .into(_db.userPlantRows)
        .insertOnConflictUpdate(
          UserPlantRowsCompanion.insert(
            id: plant.id,
            speciesId: plant.speciesId,
            displayName: plant.displayName,
            statusLabel: plant.statusLabel,
            notes: Value(plant.notes),
          ),
        );
  }

  @override
  Future<SpikeUserPlant?> getUserPlant(String id) async {
    final row = await (_db.select(
      _db.userPlantRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapUserPlant(row);
  }

  @override
  Future<List<SpikeUserPlant>> listUserPlants() async {
    final rows = await _db.select(_db.userPlantRows).get();
    return rows.map(mapUserPlant).toList();
  }

  @override
  Future<void> replaceCarePlan({
    required String userPlantId,
    required List<SpikeCarePlanItem> items,
  }) {
    return _db.transaction(() async {
      await (_db.delete(
        _db.carePlanItemRows,
      )..where((t) => t.userPlantId.equals(userPlantId))).go();
      for (final item in items) {
        await _db
            .into(_db.carePlanItemRows)
            .insert(
              CarePlanItemRowsCompanion.insert(
                id: item.id,
                userPlantId: item.userPlantId,
                kind: actionKindToDb(item.kind),
                title: item.title,
                cadenceLabel: item.cadenceLabel,
                sortOrder: item.sortOrder,
              ),
            );
      }
    });
  }

  @override
  Future<List<SpikeCarePlanItem>> getCarePlan(String userPlantId) async {
    final rows =
        await (_db.select(_db.carePlanItemRows)
              ..where((t) => t.userPlantId.equals(userPlantId))
              ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
            .get();
    return rows.map(mapCarePlanItem).toList();
  }

  @override
  Future<void> upsertCareTask(SpikeCareTask task) {
    return _db
        .into(_db.careTaskRows)
        .insertOnConflictUpdate(
          CareTaskRowsCompanion.insert(
            id: task.id,
            userPlantId: task.userPlantId,
            actionLabel: task.actionLabel,
            urgency: urgencyToDb(task.urgency),
            dueAt: task.dueAt,
            isDone: Value(task.isDone),
          ),
        );
  }

  @override
  Future<SpikeCareTask?> getCareTask(String id) async {
    final row = await (_db.select(
      _db.careTaskRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapCareTask(row);
  }

  @override
  Future<List<SpikeCareTask>> listOpenTasksForToday() async {
    final rows =
        await (_db.select(_db.careTaskRows)
              ..where((t) => t.isDone.equals(false))
              ..orderBy([
                (t) => OrderingTerm.asc(t.urgency),
                (t) => OrderingTerm.asc(t.dueAt),
              ]))
            .get();
    return rows.map(mapCareTask).toList();
  }

  @override
  Future<void> addCareEvent(SpikeCareEvent event) {
    return _db
        .into(_db.careEventRows)
        .insert(
          CareEventRowsCompanion.insert(
            id: event.id,
            userPlantId: event.userPlantId,
            kind: actionKindToDb(event.kind),
            label: event.label,
            occurredAt: event.occurredAt,
          ),
        );
  }

  @override
  Future<List<SpikeCareEvent>> listCareEvents(String userPlantId) async {
    final rows =
        await (_db.select(_db.careEventRows)
              ..where((t) => t.userPlantId.equals(userPlantId))
              ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
            .get();
    return rows.map(mapCareEvent).toList();
  }

  @override
  Future<void> close() => _db.close();
}
