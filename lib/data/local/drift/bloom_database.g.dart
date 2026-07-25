// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloom_database.dart';

// ignore_for_file: type=lint
class $PlantSpeciesRowsTable extends PlantSpeciesRows
    with TableInfo<$PlantSpeciesRowsTable, PlantSpeciesRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlantSpeciesRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commonNameMeta = const VerificationMeta(
    'commonName',
  );
  @override
  late final GeneratedColumn<String> commonName = GeneratedColumn<String>(
    'common_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scientificNameMeta = const VerificationMeta(
    'scientificName',
  );
  @override
  late final GeneratedColumn<String> scientificName = GeneratedColumn<String>(
    'scientific_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<int> difficulty = GeneratedColumn<int>(
    'difficulty',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _overviewMeta = const VerificationMeta(
    'overview',
  );
  @override
  late final GeneratedColumn<String> overview = GeneratedColumn<String>(
    'overview',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _accentArgbMeta = const VerificationMeta(
    'accentArgb',
  );
  @override
  late final GeneratedColumn<int> accentArgb = GeneratedColumn<int>(
    'accent_argb',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0xFF2AAA8A),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    commonName,
    scientificName,
    difficulty,
    overview,
    accentArgb,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plant_species_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlantSpeciesRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('common_name')) {
      context.handle(
        _commonNameMeta,
        commonName.isAcceptableOrUnknown(data['common_name']!, _commonNameMeta),
      );
    } else if (isInserting) {
      context.missing(_commonNameMeta);
    }
    if (data.containsKey('scientific_name')) {
      context.handle(
        _scientificNameMeta,
        scientificName.isAcceptableOrUnknown(
          data['scientific_name']!,
          _scientificNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scientificNameMeta);
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    } else if (isInserting) {
      context.missing(_difficultyMeta);
    }
    if (data.containsKey('overview')) {
      context.handle(
        _overviewMeta,
        overview.isAcceptableOrUnknown(data['overview']!, _overviewMeta),
      );
    }
    if (data.containsKey('accent_argb')) {
      context.handle(
        _accentArgbMeta,
        accentArgb.isAcceptableOrUnknown(data['accent_argb']!, _accentArgbMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlantSpeciesRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlantSpeciesRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      commonName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_name'],
      )!,
      scientificName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scientific_name'],
      )!,
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty'],
      )!,
      overview: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}overview'],
      )!,
      accentArgb: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}accent_argb'],
      )!,
    );
  }

  @override
  $PlantSpeciesRowsTable createAlias(String alias) {
    return $PlantSpeciesRowsTable(attachedDatabase, alias);
  }
}

