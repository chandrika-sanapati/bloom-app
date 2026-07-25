import 'package:bloom/data/domain/entities.dart';

/// Package-agnostic care persistence contract.
abstract interface class CareRepository {
  Future<void> upsertSpecies(PlantSpecies species);

  Future<PlantSpecies?> getSpecies(String id);

  Future<void> upsertUserPlant(UserPlant plant);

  Future<UserPlant?> getUserPlant(String id);

  Future<List<UserPlant>> listUserPlants();

  Future<List<UserPlantRecord>> listUserPlantRecords();

  Future<UserPlantRecord?> getUserPlantRecord(String userPlantId);

  Future<void> replaceCarePlan({
    required String userPlantId,
    required List<CarePlanItem> items,
  });

  Future<List<CarePlanItem>> getCarePlan(String userPlantId);

  Future<void> upsertCareTask(CareTask task);

  Future<CareTask?> getCareTask(String id);

  /// Open (not done) tasks ordered for a Today-style list.
  Future<List<CareTask>> listOpenTasksForToday();

  Future<List<CareTask>> listCompletedTasks();

  Future<List<CareTask>> listTasksForPlant(String userPlantId);

  Future<void> addCareEvent(CareEvent event);

  Future<List<CareEvent>> listCareEvents(String userPlantId);

  /// Wipes plants, plans, tasks, events, and species.
  Future<void> deleteAllData();

  Future<void> close();
}
