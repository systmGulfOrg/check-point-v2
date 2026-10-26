// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CacheEntriesTable extends CacheEntries
    with TableInfo<$CacheEntriesTable, CacheEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CacheEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _jsonMeta = const VerificationMeta('json');
  @override
  late final GeneratedColumn<String> json = GeneratedColumn<String>(
    'json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, json, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cache_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<CacheEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('json')) {
      context.handle(
        _jsonMeta,
        json.isAcceptableOrUnknown(data['json']!, _jsonMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  CacheEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CacheEntry(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      json: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CacheEntriesTable createAlias(String alias) {
    return $CacheEntriesTable(attachedDatabase, alias);
  }
}

class CacheEntry extends DataClass implements Insertable<CacheEntry> {
  final String key;
  final String json;
  final DateTime updatedAt;
  const CacheEntry({
    required this.key,
    required this.json,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['json'] = Variable<String>(json);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CacheEntriesCompanion toCompanion(bool nullToAbsent) {
    return CacheEntriesCompanion(
      key: Value(key),
      json: Value(json),
      updatedAt: Value(updatedAt),
    );
  }

  factory CacheEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CacheEntry(
      key: serializer.fromJson<String>(json['key']),
      json: serializer.fromJson<String>(json['json']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'json': serializer.toJson<String>(json),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CacheEntry copyWith({String? key, String? json, DateTime? updatedAt}) =>
      CacheEntry(
        key: key ?? this.key,
        json: json ?? this.json,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  CacheEntry copyWithCompanion(CacheEntriesCompanion data) {
    return CacheEntry(
      key: data.key.present ? data.key.value : this.key,
      json: data.json.present ? data.json.value : this.json,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntry(')
          ..write('key: $key, ')
          ..write('json: $json, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, json, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CacheEntry &&
          other.key == this.key &&
          other.json == this.json &&
          other.updatedAt == this.updatedAt);
}

class CacheEntriesCompanion extends UpdateCompanion<CacheEntry> {
  final Value<String> key;
  final Value<String> json;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CacheEntriesCompanion({
    this.key = const Value.absent(),
    this.json = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CacheEntriesCompanion.insert({
    required String key,
    required String json,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       json = Value(json),
       updatedAt = Value(updatedAt);
  static Insertable<CacheEntry> custom({
    Expression<String>? key,
    Expression<String>? json,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (json != null) 'json': json,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CacheEntriesCompanion copyWith({
    Value<String>? key,
    Value<String>? json,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CacheEntriesCompanion(
      key: key ?? this.key,
      json: json ?? this.json,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (json.present) {
      map['json'] = Variable<String>(json.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CacheEntriesCompanion(')
          ..write('key: $key, ')
          ..write('json: $json, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PendingAttendanceTableTable extends PendingAttendanceTable
    with TableInfo<$PendingAttendanceTableTable, PendingAttendanceTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PendingAttendanceTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientUuidMeta = const VerificationMeta(
    'clientUuid',
  );
  @override
  late final GeneratedColumn<String> clientUuid = GeneratedColumn<String>(
    'client_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wallClockMeta = const VerificationMeta(
    'wallClock',
  );
  @override
  late final GeneratedColumn<DateTime> wallClock = GeneratedColumn<DateTime>(
    'wall_clock',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monotonicMsMeta = const VerificationMeta(
    'monotonicMs',
  );
  @override
  late final GeneratedColumn<BigInt> monotonicMs = GeneratedColumn<BigInt>(
    'monotonic_ms',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bootIdMeta = const VerificationMeta('bootId');
  @override
  late final GeneratedColumn<String> bootId = GeneratedColumn<String>(
    'boot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anchorServerTimeMeta = const VerificationMeta(
    'anchorServerTime',
  );
  @override
  late final GeneratedColumn<DateTime> anchorServerTime =
      GeneratedColumn<DateTime>(
        'anchor_server_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _anchorMonotonicMsMeta = const VerificationMeta(
    'anchorMonotonicMs',
  );
  @override
  late final GeneratedColumn<BigInt> anchorMonotonicMs =
      GeneratedColumn<BigInt>(
        'anchor_monotonic_ms',
        aliasedName,
        true,
        type: DriftSqlType.bigInt,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _anchorBootIdMeta = const VerificationMeta(
    'anchorBootId',
  );
  @override
  late final GeneratedColumn<String> anchorBootId = GeneratedColumn<String>(
    'anchor_boot_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _accuracyMMeta = const VerificationMeta(
    'accuracyM',
  );
  @override
  late final GeneratedColumn<double> accuracyM = GeneratedColumn<double>(
    'accuracy_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _areaMeta = const VerificationMeta('area');
  @override
  late final GeneratedColumn<String> area = GeneratedColumn<String>(
    'area',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _mockLocationDetectedMeta =
      const VerificationMeta('mockLocationDetected');
  @override
  late final GeneratedColumn<bool> mockLocationDetected = GeneratedColumn<bool>(
    'mock_location_detected',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("mock_location_detected" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('queued'),
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    clientUuid,
    type,
    wallClock,
    monotonicMs,
    bootId,
    anchorServerTime,
    anchorMonotonicMs,
    anchorBootId,
    latitude,
    longitude,
    accuracyM,
    area,
    customerId,
    mockLocationDetected,
    status,
    reason,
    createdAt,
    retryCount,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pending_attendance_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PendingAttendanceTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_uuid')) {
      context.handle(
        _clientUuidMeta,
        clientUuid.isAcceptableOrUnknown(data['client_uuid']!, _clientUuidMeta),
      );
    } else if (isInserting) {
      context.missing(_clientUuidMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('wall_clock')) {
      context.handle(
        _wallClockMeta,
        wallClock.isAcceptableOrUnknown(data['wall_clock']!, _wallClockMeta),
      );
    } else if (isInserting) {
      context.missing(_wallClockMeta);
    }
    if (data.containsKey('monotonic_ms')) {
      context.handle(
        _monotonicMsMeta,
        monotonicMs.isAcceptableOrUnknown(
          data['monotonic_ms']!,
          _monotonicMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monotonicMsMeta);
    }
    if (data.containsKey('boot_id')) {
      context.handle(
        _bootIdMeta,
        bootId.isAcceptableOrUnknown(data['boot_id']!, _bootIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bootIdMeta);
    }
    if (data.containsKey('anchor_server_time')) {
      context.handle(
        _anchorServerTimeMeta,
        anchorServerTime.isAcceptableOrUnknown(
          data['anchor_server_time']!,
          _anchorServerTimeMeta,
        ),
      );
    }
    if (data.containsKey('anchor_monotonic_ms')) {
      context.handle(
        _anchorMonotonicMsMeta,
        anchorMonotonicMs.isAcceptableOrUnknown(
          data['anchor_monotonic_ms']!,
          _anchorMonotonicMsMeta,
        ),
      );
    }
    if (data.containsKey('anchor_boot_id')) {
      context.handle(
        _anchorBootIdMeta,
        anchorBootId.isAcceptableOrUnknown(
          data['anchor_boot_id']!,
          _anchorBootIdMeta,
        ),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('accuracy_m')) {
      context.handle(
        _accuracyMMeta,
        accuracyM.isAcceptableOrUnknown(data['accuracy_m']!, _accuracyMMeta),
      );
    }
    if (data.containsKey('area')) {
      context.handle(
        _areaMeta,
        area.isAcceptableOrUnknown(data['area']!, _areaMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('mock_location_detected')) {
      context.handle(
        _mockLocationDetectedMeta,
        mockLocationDetected.isAcceptableOrUnknown(
          data['mock_location_detected']!,
          _mockLocationDetectedMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientUuid};
  @override
  PendingAttendanceTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PendingAttendanceTableData(
      clientUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_uuid'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      wallClock: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wall_clock'],
      )!,
      monotonicMs: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}monotonic_ms'],
      )!,
      bootId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}boot_id'],
      )!,
      anchorServerTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}anchor_server_time'],
      ),
      anchorMonotonicMs: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}anchor_monotonic_ms'],
      ),
      anchorBootId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}anchor_boot_id'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      accuracyM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}accuracy_m'],
      ),
      area: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}area'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      mockLocationDetected: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}mock_location_detected'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
    );
  }

  @override
  $PendingAttendanceTableTable createAlias(String alias) {
    return $PendingAttendanceTableTable(attachedDatabase, alias);
  }
}

class PendingAttendanceTableData extends DataClass
    implements Insertable<PendingAttendanceTableData> {
  final String clientUuid;
  final String type;
  final DateTime wallClock;
  final BigInt monotonicMs;
  final String bootId;
  final DateTime? anchorServerTime;
  final BigInt? anchorMonotonicMs;
  final String? anchorBootId;
  final double? latitude;
  final double? longitude;
  final double? accuracyM;
  final String? area;
  final String? customerId;
  final bool mockLocationDetected;
  final String status;
  final String? reason;
  final DateTime createdAt;
  final int retryCount;
  const PendingAttendanceTableData({
    required this.clientUuid,
    required this.type,
    required this.wallClock,
    required this.monotonicMs,
    required this.bootId,
    this.anchorServerTime,
    this.anchorMonotonicMs,
    this.anchorBootId,
    this.latitude,
    this.longitude,
    this.accuracyM,
    this.area,
    this.customerId,
    required this.mockLocationDetected,
    required this.status,
    this.reason,
    required this.createdAt,
    required this.retryCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_uuid'] = Variable<String>(clientUuid);
    map['type'] = Variable<String>(type);
    map['wall_clock'] = Variable<DateTime>(wallClock);
    map['monotonic_ms'] = Variable<BigInt>(monotonicMs);
    map['boot_id'] = Variable<String>(bootId);
    if (!nullToAbsent || anchorServerTime != null) {
      map['anchor_server_time'] = Variable<DateTime>(anchorServerTime);
    }
    if (!nullToAbsent || anchorMonotonicMs != null) {
      map['anchor_monotonic_ms'] = Variable<BigInt>(anchorMonotonicMs);
    }
    if (!nullToAbsent || anchorBootId != null) {
      map['anchor_boot_id'] = Variable<String>(anchorBootId);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || accuracyM != null) {
      map['accuracy_m'] = Variable<double>(accuracyM);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(area);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['mock_location_detected'] = Variable<bool>(mockLocationDetected);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['retry_count'] = Variable<int>(retryCount);
    return map;
  }

  PendingAttendanceTableCompanion toCompanion(bool nullToAbsent) {
    return PendingAttendanceTableCompanion(
      clientUuid: Value(clientUuid),
      type: Value(type),
      wallClock: Value(wallClock),
      monotonicMs: Value(monotonicMs),
      bootId: Value(bootId),
      anchorServerTime: anchorServerTime == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorServerTime),
      anchorMonotonicMs: anchorMonotonicMs == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorMonotonicMs),
      anchorBootId: anchorBootId == null && nullToAbsent
          ? const Value.absent()
          : Value(anchorBootId),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      accuracyM: accuracyM == null && nullToAbsent
          ? const Value.absent()
          : Value(accuracyM),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      mockLocationDetected: Value(mockLocationDetected),
      status: Value(status),
      reason: reason == null && nullToAbsent
          ? const Value.absent()
          : Value(reason),
      createdAt: Value(createdAt),
      retryCount: Value(retryCount),
    );
  }

  factory PendingAttendanceTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PendingAttendanceTableData(
      clientUuid: serializer.fromJson<String>(json['clientUuid']),
      type: serializer.fromJson<String>(json['type']),
      wallClock: serializer.fromJson<DateTime>(json['wallClock']),
      monotonicMs: serializer.fromJson<BigInt>(json['monotonicMs']),
      bootId: serializer.fromJson<String>(json['bootId']),
      anchorServerTime: serializer.fromJson<DateTime?>(
        json['anchorServerTime'],
      ),
      anchorMonotonicMs: serializer.fromJson<BigInt?>(
        json['anchorMonotonicMs'],
      ),
      anchorBootId: serializer.fromJson<String?>(json['anchorBootId']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      accuracyM: serializer.fromJson<double?>(json['accuracyM']),
      area: serializer.fromJson<String?>(json['area']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      mockLocationDetected: serializer.fromJson<bool>(
        json['mockLocationDetected'],
      ),
      status: serializer.fromJson<String>(json['status']),
      reason: serializer.fromJson<String?>(json['reason']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientUuid': serializer.toJson<String>(clientUuid),
      'type': serializer.toJson<String>(type),
      'wallClock': serializer.toJson<DateTime>(wallClock),
      'monotonicMs': serializer.toJson<BigInt>(monotonicMs),
      'bootId': serializer.toJson<String>(bootId),
      'anchorServerTime': serializer.toJson<DateTime?>(anchorServerTime),
      'anchorMonotonicMs': serializer.toJson<BigInt?>(anchorMonotonicMs),
      'anchorBootId': serializer.toJson<String?>(anchorBootId),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'accuracyM': serializer.toJson<double?>(accuracyM),
      'area': serializer.toJson<String?>(area),
      'customerId': serializer.toJson<String?>(customerId),
      'mockLocationDetected': serializer.toJson<bool>(mockLocationDetected),
      'status': serializer.toJson<String>(status),
      'reason': serializer.toJson<String?>(reason),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'retryCount': serializer.toJson<int>(retryCount),
    };
  }

  PendingAttendanceTableData copyWith({
    String? clientUuid,
    String? type,
    DateTime? wallClock,
    BigInt? monotonicMs,
    String? bootId,
    Value<DateTime?> anchorServerTime = const Value.absent(),
    Value<BigInt?> anchorMonotonicMs = const Value.absent(),
    Value<String?> anchorBootId = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<double?> accuracyM = const Value.absent(),
    Value<String?> area = const Value.absent(),
    Value<String?> customerId = const Value.absent(),
    bool? mockLocationDetected,
    String? status,
    Value<String?> reason = const Value.absent(),
    DateTime? createdAt,
    int? retryCount,
  }) => PendingAttendanceTableData(
    clientUuid: clientUuid ?? this.clientUuid,
    type: type ?? this.type,
    wallClock: wallClock ?? this.wallClock,
    monotonicMs: monotonicMs ?? this.monotonicMs,
    bootId: bootId ?? this.bootId,
    anchorServerTime: anchorServerTime.present
        ? anchorServerTime.value
        : this.anchorServerTime,
    anchorMonotonicMs: anchorMonotonicMs.present
        ? anchorMonotonicMs.value
        : this.anchorMonotonicMs,
    anchorBootId: anchorBootId.present ? anchorBootId.value : this.anchorBootId,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    accuracyM: accuracyM.present ? accuracyM.value : this.accuracyM,
    area: area.present ? area.value : this.area,
    customerId: customerId.present ? customerId.value : this.customerId,
    mockLocationDetected: mockLocationDetected ?? this.mockLocationDetected,
    status: status ?? this.status,
    reason: reason.present ? reason.value : this.reason,
    createdAt: createdAt ?? this.createdAt,
    retryCount: retryCount ?? this.retryCount,
  );
  PendingAttendanceTableData copyWithCompanion(
    PendingAttendanceTableCompanion data,
  ) {
    return PendingAttendanceTableData(
      clientUuid: data.clientUuid.present
          ? data.clientUuid.value
          : this.clientUuid,
      type: data.type.present ? data.type.value : this.type,
      wallClock: data.wallClock.present ? data.wallClock.value : this.wallClock,
      monotonicMs: data.monotonicMs.present
          ? data.monotonicMs.value
          : this.monotonicMs,
      bootId: data.bootId.present ? data.bootId.value : this.bootId,
      anchorServerTime: data.anchorServerTime.present
          ? data.anchorServerTime.value
          : this.anchorServerTime,
      anchorMonotonicMs: data.anchorMonotonicMs.present
          ? data.anchorMonotonicMs.value
          : this.anchorMonotonicMs,
      anchorBootId: data.anchorBootId.present
          ? data.anchorBootId.value
          : this.anchorBootId,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      accuracyM: data.accuracyM.present ? data.accuracyM.value : this.accuracyM,
      area: data.area.present ? data.area.value : this.area,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      mockLocationDetected: data.mockLocationDetected.present
          ? data.mockLocationDetected.value
          : this.mockLocationDetected,
      status: data.status.present ? data.status.value : this.status,
      reason: data.reason.present ? data.reason.value : this.reason,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PendingAttendanceTableData(')
          ..write('clientUuid: $clientUuid, ')
          ..write('type: $type, ')
          ..write('wallClock: $wallClock, ')
          ..write('monotonicMs: $monotonicMs, ')
          ..write('bootId: $bootId, ')
          ..write('anchorServerTime: $anchorServerTime, ')
          ..write('anchorMonotonicMs: $anchorMonotonicMs, ')
          ..write('anchorBootId: $anchorBootId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('area: $area, ')
          ..write('customerId: $customerId, ')
          ..write('mockLocationDetected: $mockLocationDetected, ')
          ..write('status: $status, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    clientUuid,
    type,
    wallClock,
    monotonicMs,
    bootId,
    anchorServerTime,
    anchorMonotonicMs,
    anchorBootId,
    latitude,
    longitude,
    accuracyM,
    area,
    customerId,
    mockLocationDetected,
    status,
    reason,
    createdAt,
    retryCount,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PendingAttendanceTableData &&
          other.clientUuid == this.clientUuid &&
          other.type == this.type &&
          other.wallClock == this.wallClock &&
          other.monotonicMs == this.monotonicMs &&
          other.bootId == this.bootId &&
          other.anchorServerTime == this.anchorServerTime &&
          other.anchorMonotonicMs == this.anchorMonotonicMs &&
          other.anchorBootId == this.anchorBootId &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.accuracyM == this.accuracyM &&
          other.area == this.area &&
          other.customerId == this.customerId &&
          other.mockLocationDetected == this.mockLocationDetected &&
          other.status == this.status &&
          other.reason == this.reason &&
          other.createdAt == this.createdAt &&
          other.retryCount == this.retryCount);
}

class PendingAttendanceTableCompanion
    extends UpdateCompanion<PendingAttendanceTableData> {
  final Value<String> clientUuid;
  final Value<String> type;
  final Value<DateTime> wallClock;
  final Value<BigInt> monotonicMs;
  final Value<String> bootId;
  final Value<DateTime?> anchorServerTime;
  final Value<BigInt?> anchorMonotonicMs;
  final Value<String?> anchorBootId;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<double?> accuracyM;
  final Value<String?> area;
  final Value<String?> customerId;
  final Value<bool> mockLocationDetected;
  final Value<String> status;
  final Value<String?> reason;
  final Value<DateTime> createdAt;
  final Value<int> retryCount;
  final Value<int> rowid;
  const PendingAttendanceTableCompanion({
    this.clientUuid = const Value.absent(),
    this.type = const Value.absent(),
    this.wallClock = const Value.absent(),
    this.monotonicMs = const Value.absent(),
    this.bootId = const Value.absent(),
    this.anchorServerTime = const Value.absent(),
    this.anchorMonotonicMs = const Value.absent(),
    this.anchorBootId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.area = const Value.absent(),
    this.customerId = const Value.absent(),
    this.mockLocationDetected = const Value.absent(),
    this.status = const Value.absent(),
    this.reason = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PendingAttendanceTableCompanion.insert({
    required String clientUuid,
    required String type,
    required DateTime wallClock,
    required BigInt monotonicMs,
    required String bootId,
    this.anchorServerTime = const Value.absent(),
    this.anchorMonotonicMs = const Value.absent(),
    this.anchorBootId = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.accuracyM = const Value.absent(),
    this.area = const Value.absent(),
    this.customerId = const Value.absent(),
    this.mockLocationDetected = const Value.absent(),
    this.status = const Value.absent(),
    this.reason = const Value.absent(),
    required DateTime createdAt,
    this.retryCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : clientUuid = Value(clientUuid),
       type = Value(type),
       wallClock = Value(wallClock),
       monotonicMs = Value(monotonicMs),
       bootId = Value(bootId),
       createdAt = Value(createdAt);
  static Insertable<PendingAttendanceTableData> custom({
    Expression<String>? clientUuid,
    Expression<String>? type,
    Expression<DateTime>? wallClock,
    Expression<BigInt>? monotonicMs,
    Expression<String>? bootId,
    Expression<DateTime>? anchorServerTime,
    Expression<BigInt>? anchorMonotonicMs,
    Expression<String>? anchorBootId,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<double>? accuracyM,
    Expression<String>? area,
    Expression<String>? customerId,
    Expression<bool>? mockLocationDetected,
    Expression<String>? status,
    Expression<String>? reason,
    Expression<DateTime>? createdAt,
    Expression<int>? retryCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientUuid != null) 'client_uuid': clientUuid,
      if (type != null) 'type': type,
      if (wallClock != null) 'wall_clock': wallClock,
      if (monotonicMs != null) 'monotonic_ms': monotonicMs,
      if (bootId != null) 'boot_id': bootId,
      if (anchorServerTime != null) 'anchor_server_time': anchorServerTime,
      if (anchorMonotonicMs != null) 'anchor_monotonic_ms': anchorMonotonicMs,
      if (anchorBootId != null) 'anchor_boot_id': anchorBootId,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (accuracyM != null) 'accuracy_m': accuracyM,
      if (area != null) 'area': area,
      if (customerId != null) 'customer_id': customerId,
      if (mockLocationDetected != null)
        'mock_location_detected': mockLocationDetected,
      if (status != null) 'status': status,
      if (reason != null) 'reason': reason,
      if (createdAt != null) 'created_at': createdAt,
      if (retryCount != null) 'retry_count': retryCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PendingAttendanceTableCompanion copyWith({
    Value<String>? clientUuid,
    Value<String>? type,
    Value<DateTime>? wallClock,
    Value<BigInt>? monotonicMs,
    Value<String>? bootId,
    Value<DateTime?>? anchorServerTime,
    Value<BigInt?>? anchorMonotonicMs,
    Value<String?>? anchorBootId,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<double?>? accuracyM,
    Value<String?>? area,
    Value<String?>? customerId,
    Value<bool>? mockLocationDetected,
    Value<String>? status,
    Value<String?>? reason,
    Value<DateTime>? createdAt,
    Value<int>? retryCount,
    Value<int>? rowid,
  }) {
    return PendingAttendanceTableCompanion(
      clientUuid: clientUuid ?? this.clientUuid,
      type: type ?? this.type,
      wallClock: wallClock ?? this.wallClock,
      monotonicMs: monotonicMs ?? this.monotonicMs,
      bootId: bootId ?? this.bootId,
      anchorServerTime: anchorServerTime ?? this.anchorServerTime,
      anchorMonotonicMs: anchorMonotonicMs ?? this.anchorMonotonicMs,
      anchorBootId: anchorBootId ?? this.anchorBootId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      accuracyM: accuracyM ?? this.accuracyM,
      area: area ?? this.area,
      customerId: customerId ?? this.customerId,
      mockLocationDetected: mockLocationDetected ?? this.mockLocationDetected,
      status: status ?? this.status,
      reason: reason ?? this.reason,
      createdAt: createdAt ?? this.createdAt,
      retryCount: retryCount ?? this.retryCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientUuid.present) {
      map['client_uuid'] = Variable<String>(clientUuid.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (wallClock.present) {
      map['wall_clock'] = Variable<DateTime>(wallClock.value);
    }
    if (monotonicMs.present) {
      map['monotonic_ms'] = Variable<BigInt>(monotonicMs.value);
    }
    if (bootId.present) {
      map['boot_id'] = Variable<String>(bootId.value);
    }
    if (anchorServerTime.present) {
      map['anchor_server_time'] = Variable<DateTime>(anchorServerTime.value);
    }
    if (anchorMonotonicMs.present) {
      map['anchor_monotonic_ms'] = Variable<BigInt>(anchorMonotonicMs.value);
    }
    if (anchorBootId.present) {
      map['anchor_boot_id'] = Variable<String>(anchorBootId.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (accuracyM.present) {
      map['accuracy_m'] = Variable<double>(accuracyM.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(area.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (mockLocationDetected.present) {
      map['mock_location_detected'] = Variable<bool>(
        mockLocationDetected.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PendingAttendanceTableCompanion(')
          ..write('clientUuid: $clientUuid, ')
          ..write('type: $type, ')
          ..write('wallClock: $wallClock, ')
          ..write('monotonicMs: $monotonicMs, ')
          ..write('bootId: $bootId, ')
          ..write('anchorServerTime: $anchorServerTime, ')
          ..write('anchorMonotonicMs: $anchorMonotonicMs, ')
          ..write('anchorBootId: $anchorBootId, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('accuracyM: $accuracyM, ')
          ..write('area: $area, ')
          ..write('customerId: $customerId, ')
          ..write('mockLocationDetected: $mockLocationDetected, ')
          ..write('status: $status, ')
          ..write('reason: $reason, ')
          ..write('createdAt: $createdAt, ')
          ..write('retryCount: $retryCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeAnchorsTable extends TimeAnchors
    with TableInfo<$TimeAnchorsTable, TimeAnchor> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeAnchorsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _serverTimeMeta = const VerificationMeta(
    'serverTime',
  );
  @override
  late final GeneratedColumn<DateTime> serverTime = GeneratedColumn<DateTime>(
    'server_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _monotonicMsMeta = const VerificationMeta(
    'monotonicMs',
  );
  @override
  late final GeneratedColumn<BigInt> monotonicMs = GeneratedColumn<BigInt>(
    'monotonic_ms',
    aliasedName,
    false,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bootIdMeta = const VerificationMeta('bootId');
  @override
  late final GeneratedColumn<String> bootId = GeneratedColumn<String>(
    'boot_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    serverTime,
    monotonicMs,
    bootId,
    recordedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_anchors';
  @override
  VerificationContext validateIntegrity(
    Insertable<TimeAnchor> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('server_time')) {
      context.handle(
        _serverTimeMeta,
        serverTime.isAcceptableOrUnknown(data['server_time']!, _serverTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_serverTimeMeta);
    }
    if (data.containsKey('monotonic_ms')) {
      context.handle(
        _monotonicMsMeta,
        monotonicMs.isAcceptableOrUnknown(
          data['monotonic_ms']!,
          _monotonicMsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monotonicMsMeta);
    }
    if (data.containsKey('boot_id')) {
      context.handle(
        _bootIdMeta,
        bootId.isAcceptableOrUnknown(data['boot_id']!, _bootIdMeta),
      );
    } else if (isInserting) {
      context.missing(_bootIdMeta);
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeAnchor map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeAnchor(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      serverTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}server_time'],
      )!,
      monotonicMs: attachedDatabase.typeMapping.read(
        DriftSqlType.bigInt,
        data['${effectivePrefix}monotonic_ms'],
      )!,
      bootId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}boot_id'],
      )!,
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
    );
  }

  @override
  $TimeAnchorsTable createAlias(String alias) {
    return $TimeAnchorsTable(attachedDatabase, alias);
  }
}

class TimeAnchor extends DataClass implements Insertable<TimeAnchor> {
  final int id;
  final DateTime serverTime;
  final BigInt monotonicMs;
  final String bootId;
  final DateTime recordedAt;
  const TimeAnchor({
    required this.id,
    required this.serverTime,
    required this.monotonicMs,
    required this.bootId,
    required this.recordedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['server_time'] = Variable<DateTime>(serverTime);
    map['monotonic_ms'] = Variable<BigInt>(monotonicMs);
    map['boot_id'] = Variable<String>(bootId);
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    return map;
  }

  TimeAnchorsCompanion toCompanion(bool nullToAbsent) {
    return TimeAnchorsCompanion(
      id: Value(id),
      serverTime: Value(serverTime),
      monotonicMs: Value(monotonicMs),
      bootId: Value(bootId),
      recordedAt: Value(recordedAt),
    );
  }

  factory TimeAnchor.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeAnchor(
      id: serializer.fromJson<int>(json['id']),
      serverTime: serializer.fromJson<DateTime>(json['serverTime']),
      monotonicMs: serializer.fromJson<BigInt>(json['monotonicMs']),
      bootId: serializer.fromJson<String>(json['bootId']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'serverTime': serializer.toJson<DateTime>(serverTime),
      'monotonicMs': serializer.toJson<BigInt>(monotonicMs),
      'bootId': serializer.toJson<String>(bootId),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
    };
  }

  TimeAnchor copyWith({
    int? id,
    DateTime? serverTime,
    BigInt? monotonicMs,
    String? bootId,
    DateTime? recordedAt,
  }) => TimeAnchor(
    id: id ?? this.id,
    serverTime: serverTime ?? this.serverTime,
    monotonicMs: monotonicMs ?? this.monotonicMs,
    bootId: bootId ?? this.bootId,
    recordedAt: recordedAt ?? this.recordedAt,
  );
  TimeAnchor copyWithCompanion(TimeAnchorsCompanion data) {
    return TimeAnchor(
      id: data.id.present ? data.id.value : this.id,
      serverTime: data.serverTime.present
          ? data.serverTime.value
          : this.serverTime,
      monotonicMs: data.monotonicMs.present
          ? data.monotonicMs.value
          : this.monotonicMs,
      bootId: data.bootId.present ? data.bootId.value : this.bootId,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeAnchor(')
          ..write('id: $id, ')
          ..write('serverTime: $serverTime, ')
          ..write('monotonicMs: $monotonicMs, ')
          ..write('bootId: $bootId, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, serverTime, monotonicMs, bootId, recordedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeAnchor &&
          other.id == this.id &&
          other.serverTime == this.serverTime &&
          other.monotonicMs == this.monotonicMs &&
          other.bootId == this.bootId &&
          other.recordedAt == this.recordedAt);
}

class TimeAnchorsCompanion extends UpdateCompanion<TimeAnchor> {
  final Value<int> id;
  final Value<DateTime> serverTime;
  final Value<BigInt> monotonicMs;
  final Value<String> bootId;
  final Value<DateTime> recordedAt;
  const TimeAnchorsCompanion({
    this.id = const Value.absent(),
    this.serverTime = const Value.absent(),
    this.monotonicMs = const Value.absent(),
    this.bootId = const Value.absent(),
    this.recordedAt = const Value.absent(),
  });
  TimeAnchorsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime serverTime,
    required BigInt monotonicMs,
    required String bootId,
    required DateTime recordedAt,
  }) : serverTime = Value(serverTime),
       monotonicMs = Value(monotonicMs),
       bootId = Value(bootId),
       recordedAt = Value(recordedAt);
  static Insertable<TimeAnchor> custom({
    Expression<int>? id,
    Expression<DateTime>? serverTime,
    Expression<BigInt>? monotonicMs,
    Expression<String>? bootId,
    Expression<DateTime>? recordedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (serverTime != null) 'server_time': serverTime,
      if (monotonicMs != null) 'monotonic_ms': monotonicMs,
      if (bootId != null) 'boot_id': bootId,
      if (recordedAt != null) 'recorded_at': recordedAt,
    });
  }

  TimeAnchorsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? serverTime,
    Value<BigInt>? monotonicMs,
    Value<String>? bootId,
    Value<DateTime>? recordedAt,
  }) {
    return TimeAnchorsCompanion(
      id: id ?? this.id,
      serverTime: serverTime ?? this.serverTime,
      monotonicMs: monotonicMs ?? this.monotonicMs,
      bootId: bootId ?? this.bootId,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (serverTime.present) {
      map['server_time'] = Variable<DateTime>(serverTime.value);
    }
    if (monotonicMs.present) {
      map['monotonic_ms'] = Variable<BigInt>(monotonicMs.value);
    }
    if (bootId.present) {
      map['boot_id'] = Variable<String>(bootId.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeAnchorsCompanion(')
          ..write('id: $id, ')
          ..write('serverTime: $serverTime, ')
          ..write('monotonicMs: $monotonicMs, ')
          ..write('bootId: $bootId, ')
          ..write('recordedAt: $recordedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CacheEntriesTable cacheEntries = $CacheEntriesTable(this);
  late final $PendingAttendanceTableTable pendingAttendanceTable =
      $PendingAttendanceTableTable(this);
  late final $TimeAnchorsTable timeAnchors = $TimeAnchorsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    cacheEntries,
    pendingAttendanceTable,
    timeAnchors,
  ];
}

typedef $$CacheEntriesTableCreateCompanionBuilder =
    CacheEntriesCompanion Function({
      required String key,
      required String json,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CacheEntriesTableUpdateCompanionBuilder =
    CacheEntriesCompanion Function({
      Value<String> key,
      Value<String> json,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$CacheEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CacheEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get json => $composableBuilder(
    column: $table.json,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CacheEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CacheEntriesTable> {
  $$CacheEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get json =>
      $composableBuilder(column: $table.json, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CacheEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CacheEntriesTable,
          CacheEntry,
          $$CacheEntriesTableFilterComposer,
          $$CacheEntriesTableOrderingComposer,
          $$CacheEntriesTableAnnotationComposer,
          $$CacheEntriesTableCreateCompanionBuilder,
          $$CacheEntriesTableUpdateCompanionBuilder,
          (
            CacheEntry,
            BaseReferences<_$AppDatabase, $CacheEntriesTable, CacheEntry>,
          ),
          CacheEntry,
          PrefetchHooks Function()
        > {
  $$CacheEntriesTableTableManager(_$AppDatabase db, $CacheEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CacheEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CacheEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CacheEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> json = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesCompanion(
                key: key,
                json: json,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required String json,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CacheEntriesCompanion.insert(
                key: key,
                json: json,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CacheEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CacheEntriesTable,
      CacheEntry,
      $$CacheEntriesTableFilterComposer,
      $$CacheEntriesTableOrderingComposer,
      $$CacheEntriesTableAnnotationComposer,
      $$CacheEntriesTableCreateCompanionBuilder,
      $$CacheEntriesTableUpdateCompanionBuilder,
      (
        CacheEntry,
        BaseReferences<_$AppDatabase, $CacheEntriesTable, CacheEntry>,
      ),
      CacheEntry,
      PrefetchHooks Function()
    >;
typedef $$PendingAttendanceTableTableCreateCompanionBuilder =
    PendingAttendanceTableCompanion Function({
      required String clientUuid,
      required String type,
      required DateTime wallClock,
      required BigInt monotonicMs,
      required String bootId,
      Value<DateTime?> anchorServerTime,
      Value<BigInt?> anchorMonotonicMs,
      Value<String?> anchorBootId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracyM,
      Value<String?> area,
      Value<String?> customerId,
      Value<bool> mockLocationDetected,
      Value<String> status,
      Value<String?> reason,
      required DateTime createdAt,
      Value<int> retryCount,
      Value<int> rowid,
    });
typedef $$PendingAttendanceTableTableUpdateCompanionBuilder =
    PendingAttendanceTableCompanion Function({
      Value<String> clientUuid,
      Value<String> type,
      Value<DateTime> wallClock,
      Value<BigInt> monotonicMs,
      Value<String> bootId,
      Value<DateTime?> anchorServerTime,
      Value<BigInt?> anchorMonotonicMs,
      Value<String?> anchorBootId,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<double?> accuracyM,
      Value<String?> area,
      Value<String?> customerId,
      Value<bool> mockLocationDetected,
      Value<String> status,
      Value<String?> reason,
      Value<DateTime> createdAt,
      Value<int> retryCount,
      Value<int> rowid,
    });

class $$PendingAttendanceTableTableFilterComposer
    extends Composer<_$AppDatabase, $PendingAttendanceTableTable> {
  $$PendingAttendanceTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wallClock => $composableBuilder(
    column: $table.wallClock,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bootId => $composableBuilder(
    column: $table.bootId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get anchorServerTime => $composableBuilder(
    column: $table.anchorServerTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get anchorMonotonicMs => $composableBuilder(
    column: $table.anchorMonotonicMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get anchorBootId => $composableBuilder(
    column: $table.anchorBootId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get mockLocationDetected => $composableBuilder(
    column: $table.mockLocationDetected,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PendingAttendanceTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PendingAttendanceTableTable> {
  $$PendingAttendanceTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wallClock => $composableBuilder(
    column: $table.wallClock,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bootId => $composableBuilder(
    column: $table.bootId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get anchorServerTime => $composableBuilder(
    column: $table.anchorServerTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get anchorMonotonicMs => $composableBuilder(
    column: $table.anchorMonotonicMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get anchorBootId => $composableBuilder(
    column: $table.anchorBootId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get accuracyM => $composableBuilder(
    column: $table.accuracyM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get mockLocationDetected => $composableBuilder(
    column: $table.mockLocationDetected,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PendingAttendanceTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PendingAttendanceTableTable> {
  $$PendingAttendanceTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientUuid => $composableBuilder(
    column: $table.clientUuid,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get wallClock =>
      $composableBuilder(column: $table.wallClock, builder: (column) => column);

  GeneratedColumn<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bootId =>
      $composableBuilder(column: $table.bootId, builder: (column) => column);

  GeneratedColumn<DateTime> get anchorServerTime => $composableBuilder(
    column: $table.anchorServerTime,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get anchorMonotonicMs => $composableBuilder(
    column: $table.anchorMonotonicMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get anchorBootId => $composableBuilder(
    column: $table.anchorBootId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get accuracyM =>
      $composableBuilder(column: $table.accuracyM, builder: (column) => column);

  GeneratedColumn<String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get mockLocationDetected => $composableBuilder(
    column: $table.mockLocationDetected,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );
}

class $$PendingAttendanceTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PendingAttendanceTableTable,
          PendingAttendanceTableData,
          $$PendingAttendanceTableTableFilterComposer,
          $$PendingAttendanceTableTableOrderingComposer,
          $$PendingAttendanceTableTableAnnotationComposer,
          $$PendingAttendanceTableTableCreateCompanionBuilder,
          $$PendingAttendanceTableTableUpdateCompanionBuilder,
          (
            PendingAttendanceTableData,
            BaseReferences<
              _$AppDatabase,
              $PendingAttendanceTableTable,
              PendingAttendanceTableData
            >,
          ),
          PendingAttendanceTableData,
          PrefetchHooks Function()
        > {
  $$PendingAttendanceTableTableTableManager(
    _$AppDatabase db,
    $PendingAttendanceTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PendingAttendanceTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$PendingAttendanceTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$PendingAttendanceTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> clientUuid = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<DateTime> wallClock = const Value.absent(),
                Value<BigInt> monotonicMs = const Value.absent(),
                Value<String> bootId = const Value.absent(),
                Value<DateTime?> anchorServerTime = const Value.absent(),
                Value<BigInt?> anchorMonotonicMs = const Value.absent(),
                Value<String?> anchorBootId = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<bool> mockLocationDetected = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingAttendanceTableCompanion(
                clientUuid: clientUuid,
                type: type,
                wallClock: wallClock,
                monotonicMs: monotonicMs,
                bootId: bootId,
                anchorServerTime: anchorServerTime,
                anchorMonotonicMs: anchorMonotonicMs,
                anchorBootId: anchorBootId,
                latitude: latitude,
                longitude: longitude,
                accuracyM: accuracyM,
                area: area,
                customerId: customerId,
                mockLocationDetected: mockLocationDetected,
                status: status,
                reason: reason,
                createdAt: createdAt,
                retryCount: retryCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clientUuid,
                required String type,
                required DateTime wallClock,
                required BigInt monotonicMs,
                required String bootId,
                Value<DateTime?> anchorServerTime = const Value.absent(),
                Value<BigInt?> anchorMonotonicMs = const Value.absent(),
                Value<String?> anchorBootId = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> accuracyM = const Value.absent(),
                Value<String?> area = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<bool> mockLocationDetected = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                required DateTime createdAt,
                Value<int> retryCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PendingAttendanceTableCompanion.insert(
                clientUuid: clientUuid,
                type: type,
                wallClock: wallClock,
                monotonicMs: monotonicMs,
                bootId: bootId,
                anchorServerTime: anchorServerTime,
                anchorMonotonicMs: anchorMonotonicMs,
                anchorBootId: anchorBootId,
                latitude: latitude,
                longitude: longitude,
                accuracyM: accuracyM,
                area: area,
                customerId: customerId,
                mockLocationDetected: mockLocationDetected,
                status: status,
                reason: reason,
                createdAt: createdAt,
                retryCount: retryCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PendingAttendanceTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PendingAttendanceTableTable,
      PendingAttendanceTableData,
      $$PendingAttendanceTableTableFilterComposer,
      $$PendingAttendanceTableTableOrderingComposer,
      $$PendingAttendanceTableTableAnnotationComposer,
      $$PendingAttendanceTableTableCreateCompanionBuilder,
      $$PendingAttendanceTableTableUpdateCompanionBuilder,
      (
        PendingAttendanceTableData,
        BaseReferences<
          _$AppDatabase,
          $PendingAttendanceTableTable,
          PendingAttendanceTableData
        >,
      ),
      PendingAttendanceTableData,
      PrefetchHooks Function()
    >;
typedef $$TimeAnchorsTableCreateCompanionBuilder =
    TimeAnchorsCompanion Function({
      Value<int> id,
      required DateTime serverTime,
      required BigInt monotonicMs,
      required String bootId,
      required DateTime recordedAt,
    });
typedef $$TimeAnchorsTableUpdateCompanionBuilder =
    TimeAnchorsCompanion Function({
      Value<int> id,
      Value<DateTime> serverTime,
      Value<BigInt> monotonicMs,
      Value<String> bootId,
      Value<DateTime> recordedAt,
    });

class $$TimeAnchorsTableFilterComposer
    extends Composer<_$AppDatabase, $TimeAnchorsTable> {
  $$TimeAnchorsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get serverTime => $composableBuilder(
    column: $table.serverTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bootId => $composableBuilder(
    column: $table.bootId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$TimeAnchorsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeAnchorsTable> {
  $$TimeAnchorsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get serverTime => $composableBuilder(
    column: $table.serverTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bootId => $composableBuilder(
    column: $table.bootId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TimeAnchorsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeAnchorsTable> {
  $$TimeAnchorsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get serverTime => $composableBuilder(
    column: $table.serverTime,
    builder: (column) => column,
  );

  GeneratedColumn<BigInt> get monotonicMs => $composableBuilder(
    column: $table.monotonicMs,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bootId =>
      $composableBuilder(column: $table.bootId, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );
}

class $$TimeAnchorsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TimeAnchorsTable,
          TimeAnchor,
          $$TimeAnchorsTableFilterComposer,
          $$TimeAnchorsTableOrderingComposer,
          $$TimeAnchorsTableAnnotationComposer,
          $$TimeAnchorsTableCreateCompanionBuilder,
          $$TimeAnchorsTableUpdateCompanionBuilder,
          (
            TimeAnchor,
            BaseReferences<_$AppDatabase, $TimeAnchorsTable, TimeAnchor>,
          ),
          TimeAnchor,
          PrefetchHooks Function()
        > {
  $$TimeAnchorsTableTableManager(_$AppDatabase db, $TimeAnchorsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeAnchorsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeAnchorsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeAnchorsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> serverTime = const Value.absent(),
                Value<BigInt> monotonicMs = const Value.absent(),
                Value<String> bootId = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
              }) => TimeAnchorsCompanion(
                id: id,
                serverTime: serverTime,
                monotonicMs: monotonicMs,
                bootId: bootId,
                recordedAt: recordedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime serverTime,
                required BigInt monotonicMs,
                required String bootId,
                required DateTime recordedAt,
              }) => TimeAnchorsCompanion.insert(
                id: id,
                serverTime: serverTime,
                monotonicMs: monotonicMs,
                bootId: bootId,
                recordedAt: recordedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TimeAnchorsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TimeAnchorsTable,
      TimeAnchor,
      $$TimeAnchorsTableFilterComposer,
      $$TimeAnchorsTableOrderingComposer,
      $$TimeAnchorsTableAnnotationComposer,
      $$TimeAnchorsTableCreateCompanionBuilder,
      $$TimeAnchorsTableUpdateCompanionBuilder,
      (
        TimeAnchor,
        BaseReferences<_$AppDatabase, $TimeAnchorsTable, TimeAnchor>,
      ),
      TimeAnchor,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CacheEntriesTableTableManager get cacheEntries =>
      $$CacheEntriesTableTableManager(_db, _db.cacheEntries);
  $$PendingAttendanceTableTableTableManager get pendingAttendanceTable =>
      $$PendingAttendanceTableTableTableManager(
        _db,
        _db.pendingAttendanceTable,
      );
  $$TimeAnchorsTableTableManager get timeAnchors =>
      $$TimeAnchorsTableTableManager(_db, _db.timeAnchors);
}
