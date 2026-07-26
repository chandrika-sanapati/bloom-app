import 'dart:io';

import 'package:bloom/data/local/drift/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'bloom_database.g.dart';

@DriftDatabase(
  tables: [
    PlantSpeciesRows,
    UserPlantRows,
    CarePlanItemRows,
    CareTaskRows,
    CareEventRows,
  ],
)
class BloomDatabase extends _$BloomDatabase {
  BloomDatabase(super.executor);

  BloomDatabase.memory() : super(NativeDatabase.memory());

  BloomDatabase.file(File file) : super(NativeDatabase(file));

  /// Opens the on-device SQLite file on the UI isolate.
  ///
  /// Avoids background Drift workers that leave stale isolate ports across
  /// Flutter hot restart and can hang [BloomServices.bootstrap].
  BloomDatabase.defaults() : super(_openDefaults());

  @override
  int get schemaVersion => 6;

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
        if (from < 3) {
          await m.addColumn(plantSpeciesRows, plantSpeciesRows.overview);
          await m.addColumn(plantSpeciesRows, plantSpeciesRows.accentArgb);
        }
        if (from < 4) {
          await m.addColumn(userPlantRows, userPlantRows.lightLevel);
          await m.addColumn(userPlantRows, userPlantRows.homeClimate);
          await m.addColumn(userPlantRows, userPlantRows.pottingSize);
          await m.addColumn(userPlantRows, userPlantRows.experienceLevel);
        }
        if (from < 5) {
          await m.addColumn(
            carePlanItemRows,
            carePlanItemRows.suggestedCadenceLabel,
          );
          await m.addColumn(carePlanItemRows, carePlanItemRows.isUserModified);
        }
        if (from < 6) {
          await m.addColumn(userPlantRows, userPlantRows.photoPath);
        }
      },
    );
  }
}

LazyDatabase _openDefaults() {
  return LazyDatabase(() async {
    final directory = await getApplicationSupportDirectory();
    final file = File(p.join(directory.path, 'bloom.sqlite'));
    // Main-isolate connection: background workers survive hot restart poorly.
    return NativeDatabase(file);
  });
}
