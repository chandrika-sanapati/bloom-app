import 'dart:io';

import 'package:bloom/spikes/persistence/data/drift/bloom_spike_database.dart';
import 'package:bloom/spikes/persistence/data/drift/drift_care_repository.dart';
import 'package:bloom/spikes/persistence/domain/care_repository.dart';
import 'package:bloom/spikes/persistence/domain/entities.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';

void main() {
  late Directory tempDir;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('bloom_persistence_');
  });

  tearDown(() async {
    if (tempDir.existsSync()) {
      await tempDir.delete(recursive: true);
    }
  });

  Future<void> seedMinimalGraph(CareRepository repo) async {
    await repo.upsertSpecies(
      const SpikePlantSpecies(
        id: 'species-snake',
        commonName: 'Snake Plant',
        scientificName: 'Dracaena trifasciata',
        difficulty: SpikePlantDifficulty.easy,
      ),
    );
    await repo.upsertUserPlant(
      const SpikeUserPlant(
        id: 'plant-snake',
        speciesId: 'species-snake',
        displayName: 'Snake Plant',
        statusLabel: 'Needs water',
      ),
    );
    await repo.replaceCarePlan(
      userPlantId: 'plant-snake',
      items: const [
        SpikeCarePlanItem(
          id: 'plan-water',
          userPlantId: 'plant-snake',
          kind: SpikeCareActionKind.water,
          title: 'Water',
          cadenceLabel: 'When soil is fully dry',
          sortOrder: 0,
        ),
      ],
    );
    await repo.upsertCareTask(
      SpikeCareTask(
        id: 'task-snake-water',
        userPlantId: 'plant-snake',
        actionLabel: 'Water',
        urgency: SpikeCareUrgency.overdue,
        dueAt: DateTime.utc(2026, 7, 20),
        isDone: false,
      ),
    );
    await repo.addCareEvent(
      SpikeCareEvent(
        id: 'event-1',
        userPlantId: 'plant-snake',
        kind: SpikeCareActionKind.water,
        label: 'Watered',
        occurredAt: DateTime.utc(2026, 7, 10),
      ),
    );
  }

  test('persists species, plant, care plan, task, and event', () async {
    final db = BloomSpikeDatabase.memory();
    final repo = DriftCareRepository(db);
    addTearDown(repo.close);

    await seedMinimalGraph(repo);

    final species = await repo.getSpecies('species-snake');
    expect(species?.commonName, 'Snake Plant');

    final plant = await repo.getUserPlant('plant-snake');
    expect(plant?.displayName, 'Snake Plant');

    final plan = await repo.getCarePlan('plant-snake');
    expect(plan, hasLength(1));
    expect(plan.first.title, 'Water');

    final task = await repo.getCareTask('task-snake-water');
    expect(task?.urgency, SpikeCareUrgency.overdue);
    expect(task?.isDone, isFalse);

    final events = await repo.listCareEvents('plant-snake');
    expect(events, hasLength(1));
    expect(events.first.label, 'Watered');
  });

  test('recreates Today open-task state after close and reopen', () async {
    final file = File(p.join(tempDir.path, 'today.sqlite'));
    final first = DriftCareRepository(BloomSpikeDatabase.file(file));
    await seedMinimalGraph(first);
    await first.upsertCareTask(
      SpikeCareTask(
        id: 'task-upcoming',
        userPlantId: 'plant-snake',
        actionLabel: 'Check soil',
        urgency: SpikeCareUrgency.upcoming,
        dueAt: DateTime.utc(2026, 7, 28),
        isDone: false,
      ),
    );
    await first.upsertCareTask(
      SpikeCareTask(
        id: 'task-done',
        userPlantId: 'plant-snake',
        actionLabel: 'Fertilise',
        urgency: SpikeCareUrgency.done,
        dueAt: DateTime.utc(2026, 7, 18),
        isDone: true,
      ),
    );

    final before = await first.listOpenTasksForToday();
    expect(before.map((t) => t.id), ['task-snake-water', 'task-upcoming']);
    await first.close();

    final second = DriftCareRepository(BloomSpikeDatabase.file(file));
    addTearDown(second.close);
    final after = await second.listOpenTasksForToday();
    expect(after.map((t) => t.id), ['task-snake-water', 'task-upcoming']);
    expect(after.first.actionLabel, 'Water');
  });

  test('migrates schema v1 to v2 without losing user plants', () async {
    final sqliteDb = sqlite3.openInMemory();
    sqliteDb.execute('PRAGMA foreign_keys = ON');
    sqliteDb.execute('''
      CREATE TABLE plant_species_rows (
        id TEXT NOT NULL PRIMARY KEY,
        common_name TEXT NOT NULL,
        scientific_name TEXT NOT NULL,
        difficulty INTEGER NOT NULL
      );
    ''');
    sqliteDb.execute('''
      CREATE TABLE user_plant_rows (
        id TEXT NOT NULL PRIMARY KEY,
        species_id TEXT NOT NULL REFERENCES plant_species_rows (id),
        display_name TEXT NOT NULL,
        status_label TEXT NOT NULL
      );
    ''');
    sqliteDb.execute('''
      CREATE TABLE care_plan_item_rows (
        id TEXT NOT NULL PRIMARY KEY,
        user_plant_id TEXT NOT NULL REFERENCES user_plant_rows (id),
        kind INTEGER NOT NULL,
        title TEXT NOT NULL,
        cadence_label TEXT NOT NULL,
        sort_order INTEGER NOT NULL
      );
    ''');
    sqliteDb.execute('''
      CREATE TABLE care_task_rows (
        id TEXT NOT NULL PRIMARY KEY,
        user_plant_id TEXT NOT NULL REFERENCES user_plant_rows (id),
        action_label TEXT NOT NULL,
        urgency INTEGER NOT NULL,
        due_at INTEGER NOT NULL,
        is_done INTEGER NOT NULL DEFAULT 0 CHECK (is_done IN (0, 1))
      );
    ''');
    sqliteDb.execute('''
      CREATE TABLE care_event_rows (
        id TEXT NOT NULL PRIMARY KEY,
        user_plant_id TEXT NOT NULL REFERENCES user_plant_rows (id),
        kind INTEGER NOT NULL,
        label TEXT NOT NULL,
        occurred_at INTEGER NOT NULL
      );
    ''');
    sqliteDb.execute(
      "INSERT INTO plant_species_rows VALUES ('species-1', 'Pothos', 'Epipremnum aureum', 0);",
    );
    sqliteDb.execute(
      "INSERT INTO user_plant_rows VALUES ('plant-1', 'species-1', 'Office Pothos', 'Healthy');",
    );
    sqliteDb.execute('PRAGMA user_version = 1');

    final db = BloomSpikeDatabase(NativeDatabase.opened(sqliteDb));
    final repo = DriftCareRepository(db);
    addTearDown(repo.close);

    final plant = await repo.getUserPlant('plant-1');
    expect(plant, isNotNull);
    expect(plant!.displayName, 'Office Pothos');
    expect(plant.notes, isNull);

    await repo.upsertUserPlant(
      const SpikeUserPlant(
        id: 'plant-1',
        speciesId: 'species-1',
        displayName: 'Office Pothos',
        statusLabel: 'Healthy',
        notes: 'Near the window',
      ),
    );
    final updated = await repo.getUserPlant('plant-1');
    expect(updated?.notes, 'Near the window');
  });
}
