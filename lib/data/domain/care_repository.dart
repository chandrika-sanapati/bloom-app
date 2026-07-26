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

  /// Removes a plant and its plan, tasks, and events.
  /// Deletes the linked species row when no other plant references it.
  Future<void> deleteUserPlant(String userPlantId);

  Future<void> replaceCarePlan({
    required String userPlantId,
    required List<CarePlanItem> items,
  });

  Future<List<CarePlanItem>> getCarePlan(String userPlantId);

  Future<void> upsertCareTask(CareTask task);

  Future<CareTask?> getCareTask(String id);

  /// Open tasks due on or before the end of the local calendar day.
  Future<List<CareTask>> listOpenTasksForToday({DateTime? now});

  /// All open (not done) tasks — used for reminder projection.
  Future<List<CareTask>> listOpenCareTasks();

  Future<List<CareTask>> listCompletedTasks();

  Future<List<CareTask>> listTasksForPlant(String userPlantId);

  Future<void> addCareEvent(CareEvent event);

  Future<List<CareEvent>> listCareEvents(String userPlantId);

  /// Wipes plants, plans, tasks, events, and species.
  Future<void> deleteAllData();

  Future<void> close();
}