class PlantSpeciesRow extends DataClass implements Insertable<PlantSpeciesRow> {
  final String id;
  final String commonName;
  final String scientificName;
  final int difficulty;
  final String overview;
  final int accentArgb;
  const PlantSpeciesRow({
    required this.id,
    required this.commonName,
    required this.scientificName,
    required this.difficulty,
    required this.overview,
    required this.accentArgb,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['common_name'] = Variable<String>(commonName);
    map['scientific_name'] = Variable<String>(scientificName);
    map['difficulty'] = Variable<int>(difficulty);
    map['overview'] = Variable<String>(overview);
    map['accent_argb'] = Variable<int>(accentArgb);
    return map;
  }

  PlantSpeciesRowsCompanion toCompanion(bool nullToAbsent) {
    return PlantSpeciesRowsCompanion(
      id: Value(id),
      commonName: Value(commonName),
      scientificName: Value(scientificName),
      difficulty: Value(difficulty),
      overview: Value(overview),
      accentArgb: Value(accentArgb),
    );
  }

  factory PlantSpeciesRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlantSpeciesRow(
      id: serializer.fromJson<String>(json['id']),
      commonName: serializer.fromJson<String>(json['commonName']),
      scientificName: serializer.fromJson<String>(json['scientificName']),
      difficulty: serializer.fromJson<int>(json['difficulty']),
      overview: serializer.fromJson<String>(json['overview']),
      accentArgb: serializer.fromJson<int>(json['accentArgb']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'commonName': serializer.toJson<String>(commonName),
      'scientificName': serializer.toJson<String>(scientificName),
      'difficulty': serializer.toJson<int>(difficulty),
      'overview': serializer.toJson<String>(overview),
      'accentArgb': serializer.toJson<int>(accentArgb),
    };
  }

  PlantSpeciesRow copyWith({
    String? id,
    String? commonName,
    String? scientificName,
    int? difficulty,
    String? overview,
    int? accentArgb,
  }) => PlantSpeciesRow(
    id: id ?? this.id,
    commonName: commonName ?? this.commonName,
    scientificName: scientificName ?? this.scientificName,
    difficulty: difficulty ?? this.difficulty,
    overview: overview ?? this.overview,
    accentArgb: accentArgb ?? this.accentArgb,
  );
  PlantSpeciesRow copyWithCompanion(PlantSpeciesRowsCompanion data) {
    return PlantSpeciesRow(
      id: data.id.present ? data.id.value : this.id,
      commonName: data.commonName.present
          ? data.commonName.value
          : this.commonName,
      scientificName: data.scientificName.present
          ? data.scientificName.value
          : this.scientificName,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      overview: data.overview.present ? data.overview.value : this.overview,
      accentArgb: data.accentArgb.present
          ? data.accentArgb.value
          : this.accentArgb,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlantSpeciesRow(')
          ..write('id: $id, ')
          ..write('commonName: $commonName, ')
          ..write('scientificName: $scientificName, ')
          ..write('difficulty: $difficulty, ')
          ..write('overview: $overview, ')
          ..write('accentArgb: $accentArgb')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    commonName,
    scientificName,
    difficulty,
    overview,
    accentArgb,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlantSpeciesRow &&
          other.id == this.id &&
          other.commonName == this.commonName &&
          other.scientificName == this.scientificName &&
          other.difficulty == this.difficulty &&
          other.overview == this.overview &&
          other.accentArgb == this.accentArgb);
}

class PlantSpeciesRowsCompanion extends UpdateCompanion<PlantSpeciesRow> {
  final Value<String> id;
  final Value<String> commonName;
  final Value<String> scientificName;
  final Value<int> difficulty;
  final Value<String> overview;
  final Value<int> accentArgb;
  final Value<int> rowid;
  const PlantSpeciesRowsCompanion({
    this.id = const Value.absent(),
    this.commonName = const Value.absent(),
    this.scientificName = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.overview = const Value.absent(),
    this.accentArgb = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlantSpeciesRowsCompanion.insert({
    required String id,
    required String commonName,
    required String scientificName,
    required int difficulty,
    this.overview = const Value.absent(),
    this.accentArgb = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       commonName = Value(commonName),
       scientificName = Value(scientificName),
       difficulty = Value(difficulty);
  static Insertable<PlantSpeciesRow> custom({
    Expression<String>? id,
    Expression<String>? commonName,
    Expression<String>? scientificName,
    Expression<int>? difficulty,
    Expression<String>? overview,
    Expression<int>? accentArgb,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (commonName != null) 'common_name': commonName,
      if (scientificName != null) 'scientific_name': scientificName,
      if (difficulty != null) 'difficulty': difficulty,
      if (overview != null) 'overview': overview,
      if (accentArgb != null) 'accent_argb': accentArgb,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlantSpeciesRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? commonName,
    Value<String>? scientificName,
    Value<int>? difficulty,
    Value<String>? overview,
    Value<int>? accentArgb,
    Value<int>? rowid,
  }) {
    return PlantSpeciesRowsCompanion(
      id: id ?? this.id,
      commonName: commonName ?? this.commonName,
      scientificName: scientificName ?? this.scientificName,
      difficulty: difficulty ?? this.difficulty,
      overview: overview ?? this.overview,
      accentArgb: accentArgb ?? this.accentArgb,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (commonName.present) {
      map['common_name'] = Variable<String>(commonName.value);
    }
    if (scientificName.present) {
      map['scientific_name'] = Variable<String>(scientificName.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<int>(difficulty.value);
    }
    if (overview.present) {
      map['overview'] = Variable<String>(overview.value);
    }
    if (accentArgb.present) {
      map['accent_argb'] = Variable<int>(accentArgb.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlantSpeciesRowsCompanion(')
          ..write('id: $id, ')
          ..write('commonName: $commonName, ')
          ..write('scientificName: $scientificName, ')
          ..write('difficulty: $difficulty, ')
          ..write('overview: $overview, ')
          ..write('accentArgb: $accentArgb, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPlantRowsTable extends UserPlantRows
    with TableInfo<$UserPlantRowsTable, UserPlantRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPlantRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesIdMeta = const VerificationMeta(
    'speciesId',
  );
  @override
  late final GeneratedColumn<String> speciesId = GeneratedColumn<String>(
    'species_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plant_species_rows (id)',
    ),
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusLabelMeta = const VerificationMeta(
    'statusLabel',
  );
  @override
  late final GeneratedColumn<String> statusLabel = GeneratedColumn<String>(
    'status_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    speciesId,
    displayName,
    statusLabel,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_plant_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPlantRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('species_id')) {
      context.handle(
        _speciesIdMeta,
        speciesId.isAcceptableOrUnknown(data['species_id']!, _speciesIdMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_displayNameMeta);
    }
    if (data.containsKey('status_label')) {
      context.handle(
        _statusLabelMeta,
        statusLabel.isAcceptableOrUnknown(
          data['status_label']!,
          _statusLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_statusLabelMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPlantRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPlantRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      speciesId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      )!,
      statusLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status_label'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $UserPlantRowsTable createAlias(String alias) {
    return $UserPlantRowsTable(attachedDatabase, alias);
  }
}

class UserPlantRow extends DataClass implements Insertable<UserPlantRow> {
  final String id;
  final String speciesId;
  final String displayName;
  final String statusLabel;
  final String? notes;
  const UserPlantRow({
    required this.id,
    required this.speciesId,
    required this.displayName,
    required this.statusLabel,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['species_id'] = Variable<String>(speciesId);
    map['display_name'] = Variable<String>(displayName);
    map['status_label'] = Variable<String>(statusLabel);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  UserPlantRowsCompanion toCompanion(bool nullToAbsent) {
    return UserPlantRowsCompanion(
      id: Value(id),
      speciesId: Value(speciesId),
      displayName: Value(displayName),
      statusLabel: Value(statusLabel),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory UserPlantRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPlantRow(
      id: serializer.fromJson<String>(json['id']),
      speciesId: serializer.fromJson<String>(json['speciesId']),
      displayName: serializer.fromJson<String>(json['displayName']),
      statusLabel: serializer.fromJson<String>(json['statusLabel']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'speciesId': serializer.toJson<String>(speciesId),
      'displayName': serializer.toJson<String>(displayName),
      'statusLabel': serializer.toJson<String>(statusLabel),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  UserPlantRow copyWith({
    String? id,
    String? speciesId,
    String? displayName,
    String? statusLabel,
    Value<String?> notes = const Value.absent(),
  }) => UserPlantRow(
    id: id ?? this.id,
    speciesId: speciesId ?? this.speciesId,
    displayName: displayName ?? this.displayName,
    statusLabel: statusLabel ?? this.statusLabel,
    notes: notes.present ? notes.value : this.notes,
  );
  UserPlantRow copyWithCompanion(UserPlantRowsCompanion data) {
    return UserPlantRow(
      id: data.id.present ? data.id.value : this.id,
      speciesId: data.speciesId.present ? data.speciesId.value : this.speciesId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      statusLabel: data.statusLabel.present
          ? data.statusLabel.value
          : this.statusLabel,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPlantRow(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('displayName: $displayName, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, speciesId, displayName, statusLabel, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPlantRow &&
          other.id == this.id &&
          other.speciesId == this.speciesId &&
          other.displayName == this.displayName &&
          other.statusLabel == this.statusLabel &&
          other.notes == this.notes);
}

class UserPlantRowsCompanion extends UpdateCompanion<UserPlantRow> {
  final Value<String> id;
  final Value<String> speciesId;
  final Value<String> displayName;
  final Value<String> statusLabel;
  final Value<String?> notes;
  final Value<int> rowid;
  const UserPlantRowsCompanion({
    this.id = const Value.absent(),
    this.speciesId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.statusLabel = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserPlantRowsCompanion.insert({
    required String id,
    required String speciesId,
    required String displayName,
    required String statusLabel,
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       speciesId = Value(speciesId),
       displayName = Value(displayName),
       statusLabel = Value(statusLabel);
  static Insertable<UserPlantRow> custom({
    Expression<String>? id,
    Expression<String>? speciesId,
    Expression<String>? displayName,
    Expression<String>? statusLabel,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (speciesId != null) 'species_id': speciesId,
      if (displayName != null) 'display_name': displayName,
      if (statusLabel != null) 'status_label': statusLabel,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserPlantRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? speciesId,
    Value<String>? displayName,
    Value<String>? statusLabel,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return UserPlantRowsCompanion(
      id: id ?? this.id,
      speciesId: speciesId ?? this.speciesId,
      displayName: displayName ?? this.displayName,
      statusLabel: statusLabel ?? this.statusLabel,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (speciesId.present) {
      map['species_id'] = Variable<String>(speciesId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (statusLabel.present) {
      map['status_label'] = Variable<String>(statusLabel.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPlantRowsCompanion(')
          ..write('id: $id, ')
          ..write('speciesId: $speciesId, ')
          ..write('displayName: $displayName, ')
          ..write('statusLabel: $statusLabel, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CarePlanItemRowsTable extends CarePlanItemRows
    with TableInfo<$CarePlanItemRowsTable, CarePlanItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CarePlanItemRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userPlantIdMeta = const VerificationMeta(
    'userPlantId',
  );
  @override
  late final GeneratedColumn<String> userPlantId = GeneratedColumn<String>(
    'user_plant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_plant_rows (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<int> kind = GeneratedColumn<int>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cadenceLabelMeta = const VerificationMeta(
    'cadenceLabel',
  );
  @override
  late final GeneratedColumn<String> cadenceLabel = GeneratedColumn<String>(
    'cadence_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userPlantId,
    kind,
    title,
    cadenceLabel,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_plan_item_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CarePlanItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_plant_id')) {
      context.handle(
        _userPlantIdMeta,
        userPlantId.isAcceptableOrUnknown(
          data['user_plant_id']!,
          _userPlantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userPlantIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cadence_label')) {
      context.handle(
        _cadenceLabelMeta,
        cadenceLabel.isAcceptableOrUnknown(
          data['cadence_label']!,
          _cadenceLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cadenceLabelMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CarePlanItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CarePlanItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userPlantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_plant_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kind'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      cadenceLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cadence_label'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CarePlanItemRowsTable createAlias(String alias) {
    return $CarePlanItemRowsTable(attachedDatabase, alias);
  }
}

class CarePlanItemRow extends DataClass implements Insertable<CarePlanItemRow> {
  final String id;
  final String userPlantId;
  final int kind;
  final String title;
  final String cadenceLabel;
  final int sortOrder;
  const CarePlanItemRow({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.title,
    required this.cadenceLabel,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_plant_id'] = Variable<String>(userPlantId);
    map['kind'] = Variable<int>(kind);
    map['title'] = Variable<String>(title);
    map['cadence_label'] = Variable<String>(cadenceLabel);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CarePlanItemRowsCompanion toCompanion(bool nullToAbsent) {
    return CarePlanItemRowsCompanion(
      id: Value(id),
      userPlantId: Value(userPlantId),
      kind: Value(kind),
      title: Value(title),
      cadenceLabel: Value(cadenceLabel),
      sortOrder: Value(sortOrder),
    );
  }

  factory CarePlanItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CarePlanItemRow(
      id: serializer.fromJson<String>(json['id']),
      userPlantId: serializer.fromJson<String>(json['userPlantId']),
      kind: serializer.fromJson<int>(json['kind']),
      title: serializer.fromJson<String>(json['title']),
      cadenceLabel: serializer.fromJson<String>(json['cadenceLabel']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userPlantId': serializer.toJson<String>(userPlantId),
      'kind': serializer.toJson<int>(kind),
      'title': serializer.toJson<String>(title),
      'cadenceLabel': serializer.toJson<String>(cadenceLabel),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CarePlanItemRow copyWith({
    String? id,
    String? userPlantId,
    int? kind,
    String? title,
    String? cadenceLabel,
    int? sortOrder,
  }) => CarePlanItemRow(
    id: id ?? this.id,
    userPlantId: userPlantId ?? this.userPlantId,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    cadenceLabel: cadenceLabel ?? this.cadenceLabel,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CarePlanItemRow copyWithCompanion(CarePlanItemRowsCompanion data) {
    return CarePlanItemRow(
      id: data.id.present ? data.id.value : this.id,
      userPlantId: data.userPlantId.present
          ? data.userPlantId.value
          : this.userPlantId,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      cadenceLabel: data.cadenceLabel.present
          ? data.cadenceLabel.value
          : this.cadenceLabel,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CarePlanItemRow(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('cadenceLabel: $cadenceLabel, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userPlantId, kind, title, cadenceLabel, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarePlanItemRow &&
          other.id == this.id &&
          other.userPlantId == this.userPlantId &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.cadenceLabel == this.cadenceLabel &&
          other.sortOrder == this.sortOrder);
}

class CarePlanItemRowsCompanion extends UpdateCompanion<CarePlanItemRow> {
  final Value<String> id;
  final Value<String> userPlantId;
  final Value<int> kind;
  final Value<String> title;
  final Value<String> cadenceLabel;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CarePlanItemRowsCompanion({
    this.id = const Value.absent(),
    this.userPlantId = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.cadenceLabel = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CarePlanItemRowsCompanion.insert({
    required String id,
    required String userPlantId,
    required int kind,
    required String title,
    required String cadenceLabel,
    required int sortOrder,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userPlantId = Value(userPlantId),
       kind = Value(kind),
       title = Value(title),
       cadenceLabel = Value(cadenceLabel),
       sortOrder = Value(sortOrder);
  static Insertable<CarePlanItemRow> custom({
    Expression<String>? id,
    Expression<String>? userPlantId,
    Expression<int>? kind,
    Expression<String>? title,
    Expression<String>? cadenceLabel,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userPlantId != null) 'user_plant_id': userPlantId,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (cadenceLabel != null) 'cadence_label': cadenceLabel,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CarePlanItemRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? userPlantId,
    Value<int>? kind,
    Value<String>? title,
    Value<String>? cadenceLabel,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CarePlanItemRowsCompanion(
      id: id ?? this.id,
      userPlantId: userPlantId ?? this.userPlantId,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      cadenceLabel: cadenceLabel ?? this.cadenceLabel,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userPlantId.present) {
      map['user_plant_id'] = Variable<String>(userPlantId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(kind.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (cadenceLabel.present) {
      map['cadence_label'] = Variable<String>(cadenceLabel.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarePlanItemRowsCompanion(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('cadenceLabel: $cadenceLabel, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareTaskRowsTable extends CareTaskRows
    with TableInfo<$CareTaskRowsTable, CareTaskRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareTaskRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userPlantIdMeta = const VerificationMeta(
    'userPlantId',
  );
  @override
  late final GeneratedColumn<String> userPlantId = GeneratedColumn<String>(
    'user_plant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_plant_rows (id)',
    ),
  );
  static const VerificationMeta _actionLabelMeta = const VerificationMeta(
    'actionLabel',
  );
  @override
  late final GeneratedColumn<String> actionLabel = GeneratedColumn<String>(
    'action_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urgencyMeta = const VerificationMeta(
    'urgency',
  );
  @override
  late final GeneratedColumn<int> urgency = GeneratedColumn<int>(
    'urgency',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDoneMeta = const VerificationMeta('isDone');
  @override
  late final GeneratedColumn<bool> isDone = GeneratedColumn<bool>(
    'is_done',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_done" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userPlantId,
    actionLabel,
    urgency,
    dueAt,
    isDone,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_task_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareTaskRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_plant_id')) {
      context.handle(
        _userPlantIdMeta,
        userPlantId.isAcceptableOrUnknown(
          data['user_plant_id']!,
          _userPlantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userPlantIdMeta);
    }
    if (data.containsKey('action_label')) {
      context.handle(
        _actionLabelMeta,
        actionLabel.isAcceptableOrUnknown(
          data['action_label']!,
          _actionLabelMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actionLabelMeta);
    }
    if (data.containsKey('urgency')) {
      context.handle(
        _urgencyMeta,
        urgency.isAcceptableOrUnknown(data['urgency']!, _urgencyMeta),
      );
    } else if (isInserting) {
      context.missing(_urgencyMeta);
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    } else if (isInserting) {
      context.missing(_dueAtMeta);
    }
    if (data.containsKey('is_done')) {
      context.handle(
        _isDoneMeta,
        isDone.isAcceptableOrUnknown(data['is_done']!, _isDoneMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareTaskRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareTaskRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userPlantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_plant_id'],
      )!,
      actionLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}action_label'],
      )!,
      urgency: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urgency'],
      )!,
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      )!,
      isDone: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_done'],
      )!,
    );
  }

  @override
  $CareTaskRowsTable createAlias(String alias) {
    return $CareTaskRowsTable(attachedDatabase, alias);
  }
}

class CareTaskRow extends DataClass implements Insertable<CareTaskRow> {
  final String id;
  final String userPlantId;
  final String actionLabel;
  final int urgency;
  final DateTime dueAt;
  final bool isDone;
  const CareTaskRow({
    required this.id,
    required this.userPlantId,
    required this.actionLabel,
    required this.urgency,
    required this.dueAt,
    required this.isDone,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_plant_id'] = Variable<String>(userPlantId);
    map['action_label'] = Variable<String>(actionLabel);
    map['urgency'] = Variable<int>(urgency);
    map['due_at'] = Variable<DateTime>(dueAt);
    map['is_done'] = Variable<bool>(isDone);
    return map;
  }

  CareTaskRowsCompanion toCompanion(bool nullToAbsent) {
    return CareTaskRowsCompanion(
      id: Value(id),
      userPlantId: Value(userPlantId),
      actionLabel: Value(actionLabel),
      urgency: Value(urgency),
      dueAt: Value(dueAt),
      isDone: Value(isDone),
    );
  }

  factory CareTaskRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareTaskRow(
      id: serializer.fromJson<String>(json['id']),
      userPlantId: serializer.fromJson<String>(json['userPlantId']),
      actionLabel: serializer.fromJson<String>(json['actionLabel']),
      urgency: serializer.fromJson<int>(json['urgency']),
      dueAt: serializer.fromJson<DateTime>(json['dueAt']),
      isDone: serializer.fromJson<bool>(json['isDone']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userPlantId': serializer.toJson<String>(userPlantId),
      'actionLabel': serializer.toJson<String>(actionLabel),
      'urgency': serializer.toJson<int>(urgency),
      'dueAt': serializer.toJson<DateTime>(dueAt),
      'isDone': serializer.toJson<bool>(isDone),
    };
  }

  CareTaskRow copyWith({
    String? id,
    String? userPlantId,
    String? actionLabel,
    int? urgency,
    DateTime? dueAt,
    bool? isDone,
  }) => CareTaskRow(
    id: id ?? this.id,
    userPlantId: userPlantId ?? this.userPlantId,
    actionLabel: actionLabel ?? this.actionLabel,
    urgency: urgency ?? this.urgency,
    dueAt: dueAt ?? this.dueAt,
    isDone: isDone ?? this.isDone,
  );
  CareTaskRow copyWithCompanion(CareTaskRowsCompanion data) {
    return CareTaskRow(
      id: data.id.present ? data.id.value : this.id,
      userPlantId: data.userPlantId.present
          ? data.userPlantId.value
          : this.userPlantId,
      actionLabel: data.actionLabel.present
          ? data.actionLabel.value
          : this.actionLabel,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      isDone: data.isDone.present ? data.isDone.value : this.isDone,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareTaskRow(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('urgency: $urgency, ')
          ..write('dueAt: $dueAt, ')
          ..write('isDone: $isDone')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userPlantId, actionLabel, urgency, dueAt, isDone);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareTaskRow &&
          other.id == this.id &&
          other.userPlantId == this.userPlantId &&
          other.actionLabel == this.actionLabel &&
          other.urgency == this.urgency &&
          other.dueAt == this.dueAt &&
          other.isDone == this.isDone);
}

class CareTaskRowsCompanion extends UpdateCompanion<CareTaskRow> {
  final Value<String> id;
  final Value<String> userPlantId;
  final Value<String> actionLabel;
  final Value<int> urgency;
  final Value<DateTime> dueAt;
  final Value<bool> isDone;
  final Value<int> rowid;
  const CareTaskRowsCompanion({
    this.id = const Value.absent(),
    this.userPlantId = const Value.absent(),
    this.actionLabel = const Value.absent(),
    this.urgency = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareTaskRowsCompanion.insert({
    required String id,
    required String userPlantId,
    required String actionLabel,
    required int urgency,
    required DateTime dueAt,
    this.isDone = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userPlantId = Value(userPlantId),
       actionLabel = Value(actionLabel),
       urgency = Value(urgency),
       dueAt = Value(dueAt);
  static Insertable<CareTaskRow> custom({
    Expression<String>? id,
    Expression<String>? userPlantId,
    Expression<String>? actionLabel,
    Expression<int>? urgency,
    Expression<DateTime>? dueAt,
    Expression<bool>? isDone,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userPlantId != null) 'user_plant_id': userPlantId,
      if (actionLabel != null) 'action_label': actionLabel,
      if (urgency != null) 'urgency': urgency,
      if (dueAt != null) 'due_at': dueAt,
      if (isDone != null) 'is_done': isDone,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareTaskRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? userPlantId,
    Value<String>? actionLabel,
    Value<int>? urgency,
    Value<DateTime>? dueAt,
    Value<bool>? isDone,
    Value<int>? rowid,
  }) {
    return CareTaskRowsCompanion(
      id: id ?? this.id,
      userPlantId: userPlantId ?? this.userPlantId,
      actionLabel: actionLabel ?? this.actionLabel,
      urgency: urgency ?? this.urgency,
      dueAt: dueAt ?? this.dueAt,
      isDone: isDone ?? this.isDone,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userPlantId.present) {
      map['user_plant_id'] = Variable<String>(userPlantId.value);
    }
    if (actionLabel.present) {
      map['action_label'] = Variable<String>(actionLabel.value);
    }
    if (urgency.present) {
      map['urgency'] = Variable<int>(urgency.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (isDone.present) {
      map['is_done'] = Variable<bool>(isDone.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareTaskRowsCompanion(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('actionLabel: $actionLabel, ')
          ..write('urgency: $urgency, ')
          ..write('dueAt: $dueAt, ')
          ..write('isDone: $isDone, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CareEventRowsTable extends CareEventRows
    with TableInfo<$CareEventRowsTable, CareEventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CareEventRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userPlantIdMeta = const VerificationMeta(
    'userPlantId',
  );
  @override
  late final GeneratedColumn<String> userPlantId = GeneratedColumn<String>(
    'user_plant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user_plant_rows (id)',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<int> kind = GeneratedColumn<int>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userPlantId,
    kind,
    label,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'care_event_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CareEventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_plant_id')) {
      context.handle(
        _userPlantIdMeta,
        userPlantId.isAcceptableOrUnknown(
          data['user_plant_id']!,
          _userPlantIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_userPlantIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CareEventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CareEventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userPlantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_plant_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kind'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $CareEventRowsTable createAlias(String alias) {
    return $CareEventRowsTable(attachedDatabase, alias);
  }
}

class CareEventRow extends DataClass implements Insertable<CareEventRow> {
  final String id;
  final String userPlantId;
  final int kind;
  final String label;
  final DateTime occurredAt;
  const CareEventRow({
    required this.id,
    required this.userPlantId,
    required this.kind,
    required this.label,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_plant_id'] = Variable<String>(userPlantId);
    map['kind'] = Variable<int>(kind);
    map['label'] = Variable<String>(label);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  CareEventRowsCompanion toCompanion(bool nullToAbsent) {
    return CareEventRowsCompanion(
      id: Value(id),
      userPlantId: Value(userPlantId),
      kind: Value(kind),
      label: Value(label),
      occurredAt: Value(occurredAt),
    );
  }

  factory CareEventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CareEventRow(
      id: serializer.fromJson<String>(json['id']),
      userPlantId: serializer.fromJson<String>(json['userPlantId']),
      kind: serializer.fromJson<int>(json['kind']),
      label: serializer.fromJson<String>(json['label']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userPlantId': serializer.toJson<String>(userPlantId),
      'kind': serializer.toJson<int>(kind),
      'label': serializer.toJson<String>(label),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  CareEventRow copyWith({
    String? id,
    String? userPlantId,
    int? kind,
    String? label,
    DateTime? occurredAt,
  }) => CareEventRow(
    id: id ?? this.id,
    userPlantId: userPlantId ?? this.userPlantId,
    kind: kind ?? this.kind,
    label: label ?? this.label,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  CareEventRow copyWithCompanion(CareEventRowsCompanion data) {
    return CareEventRow(
      id: data.id.present ? data.id.value : this.id,
      userPlantId: data.userPlantId.present
          ? data.userPlantId.value
          : this.userPlantId,
      kind: data.kind.present ? data.kind.value : this.kind,
      label: data.label.present ? data.label.value : this.label,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CareEventRow(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('kind: $kind, ')
          ..write('label: $label, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userPlantId, kind, label, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CareEventRow &&
          other.id == this.id &&
          other.userPlantId == this.userPlantId &&
          other.kind == this.kind &&
          other.label == this.label &&
          other.occurredAt == this.occurredAt);
}

class CareEventRowsCompanion extends UpdateCompanion<CareEventRow> {
  final Value<String> id;
  final Value<String> userPlantId;
  final Value<int> kind;
  final Value<String> label;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const CareEventRowsCompanion({
    this.id = const Value.absent(),
    this.userPlantId = const Value.absent(),
    this.kind = const Value.absent(),
    this.label = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CareEventRowsCompanion.insert({
    required String id,
    required String userPlantId,
    required int kind,
    required String label,
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userPlantId = Value(userPlantId),
       kind = Value(kind),
       label = Value(label),
       occurredAt = Value(occurredAt);
  static Insertable<CareEventRow> custom({
    Expression<String>? id,
    Expression<String>? userPlantId,
    Expression<int>? kind,
    Expression<String>? label,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userPlantId != null) 'user_plant_id': userPlantId,
      if (kind != null) 'kind': kind,
      if (label != null) 'label': label,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CareEventRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? userPlantId,
    Value<int>? kind,
    Value<String>? label,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return CareEventRowsCompanion(
      id: id ?? this.id,
      userPlantId: userPlantId ?? this.userPlantId,
      kind: kind ?? this.kind,
      label: label ?? this.label,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userPlantId.present) {
      map['user_plant_id'] = Variable<String>(userPlantId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<int>(kind.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CareEventRowsCompanion(')
          ..write('id: $id, ')
          ..write('userPlantId: $userPlantId, ')
          ..write('kind: $kind, ')
          ..write('label: $label, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BloomDatabase extends GeneratedDatabase {
  _$BloomDatabase(QueryExecutor e) : super(e);
  $BloomDatabaseManager get managers => $BloomDatabaseManager(this);
  late final $PlantSpeciesRowsTable plantSpeciesRows = $PlantSpeciesRowsTable(
    this,
  );
  late final $UserPlantRowsTable userPlantRows = $UserPlantRowsTable(this);
  late final $CarePlanItemRowsTable carePlanItemRows = $CarePlanItemRowsTable(
    this,
  );
  late final $CareTaskRowsTable careTaskRows = $CareTaskRowsTable(this);
  late final $CareEventRowsTable careEventRows = $CareEventRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    plantSpeciesRows,
    userPlantRows,
    carePlanItemRows,
    careTaskRows,
    careEventRows,
  ];
}

typedef $$PlantSpeciesRowsTableCreateCompanionBuilder =
    PlantSpeciesRowsCompanion Function({
      required String id,
      required String commonName,
      required String scientificName,
      required int difficulty,
      Value<String> overview,
      Value<int> accentArgb,
      Value<int> rowid,
    });
typedef $$PlantSpeciesRowsTableUpdateCompanionBuilder =
    PlantSpeciesRowsCompanion Function({
      Value<String> id,
      Value<String> commonName,
      Value<String> scientificName,
      Value<int> difficulty,
      Value<String> overview,
      Value<int> accentArgb,
      Value<int> rowid,
    });

final class $$PlantSpeciesRowsTableReferences
    extends
        BaseReferences<
          _$BloomDatabase,
          $PlantSpeciesRowsTable,
          PlantSpeciesRow
        > {
  $$PlantSpeciesRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$UserPlantRowsTable, List<UserPlantRow>>
  _userPlantRowsRefsTable(_$BloomDatabase db) => MultiTypedResultKey.fromTable(
    db.userPlantRows,
    aliasName: 'plant_species_rows__id__user_plant_rows__species_id',
  );

  $$UserPlantRowsTableProcessedTableManager get userPlantRowsRefs {
    final manager = $$UserPlantRowsTableTableManager(
      $_db,
      $_db.userPlantRows,
    ).filter((f) => f.speciesId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_userPlantRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlantSpeciesRowsTableFilterComposer
    extends Composer<_$BloomDatabase, $PlantSpeciesRowsTable> {
  $$PlantSpeciesRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get accentArgb => $composableBuilder(
    column: $table.accentArgb,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> userPlantRowsRefs(
    Expression<bool> Function($$UserPlantRowsTableFilterComposer f) f,
  ) {
    final $$UserPlantRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableFilterComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlantSpeciesRowsTableOrderingComposer
    extends Composer<_$BloomDatabase, $PlantSpeciesRowsTable> {
  $$PlantSpeciesRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get overview => $composableBuilder(
    column: $table.overview,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get accentArgb => $composableBuilder(
    column: $table.accentArgb,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PlantSpeciesRowsTableAnnotationComposer
    extends Composer<_$BloomDatabase, $PlantSpeciesRowsTable> {
  $$PlantSpeciesRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get commonName => $composableBuilder(
    column: $table.commonName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scientificName => $composableBuilder(
    column: $table.scientificName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get overview =>
      $composableBuilder(column: $table.overview, builder: (column) => column);

  GeneratedColumn<int> get accentArgb => $composableBuilder(
    column: $table.accentArgb,
    builder: (column) => column,
  );

  Expression<T> userPlantRowsRefs<T extends Object>(
    Expression<T> Function($$UserPlantRowsTableAnnotationComposer a) f,
  ) {
    final $$UserPlantRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.speciesId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlantSpeciesRowsTableTableManager
    extends
        RootTableManager<
          _$BloomDatabase,
          $PlantSpeciesRowsTable,
          PlantSpeciesRow,
          $$PlantSpeciesRowsTableFilterComposer,
          $$PlantSpeciesRowsTableOrderingComposer,
          $$PlantSpeciesRowsTableAnnotationComposer,
          $$PlantSpeciesRowsTableCreateCompanionBuilder,
          $$PlantSpeciesRowsTableUpdateCompanionBuilder,
          (PlantSpeciesRow, $$PlantSpeciesRowsTableReferences),
          PlantSpeciesRow,
          PrefetchHooks Function({bool userPlantRowsRefs})
        > {
  $$PlantSpeciesRowsTableTableManager(
    _$BloomDatabase db,
    $PlantSpeciesRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlantSpeciesRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlantSpeciesRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlantSpeciesRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> commonName = const Value.absent(),
                Value<String> scientificName = const Value.absent(),
                Value<int> difficulty = const Value.absent(),
                Value<String> overview = const Value.absent(),
                Value<int> accentArgb = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlantSpeciesRowsCompanion(
                id: id,
                commonName: commonName,
                scientificName: scientificName,
                difficulty: difficulty,
                overview: overview,
                accentArgb: accentArgb,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String commonName,
                required String scientificName,
                required int difficulty,
                Value<String> overview = const Value.absent(),
                Value<int> accentArgb = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlantSpeciesRowsCompanion.insert(
                id: id,
                commonName: commonName,
                scientificName: scientificName,
                difficulty: difficulty,
                overview: overview,
                accentArgb: accentArgb,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlantSpeciesRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlantRowsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (userPlantRowsRefs) db.userPlantRows,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (userPlantRowsRefs)
                    await $_getPrefetchedData<
                      PlantSpeciesRow,
                      $PlantSpeciesRowsTable,
                      UserPlantRow
                    >(
                      currentTable: table,
                      referencedTable: $$PlantSpeciesRowsTableReferences
                          ._userPlantRowsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PlantSpeciesRowsTableReferences(
                            db,
                            table,
                            p0,
                          ).userPlantRowsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.speciesId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlantSpeciesRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloomDatabase,
      $PlantSpeciesRowsTable,
      PlantSpeciesRow,
      $$PlantSpeciesRowsTableFilterComposer,
      $$PlantSpeciesRowsTableOrderingComposer,
      $$PlantSpeciesRowsTableAnnotationComposer,
      $$PlantSpeciesRowsTableCreateCompanionBuilder,
      $$PlantSpeciesRowsTableUpdateCompanionBuilder,
      (PlantSpeciesRow, $$PlantSpeciesRowsTableReferences),
      PlantSpeciesRow,
      PrefetchHooks Function({bool userPlantRowsRefs})
    >;
typedef $$UserPlantRowsTableCreateCompanionBuilder =
    UserPlantRowsCompanion Function({
      required String id,
      required String speciesId,
      required String displayName,
      required String statusLabel,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$UserPlantRowsTableUpdateCompanionBuilder =
    UserPlantRowsCompanion Function({
      Value<String> id,
      Value<String> speciesId,
      Value<String> displayName,
      Value<String> statusLabel,
      Value<String?> notes,
      Value<int> rowid,
    });

final class $$UserPlantRowsTableReferences
    extends BaseReferences<_$BloomDatabase, $UserPlantRowsTable, UserPlantRow> {
  $$UserPlantRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlantSpeciesRowsTable _speciesIdTable(_$BloomDatabase db) => db
      .plantSpeciesRows
      .createAlias('user_plant_rows__species_id__plant_species_rows__id');

  $$PlantSpeciesRowsTableProcessedTableManager get speciesId {
    final $_column = $_itemColumn<String>('species_id')!;

    final manager = $$PlantSpeciesRowsTableTableManager(
      $_db,
      $_db.plantSpeciesRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_speciesIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$CarePlanItemRowsTable, List<CarePlanItemRow>>
  _carePlanItemRowsRefsTable(_$BloomDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.carePlanItemRows,
        aliasName: 'user_plant_rows__id__care_plan_item_rows__user_plant_id',
      );

  $$CarePlanItemRowsTableProcessedTableManager get carePlanItemRowsRefs {
    final manager = $$CarePlanItemRowsTableTableManager(
      $_db,
      $_db.carePlanItemRows,
    ).filter((f) => f.userPlantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _carePlanItemRowsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareTaskRowsTable, List<CareTaskRow>>
  _careTaskRowsRefsTable(_$BloomDatabase db) => MultiTypedResultKey.fromTable(
    db.careTaskRows,
    aliasName: 'user_plant_rows__id__care_task_rows__user_plant_id',
  );

  $$CareTaskRowsTableProcessedTableManager get careTaskRowsRefs {
    final manager = $$CareTaskRowsTableTableManager(
      $_db,
      $_db.careTaskRows,
    ).filter((f) => f.userPlantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careTaskRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CareEventRowsTable, List<CareEventRow>>
  _careEventRowsRefsTable(_$BloomDatabase db) => MultiTypedResultKey.fromTable(
    db.careEventRows,
    aliasName: 'user_plant_rows__id__care_event_rows__user_plant_id',
  );

  $$CareEventRowsTableProcessedTableManager get careEventRowsRefs {
    final manager = $$CareEventRowsTableTableManager(
      $_db,
      $_db.careEventRows,
    ).filter((f) => f.userPlantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_careEventRowsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserPlantRowsTableFilterComposer
    extends Composer<_$BloomDatabase, $UserPlantRowsTable> {
  $$UserPlantRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$PlantSpeciesRowsTableFilterComposer get speciesId {
    final $$PlantSpeciesRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.plantSpeciesRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantSpeciesRowsTableFilterComposer(
            $db: $db,
            $table: $db.plantSpeciesRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> carePlanItemRowsRefs(
    Expression<bool> Function($$CarePlanItemRowsTableFilterComposer f) f,
  ) {
    final $$CarePlanItemRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.carePlanItemRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarePlanItemRowsTableFilterComposer(
            $db: $db,
            $table: $db.carePlanItemRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careTaskRowsRefs(
    Expression<bool> Function($$CareTaskRowsTableFilterComposer f) f,
  ) {
    final $$CareTaskRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTaskRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTaskRowsTableFilterComposer(
            $db: $db,
            $table: $db.careTaskRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> careEventRowsRefs(
    Expression<bool> Function($$CareEventRowsTableFilterComposer f) f,
  ) {
    final $$CareEventRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEventRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventRowsTableFilterComposer(
            $db: $db,
            $table: $db.careEventRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserPlantRowsTableOrderingComposer
    extends Composer<_$BloomDatabase, $UserPlantRowsTable> {
  $$UserPlantRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlantSpeciesRowsTableOrderingComposer get speciesId {
    final $$PlantSpeciesRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.plantSpeciesRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantSpeciesRowsTableOrderingComposer(
            $db: $db,
            $table: $db.plantSpeciesRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPlantRowsTableAnnotationComposer
    extends Composer<_$BloomDatabase, $UserPlantRowsTable> {
  $$UserPlantRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get statusLabel => $composableBuilder(
    column: $table.statusLabel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$PlantSpeciesRowsTableAnnotationComposer get speciesId {
    final $$PlantSpeciesRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.speciesId,
      referencedTable: $db.plantSpeciesRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlantSpeciesRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.plantSpeciesRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> carePlanItemRowsRefs<T extends Object>(
    Expression<T> Function($$CarePlanItemRowsTableAnnotationComposer a) f,
  ) {
    final $$CarePlanItemRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.carePlanItemRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarePlanItemRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.carePlanItemRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careTaskRowsRefs<T extends Object>(
    Expression<T> Function($$CareTaskRowsTableAnnotationComposer a) f,
  ) {
    final $$CareTaskRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careTaskRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareTaskRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.careTaskRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> careEventRowsRefs<T extends Object>(
    Expression<T> Function($$CareEventRowsTableAnnotationComposer a) f,
  ) {
    final $$CareEventRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.careEventRows,
      getReferencedColumn: (t) => t.userPlantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CareEventRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.careEventRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserPlantRowsTableTableManager
    extends
        RootTableManager<
          _$BloomDatabase,
          $UserPlantRowsTable,
          UserPlantRow,
          $$UserPlantRowsTableFilterComposer,
          $$UserPlantRowsTableOrderingComposer,
          $$UserPlantRowsTableAnnotationComposer,
          $$UserPlantRowsTableCreateCompanionBuilder,
          $$UserPlantRowsTableUpdateCompanionBuilder,
          (UserPlantRow, $$UserPlantRowsTableReferences),
          UserPlantRow,
          PrefetchHooks Function({
            bool speciesId,
            bool carePlanItemRowsRefs,
            bool careTaskRowsRefs,
            bool careEventRowsRefs,
          })
        > {
  $$UserPlantRowsTableTableManager(
    _$BloomDatabase db,
    $UserPlantRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPlantRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPlantRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPlantRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> speciesId = const Value.absent(),
                Value<String> displayName = const Value.absent(),
                Value<String> statusLabel = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPlantRowsCompanion(
                id: id,
                speciesId: speciesId,
                displayName: displayName,
                statusLabel: statusLabel,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String speciesId,
                required String displayName,
                required String statusLabel,
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserPlantRowsCompanion.insert(
                id: id,
                speciesId: speciesId,
                displayName: displayName,
                statusLabel: statusLabel,
                notes: notes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPlantRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                speciesId = false,
                carePlanItemRowsRefs = false,
                careTaskRowsRefs = false,
                careEventRowsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (carePlanItemRowsRefs) db.carePlanItemRows,
                    if (careTaskRowsRefs) db.careTaskRows,
                    if (careEventRowsRefs) db.careEventRows,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (speciesId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.speciesId,
                                    referencedTable:
                                        $$UserPlantRowsTableReferences
                                            ._speciesIdTable(db),
                                    referencedColumn:
                                        $$UserPlantRowsTableReferences
                                            ._speciesIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (carePlanItemRowsRefs)
                        await $_getPrefetchedData<
                          UserPlantRow,
                          $UserPlantRowsTable,
                          CarePlanItemRow
                        >(
                          currentTable: table,
                          referencedTable: $$UserPlantRowsTableReferences
                              ._carePlanItemRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserPlantRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).carePlanItemRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userPlantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careTaskRowsRefs)
                        await $_getPrefetchedData<
                          UserPlantRow,
                          $UserPlantRowsTable,
                          CareTaskRow
                        >(
                          currentTable: table,
                          referencedTable: $$UserPlantRowsTableReferences
                              ._careTaskRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserPlantRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).careTaskRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userPlantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (careEventRowsRefs)
                        await $_getPrefetchedData<
                          UserPlantRow,
                          $UserPlantRowsTable,
                          CareEventRow
                        >(
                          currentTable: table,
                          referencedTable: $$UserPlantRowsTableReferences
                              ._careEventRowsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UserPlantRowsTableReferences(
                                db,
                                table,
                                p0,
                              ).careEventRowsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.userPlantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UserPlantRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloomDatabase,
      $UserPlantRowsTable,
      UserPlantRow,
      $$UserPlantRowsTableFilterComposer,
      $$UserPlantRowsTableOrderingComposer,
      $$UserPlantRowsTableAnnotationComposer,
      $$UserPlantRowsTableCreateCompanionBuilder,
      $$UserPlantRowsTableUpdateCompanionBuilder,
      (UserPlantRow, $$UserPlantRowsTableReferences),
      UserPlantRow,
      PrefetchHooks Function({
        bool speciesId,
        bool carePlanItemRowsRefs,
        bool careTaskRowsRefs,
        bool careEventRowsRefs,
      })
    >;
typedef $$CarePlanItemRowsTableCreateCompanionBuilder =
    CarePlanItemRowsCompanion Function({
      required String id,
      required String userPlantId,
      required int kind,
      required String title,
      required String cadenceLabel,
      required int sortOrder,
      Value<int> rowid,
    });
typedef $$CarePlanItemRowsTableUpdateCompanionBuilder =
    CarePlanItemRowsCompanion Function({
      Value<String> id,
      Value<String> userPlantId,
      Value<int> kind,
      Value<String> title,
      Value<String> cadenceLabel,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$CarePlanItemRowsTableReferences
    extends
        BaseReferences<
          _$BloomDatabase,
          $CarePlanItemRowsTable,
          CarePlanItemRow
        > {
  $$CarePlanItemRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserPlantRowsTable _userPlantIdTable(_$BloomDatabase db) => db
      .userPlantRows
      .createAlias('care_plan_item_rows__user_plant_id__user_plant_rows__id');

  $$UserPlantRowsTableProcessedTableManager get userPlantId {
    final $_column = $_itemColumn<String>('user_plant_id')!;

    final manager = $$UserPlantRowsTableTableManager(
      $_db,
      $_db.userPlantRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userPlantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CarePlanItemRowsTableFilterComposer
    extends Composer<_$BloomDatabase, $CarePlanItemRowsTable> {
  $$CarePlanItemRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cadenceLabel => $composableBuilder(
    column: $table.cadenceLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$UserPlantRowsTableFilterComposer get userPlantId {
    final $$UserPlantRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableFilterComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CarePlanItemRowsTableOrderingComposer
    extends Composer<_$BloomDatabase, $CarePlanItemRowsTable> {
  $$CarePlanItemRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cadenceLabel => $composableBuilder(
    column: $table.cadenceLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserPlantRowsTableOrderingComposer get userPlantId {
    final $$UserPlantRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableOrderingComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CarePlanItemRowsTableAnnotationComposer
    extends Composer<_$BloomDatabase, $CarePlanItemRowsTable> {
  $$CarePlanItemRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get cadenceLabel => $composableBuilder(
    column: $table.cadenceLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$UserPlantRowsTableAnnotationComposer get userPlantId {
    final $$UserPlantRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CarePlanItemRowsTableTableManager
    extends
        RootTableManager<
          _$BloomDatabase,
          $CarePlanItemRowsTable,
          CarePlanItemRow,
          $$CarePlanItemRowsTableFilterComposer,
          $$CarePlanItemRowsTableOrderingComposer,
          $$CarePlanItemRowsTableAnnotationComposer,
          $$CarePlanItemRowsTableCreateCompanionBuilder,
          $$CarePlanItemRowsTableUpdateCompanionBuilder,
          (CarePlanItemRow, $$CarePlanItemRowsTableReferences),
          CarePlanItemRow,
          PrefetchHooks Function({bool userPlantId})
        > {
  $$CarePlanItemRowsTableTableManager(
    _$BloomDatabase db,
    $CarePlanItemRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CarePlanItemRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CarePlanItemRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CarePlanItemRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userPlantId = const Value.absent(),
                Value<int> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> cadenceLabel = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CarePlanItemRowsCompanion(
                id: id,
                userPlantId: userPlantId,
                kind: kind,
                title: title,
                cadenceLabel: cadenceLabel,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userPlantId,
                required int kind,
                required String title,
                required String cadenceLabel,
                required int sortOrder,
                Value<int> rowid = const Value.absent(),
              }) => CarePlanItemRowsCompanion.insert(
                id: id,
                userPlantId: userPlantId,
                kind: kind,
                title: title,
                cadenceLabel: cadenceLabel,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CarePlanItemRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userPlantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userPlantId,
                                referencedTable:
                                    $$CarePlanItemRowsTableReferences
                                        ._userPlantIdTable(db),
                                referencedColumn:
                                    $$CarePlanItemRowsTableReferences
                                        ._userPlantIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CarePlanItemRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloomDatabase,
      $CarePlanItemRowsTable,
      CarePlanItemRow,
      $$CarePlanItemRowsTableFilterComposer,
      $$CarePlanItemRowsTableOrderingComposer,
      $$CarePlanItemRowsTableAnnotationComposer,
      $$CarePlanItemRowsTableCreateCompanionBuilder,
      $$CarePlanItemRowsTableUpdateCompanionBuilder,
      (CarePlanItemRow, $$CarePlanItemRowsTableReferences),
      CarePlanItemRow,
      PrefetchHooks Function({bool userPlantId})
    >;
typedef $$CareTaskRowsTableCreateCompanionBuilder =
    CareTaskRowsCompanion Function({
      required String id,
      required String userPlantId,
      required String actionLabel,
      required int urgency,
      required DateTime dueAt,
      Value<bool> isDone,
      Value<int> rowid,
    });
typedef $$CareTaskRowsTableUpdateCompanionBuilder =
    CareTaskRowsCompanion Function({
      Value<String> id,
      Value<String> userPlantId,
      Value<String> actionLabel,
      Value<int> urgency,
      Value<DateTime> dueAt,
      Value<bool> isDone,
      Value<int> rowid,
    });

final class $$CareTaskRowsTableReferences
    extends BaseReferences<_$BloomDatabase, $CareTaskRowsTable, CareTaskRow> {
  $$CareTaskRowsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserPlantRowsTable _userPlantIdTable(_$BloomDatabase db) => db
      .userPlantRows
      .createAlias('care_task_rows__user_plant_id__user_plant_rows__id');

  $$UserPlantRowsTableProcessedTableManager get userPlantId {
    final $_column = $_itemColumn<String>('user_plant_id')!;

    final manager = $$UserPlantRowsTableTableManager(
      $_db,
      $_db.userPlantRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userPlantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareTaskRowsTableFilterComposer
    extends Composer<_$BloomDatabase, $CareTaskRowsTable> {
  $$CareTaskRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnFilters(column),
  );

  $$UserPlantRowsTableFilterComposer get userPlantId {
    final $$UserPlantRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableFilterComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareTaskRowsTableOrderingComposer
    extends Composer<_$BloomDatabase, $CareTaskRowsTable> {
  $$CareTaskRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDone => $composableBuilder(
    column: $table.isDone,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserPlantRowsTableOrderingComposer get userPlantId {
    final $$UserPlantRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableOrderingComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareTaskRowsTableAnnotationComposer
    extends Composer<_$BloomDatabase, $CareTaskRowsTable> {
  $$CareTaskRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get actionLabel => $composableBuilder(
    column: $table.actionLabel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<bool> get isDone =>
      $composableBuilder(column: $table.isDone, builder: (column) => column);

  $$UserPlantRowsTableAnnotationComposer get userPlantId {
    final $$UserPlantRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareTaskRowsTableTableManager
    extends
        RootTableManager<
          _$BloomDatabase,
          $CareTaskRowsTable,
          CareTaskRow,
          $$CareTaskRowsTableFilterComposer,
          $$CareTaskRowsTableOrderingComposer,
          $$CareTaskRowsTableAnnotationComposer,
          $$CareTaskRowsTableCreateCompanionBuilder,
          $$CareTaskRowsTableUpdateCompanionBuilder,
          (CareTaskRow, $$CareTaskRowsTableReferences),
          CareTaskRow,
          PrefetchHooks Function({bool userPlantId})
        > {
  $$CareTaskRowsTableTableManager(_$BloomDatabase db, $CareTaskRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareTaskRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareTaskRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareTaskRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userPlantId = const Value.absent(),
                Value<String> actionLabel = const Value.absent(),
                Value<int> urgency = const Value.absent(),
                Value<DateTime> dueAt = const Value.absent(),
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareTaskRowsCompanion(
                id: id,
                userPlantId: userPlantId,
                actionLabel: actionLabel,
                urgency: urgency,
                dueAt: dueAt,
                isDone: isDone,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userPlantId,
                required String actionLabel,
                required int urgency,
                required DateTime dueAt,
                Value<bool> isDone = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareTaskRowsCompanion.insert(
                id: id,
                userPlantId: userPlantId,
                actionLabel: actionLabel,
                urgency: urgency,
                dueAt: dueAt,
                isDone: isDone,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareTaskRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userPlantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userPlantId,
                                referencedTable: $$CareTaskRowsTableReferences
                                    ._userPlantIdTable(db),
                                referencedColumn: $$CareTaskRowsTableReferences
                                    ._userPlantIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareTaskRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloomDatabase,
      $CareTaskRowsTable,
      CareTaskRow,
      $$CareTaskRowsTableFilterComposer,
      $$CareTaskRowsTableOrderingComposer,
      $$CareTaskRowsTableAnnotationComposer,
      $$CareTaskRowsTableCreateCompanionBuilder,
      $$CareTaskRowsTableUpdateCompanionBuilder,
      (CareTaskRow, $$CareTaskRowsTableReferences),
      CareTaskRow,
      PrefetchHooks Function({bool userPlantId})
    >;
typedef $$CareEventRowsTableCreateCompanionBuilder =
    CareEventRowsCompanion Function({
      required String id,
      required String userPlantId,
      required int kind,
      required String label,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$CareEventRowsTableUpdateCompanionBuilder =
    CareEventRowsCompanion Function({
      Value<String> id,
      Value<String> userPlantId,
      Value<int> kind,
      Value<String> label,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$CareEventRowsTableReferences
    extends BaseReferences<_$BloomDatabase, $CareEventRowsTable, CareEventRow> {
  $$CareEventRowsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $UserPlantRowsTable _userPlantIdTable(_$BloomDatabase db) => db
      .userPlantRows
      .createAlias('care_event_rows__user_plant_id__user_plant_rows__id');

  $$UserPlantRowsTableProcessedTableManager get userPlantId {
    final $_column = $_itemColumn<String>('user_plant_id')!;

    final manager = $$UserPlantRowsTableTableManager(
      $_db,
      $_db.userPlantRows,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userPlantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CareEventRowsTableFilterComposer
    extends Composer<_$BloomDatabase, $CareEventRowsTable> {
  $$CareEventRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$UserPlantRowsTableFilterComposer get userPlantId {
    final $$UserPlantRowsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableFilterComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareEventRowsTableOrderingComposer
    extends Composer<_$BloomDatabase, $CareEventRowsTable> {
  $$CareEventRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserPlantRowsTableOrderingComposer get userPlantId {
    final $$UserPlantRowsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableOrderingComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareEventRowsTableAnnotationComposer
    extends Composer<_$BloomDatabase, $CareEventRowsTable> {
  $$CareEventRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$UserPlantRowsTableAnnotationComposer get userPlantId {
    final $$UserPlantRowsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userPlantId,
      referencedTable: $db.userPlantRows,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPlantRowsTableAnnotationComposer(
            $db: $db,
            $table: $db.userPlantRows,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CareEventRowsTableTableManager
    extends
        RootTableManager<
          _$BloomDatabase,
          $CareEventRowsTable,
          CareEventRow,
          $$CareEventRowsTableFilterComposer,
          $$CareEventRowsTableOrderingComposer,
          $$CareEventRowsTableAnnotationComposer,
          $$CareEventRowsTableCreateCompanionBuilder,
          $$CareEventRowsTableUpdateCompanionBuilder,
          (CareEventRow, $$CareEventRowsTableReferences),
          CareEventRow,
          PrefetchHooks Function({bool userPlantId})
        > {
  $$CareEventRowsTableTableManager(
    _$BloomDatabase db,
    $CareEventRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CareEventRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CareEventRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CareEventRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userPlantId = const Value.absent(),
                Value<int> kind = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CareEventRowsCompanion(
                id: id,
                userPlantId: userPlantId,
                kind: kind,
                label: label,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userPlantId,
                required int kind,
                required String label,
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => CareEventRowsCompanion.insert(
                id: id,
                userPlantId: userPlantId,
                kind: kind,
                label: label,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CareEventRowsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({userPlantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (userPlantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.userPlantId,
                                referencedTable: $$CareEventRowsTableReferences
                                    ._userPlantIdTable(db),
                                referencedColumn: $$CareEventRowsTableReferences
                                    ._userPlantIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CareEventRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$BloomDatabase,
      $CareEventRowsTable,
      CareEventRow,
      $$CareEventRowsTableFilterComposer,
      $$CareEventRowsTableOrderingComposer,
      $$CareEventRowsTableAnnotationComposer,
      $$CareEventRowsTableCreateCompanionBuilder,
      $$CareEventRowsTableUpdateCompanionBuilder,
      (CareEventRow, $$CareEventRowsTableReferences),
      CareEventRow,
      PrefetchHooks Function({bool userPlantId})
    >;

class $BloomDatabaseManager {
  final _$BloomDatabase _db;
  $BloomDatabaseManager(this._db);
  $$PlantSpeciesRowsTableTableManager get plantSpeciesRows =>
      $$PlantSpeciesRowsTableTableManager(_db, _db.plantSpeciesRows);
  $$UserPlantRowsTableTableManager get userPlantRows =>
      $$UserPlantRowsTableTableManager(_db, _db.userPlantRows);
  $$CarePlanItemRowsTableTableManager get carePlanItemRows =>
      $$CarePlanItemRowsTableTableManager(_db, _db.carePlanItemRows);
  $$CareTaskRowsTableTableManager get careTaskRows =>
      $$CareTaskRowsTableTableManager(_db, _db.careTaskRows);
  $$CareEventRowsTableTableManager get careEventRows =>
      $$CareEventRowsTableTableManager(_db, _db.careEventRows);
}
