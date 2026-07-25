import 'dart:io';

import 'package:bloom/spikes/persistence/data/drift/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'bloom_spike_database.g.dart';

@DriftDatabase(
  tables: [
    PlantSpeciesRows,
    UserPlantRows,
    CarePlanItemRows,
    CareTaskRows,
    CareEventRows,
  ],
)
class BloomSpikeDatabase extends _$BloomSpikeDatabase {
  BloomSpikeDatabase(super.executor);

  /// In-memory database for unit tests.
  BloomSpikeDatabase.memory() : super(NativeDatabase.memory());

  /// File-backed database for process-death style reopen tests.
  BloomSpikeDatabase.file(File file) : super(NativeDatabase(file));

  /// Default on-device location (unused by fixture UI; available for later adopt).
  BloomSpikeDatabase.defaults()
    : super(
        driftDatabase(
          name: 'bloom_spike',
          native: DriftNativeOptions(
            databaseDirectory: getApplicationSupportDirectory,
          ),
        ),
      );

  /// Current spike schema includes `user_plants.notes` (v2).
  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(userPlantRows, userPlantRows.notes);
        }
      },
    );
  }

  static Future<File> tempDbFile(String name) async {
    final dir = await Directory.systemTemp.createTemp('bloom_spike_');
    return File(p.join(dir.path, name));
  }
}
