import 'package:bloom/data/domain/care_repository.dart';
import 'package:bloom/data/domain/entities.dart';
import 'package:bloom/data/local/drift/bloom_database.dart';
import 'package:bloom/data/local/drift/mappers.dart';
import 'package:drift/drift.dart';

class DriftCareRepository implements CareRepository {
  DriftCareRepository(this._db);

  final BloomDatabase _db;

  @override
  Future<void> upsertSpecies(PlantSpecies species) {
    return _db
        .into(_db.plantSpeciesRows)
        .insertOnConflictUpdate(
          PlantSpeciesRowsCompanion.insert(
            id: species.id,
            commonName: species.commonName,
            scientificName: species.scientificName,
            difficulty: difficultyToDb(species.difficulty),
            overview: Value(species.overview),
            accentArgb: Value(species.accentArgb),
          ),
        );
  }

  @override
  Future<PlantSpecies?> getSpecies(String id) async {
    final row = await (_db.select(
      _db.plantSpeciesRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapSpecies(row);
  }

  @override
  Future<void> upsertUserPlant(UserPlant plant) {
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
  Future<UserPlant?> getUserPlant(String id) async {
    final row = await (_db.select(
      _db.userPlantRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapUserPlant(row);
  }

  @override
  Future<List<UserPlant>> listUserPlants() async {
    final rows = await _db.select(_db.userPlantRows).get();
    return rows.map(mapUserPlant).toList();
  }

  @override
  Future<List<UserPlantRecord>> listUserPlantRecords() async {
    final query = _db.select(_db.userPlantRows).join([
      innerJoin(
        _db.plantSpeciesRows,
        _db.plantSpeciesRows.id.equalsExp(_db.userPlantRows.speciesId),
      ),
    ]);
    final rows = await query.get();
    return rows.map((row) {
      return UserPlantRecord(
        plant: mapUserPlant(row.readTable(_db.userPlantRows)),
        species: mapSpecies(row.readTable(_db.plantSpeciesRows)),
      );
    }).toList();
  }

  @override
  Future<UserPlantRecord?> getUserPlantRecord(String userPlantId) async {
    final query = _db.select(_db.userPlantRows).join([
      innerJoin(
        _db.plantSpeciesRows,
        _db.plantSpeciesRows.id.equalsExp(_db.userPlantRows.speciesId),
      ),
    ])..where(_db.userPlantRows.id.equals(userPlantId));
    final row = await query.getSingleOrNull();
    if (row == null) {
      return null;
    }
    return UserPlantRecord(
      plant: mapUserPlant(row.readTable(_db.userPlantRows)),
      species: mapSpecies(row.readTable(_db.plantSpeciesRows)),
    );
  }

  @override
  Future<void> replaceCarePlan({
    required String userPlantId,
    required List<CarePlanItem> items,
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
  Future<List<CarePlanItem>> getCarePlan(String userPlantId) async {
    final rows =
        await (_db.select(_db.carePlanItemRows)
              ..where((t) => t.userPlantId.equals(userPlantId))
              ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
            .get();
    return rows.map(mapCarePlanItem).toList();
  }

  @override
  Future<void> upsertCareTask(CareTask task) {
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
  Future<CareTask?> getCareTask(String id) async {
    final row = await (_db.select(
      _db.careTaskRows,
    )..where((t) => t.id.equals(id))).getSingleOrNull();
    return row == null ? null : mapCareTask(row);
  }

  @override
  Future<List<CareTask>> listOpenTasksForToday() async {
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
  Future<List<CareTask>> listCompletedTasks() async {
    final rows =
        await (_db.select(_db.careTaskRows)
              ..where((t) => t.isDone.equals(true))
              ..orderBy([(t) => OrderingTerm.desc(t.dueAt)]))
            .get();
    return rows.map(mapCareTask).toList();
  }

  @override
  Future<List<CareTask>> listTasksForPlant(String userPlantId) async {
    final rows =
        await (_db.select(_db.careTaskRows)
              ..where((t) => t.userPlantId.equals(userPlantId))
              ..orderBy([
                (t) => OrderingTerm.asc(t.isDone),
                (t) => OrderingTerm.asc(t.urgency),
              ]))
            .get();
    return rows.map(mapCareTask).toList();
  }

  @override
  Future<void> addCareEvent(CareEvent event) {
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
  Future<List<CareEvent>> listCareEvents(String userPlantId) async {
    final rows =
        await (_db.select(_db.careEventRows)
              ..where((t) => t.userPlantId.equals(userPlantId))
              ..orderBy([(t) => OrderingTerm.desc(t.occurredAt)]))
            .get();
    return rows.map(mapCareEvent).toList();
  }

  @override
  Future<void> deleteAllData() {
    return _db.transaction(() async {
      await _db.delete(_db.careEventRows).go();
      await _db.delete(_db.careTaskRows).go();
      await _db.delete(_db.carePlanItemRows).go();
      await _db.delete(_db.userPlantRows).go();
      await _db.delete(_db.plantSpeciesRows).go();
    });
  }

  @override
  Future<void> close() => _db.close();
}
