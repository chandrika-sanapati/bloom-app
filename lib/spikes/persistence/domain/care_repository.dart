import 'package:bloom/spikes/persistence/domain/entities.dart';

/// Package-agnostic care persistence contract for the spike.
abstract interface class CareRepository {
  Future<void> upsertSpecies(SpikePlantSpecies species);

  Future<SpikePlantSpecies?> getSpecies(String id);

  Future<void> upsertUserPlant(SpikeUserPlant plant);

  Future<SpikeUserPlant?> getUserPlant(String id);

  Future<List<SpikeUserPlant>> listUserPlants();

  Future<void> replaceCarePlan({
    required String userPlantId,
    required List<SpikeCarePlanItem> items,
  });

  Future<List<SpikeCarePlanItem>> getCarePlan(String userPlantId);

  Future<void> upsertCareTask(SpikeCareTask task);

  Future<SpikeCareTask?> getCareTask(String id);

  /// Open (not done) tasks ordered for a Today-style list.
  Future<List<SpikeCareTask>> listOpenTasksForToday();

  Future<void> addCareEvent(SpikeCareEvent event);

  Future<List<SpikeCareEvent>> listCareEvents(String userPlantId);

  Future<void> close();
}
