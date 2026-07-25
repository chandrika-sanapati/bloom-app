import 'dart:io';

import 'package:bloom/data/local/drift/tables.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:drift_flutter/drift_flutter.dart';
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

  BloomDatabase.defaults()
    : super(
        driftDatabase(
          name: 'bloom',
          native: DriftNativeOptions(
            databaseDirectory: getApplicationSupportDirectory,
          ),
        ),
      );

  @override
  int get schemaVersion => 3;

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
      },
    );
  }
}
