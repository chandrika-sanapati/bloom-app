import 'package:drift/drift.dart';

@DataClassName('PlantSpeciesRow')
class PlantSpeciesRows extends Table {
  TextColumn get id => text()();
  TextColumn get commonName => text()();
  TextColumn get scientificName => text()();
  IntColumn get difficulty => integer()();
  TextColumn get overview => text().withDefault(const Constant(''))();
  IntColumn get accentArgb =>
      integer().withDefault(const Constant(0xFF2AAA8A))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('UserPlantRow')
class UserPlantRows extends Table {
  TextColumn get id => text()();
  TextColumn get speciesId => text().references(PlantSpeciesRows, #id)();
  TextColumn get displayName => text()();
  TextColumn get statusLabel => text()();
  TextColumn get notes => text().nullable()();
  TextColumn get lightLevel => text().nullable()();
  TextColumn get homeClimate => text().nullable()();
  TextColumn get pottingSize => text().nullable()();
  TextColumn get experienceLevel => text().nullable()();
  TextColumn get photoPath => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CarePlanItemRow')
class CarePlanItemRows extends Table {
  TextColumn get id => text()();
  TextColumn get userPlantId => text().references(UserPlantRows, #id)();
  IntColumn get kind => integer()();
  TextColumn get title => text()();
  TextColumn get cadenceLabel => text()();
  IntColumn get sortOrder => integer()();
  TextColumn get suggestedCadenceLabel => text().nullable()();
  BoolColumn get isUserModified =>
      boolean().withDefault(const Constant(false))();
  TextColumn get sourceUrl => text().nullable()();
  TextColumn get careContentVersion => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CareTaskRow')
class CareTaskRows extends Table {
  TextColumn get id => text()();
  TextColumn get userPlantId => text().references(UserPlantRows, #id)();
  TextColumn get actionLabel => text()();
  IntColumn get urgency => integer()();
  DateTimeColumn get dueAt => dateTime()();
  BoolColumn get isDone => boolean().withDefault(const Constant(false))();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DataClassName('CareEventRow')
class CareEventRows extends Table {
  TextColumn get id => text()();
  TextColumn get userPlantId => text().references(UserPlantRows, #id)();
  IntColumn get kind => integer()();
  TextColumn get label => text()();
  DateTimeColumn get occurredAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
