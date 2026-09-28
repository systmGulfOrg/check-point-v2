// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offline_attendance_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OfflineAttendanceLogModel _$OfflineAttendanceLogModelFromJson(
  Map<String, dynamic> json,
) {
  return _OfflineAttendanceLogModel.fromJson(json);
}

/// @nodoc
mixin _$OfflineAttendanceLogModel {
  String get localId => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get punchType => throw _privateConstructorUsedError;
  String get timestamp => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  String get siteId => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  String? get contractorId => throw _privateConstructorUsedError;
  String? get deviceUuid => throw _privateConstructorUsedError;
  bool get isInsideGeofence => throw _privateConstructorUsedError;
  bool get isSynced => throw _privateConstructorUsedError;
  String? get syncError => throw _privateConstructorUsedError;

  /// Serializes this OfflineAttendanceLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OfflineAttendanceLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfflineAttendanceLogModelCopyWith<OfflineAttendanceLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfflineAttendanceLogModelCopyWith<$Res> {
  factory $OfflineAttendanceLogModelCopyWith(
    OfflineAttendanceLogModel value,
    $Res Function(OfflineAttendanceLogModel) then,
  ) = _$OfflineAttendanceLogModelCopyWithImpl<$Res, OfflineAttendanceLogModel>;
  @useResult
  $Res call({
    String localId,
    String workerId,
    String punchType,
    String timestamp,
    double latitude,
    double longitude,
    String siteId,
    String? projectId,
    String? contractorId,
    String? deviceUuid,
    bool isInsideGeofence,
    bool isSynced,
    String? syncError,
  });
}

/// @nodoc
class _$OfflineAttendanceLogModelCopyWithImpl<
  $Res,
  $Val extends OfflineAttendanceLogModel
>
    implements $OfflineAttendanceLogModelCopyWith<$Res> {
  _$OfflineAttendanceLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OfflineAttendanceLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? workerId = null,
    Object? punchType = null,
    Object? timestamp = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? siteId = null,
    Object? projectId = freezed,
    Object? contractorId = freezed,
    Object? deviceUuid = freezed,
    Object? isInsideGeofence = null,
    Object? isSynced = null,
    Object? syncError = freezed,
  }) {
    return _then(
      _value.copyWith(
            localId: null == localId
                ? _value.localId
                : localId // ignore: cast_nullable_to_non_nullable
                      as String,
            workerId: null == workerId
                ? _value.workerId
                : workerId // ignore: cast_nullable_to_non_nullable
                      as String,
            punchType: null == punchType
                ? _value.punchType
                : punchType // ignore: cast_nullable_to_non_nullable
                      as String,
            timestamp: null == timestamp
                ? _value.timestamp
                : timestamp // ignore: cast_nullable_to_non_nullable
                      as String,
            latitude: null == latitude
                ? _value.latitude
                : latitude // ignore: cast_nullable_to_non_nullable
                      as double,
            longitude: null == longitude
                ? _value.longitude
                : longitude // ignore: cast_nullable_to_non_nullable
                      as double,
            siteId: null == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            contractorId: freezed == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceUuid: freezed == deviceUuid
                ? _value.deviceUuid
                : deviceUuid // ignore: cast_nullable_to_non_nullable
                      as String?,
            isInsideGeofence: null == isInsideGeofence
                ? _value.isInsideGeofence
                : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                      as bool,
            isSynced: null == isSynced
                ? _value.isSynced
                : isSynced // ignore: cast_nullable_to_non_nullable
                      as bool,
            syncError: freezed == syncError
                ? _value.syncError
                : syncError // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OfflineAttendanceLogModelImplCopyWith<$Res>
    implements $OfflineAttendanceLogModelCopyWith<$Res> {
  factory _$$OfflineAttendanceLogModelImplCopyWith(
    _$OfflineAttendanceLogModelImpl value,
    $Res Function(_$OfflineAttendanceLogModelImpl) then,
  ) = __$$OfflineAttendanceLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String localId,
    String workerId,
    String punchType,
    String timestamp,
    double latitude,
    double longitude,
    String siteId,
    String? projectId,
    String? contractorId,
    String? deviceUuid,
    bool isInsideGeofence,
    bool isSynced,
    String? syncError,
  });
}

/// @nodoc
class __$$OfflineAttendanceLogModelImplCopyWithImpl<$Res>
    extends
        _$OfflineAttendanceLogModelCopyWithImpl<
          $Res,
          _$OfflineAttendanceLogModelImpl
        >
    implements _$$OfflineAttendanceLogModelImplCopyWith<$Res> {
  __$$OfflineAttendanceLogModelImplCopyWithImpl(
    _$OfflineAttendanceLogModelImpl _value,
    $Res Function(_$OfflineAttendanceLogModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OfflineAttendanceLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? localId = null,
    Object? workerId = null,
    Object? punchType = null,
    Object? timestamp = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? siteId = null,
    Object? projectId = freezed,
    Object? contractorId = freezed,
    Object? deviceUuid = freezed,
    Object? isInsideGeofence = null,
    Object? isSynced = null,
    Object? syncError = freezed,
  }) {
    return _then(
      _$OfflineAttendanceLogModelImpl(
        localId: null == localId
            ? _value.localId
            : localId // ignore: cast_nullable_to_non_nullable
                  as String,
        workerId: null == workerId
            ? _value.workerId
            : workerId // ignore: cast_nullable_to_non_nullable
                  as String,
        punchType: null == punchType
            ? _value.punchType
            : punchType // ignore: cast_nullable_to_non_nullable
                  as String,
        timestamp: null == timestamp
            ? _value.timestamp
            : timestamp // ignore: cast_nullable_to_non_nullable
                  as String,
        latitude: null == latitude
            ? _value.latitude
            : latitude // ignore: cast_nullable_to_non_nullable
                  as double,
        longitude: null == longitude
            ? _value.longitude
            : longitude // ignore: cast_nullable_to_non_nullable
                  as double,
        siteId: null == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        contractorId: freezed == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceUuid: freezed == deviceUuid
            ? _value.deviceUuid
            : deviceUuid // ignore: cast_nullable_to_non_nullable
                  as String?,
        isInsideGeofence: null == isInsideGeofence
            ? _value.isInsideGeofence
            : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                  as bool,
        isSynced: null == isSynced
            ? _value.isSynced
            : isSynced // ignore: cast_nullable_to_non_nullable
                  as bool,
        syncError: freezed == syncError
            ? _value.syncError
            : syncError // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OfflineAttendanceLogModelImpl implements _OfflineAttendanceLogModel {
  const _$OfflineAttendanceLogModelImpl({
    required this.localId,
    required this.workerId,
    required this.punchType,
    required this.timestamp,
    required this.latitude,
    required this.longitude,
    required this.siteId,
    this.projectId,
    this.contractorId,
    this.deviceUuid,
    this.isInsideGeofence = true,
    this.isSynced = false,
    this.syncError,
  });

  factory _$OfflineAttendanceLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfflineAttendanceLogModelImplFromJson(json);

  @override
  final String localId;
  @override
  final String workerId;
  @override
  final String punchType;
  @override
  final String timestamp;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final String siteId;
  @override
  final String? projectId;
  @override
  final String? contractorId;
  @override
  final String? deviceUuid;
  @override
  @JsonKey()
  final bool isInsideGeofence;
  @override
  @JsonKey()
  final bool isSynced;
  @override
  final String? syncError;

  @override
  String toString() {
    return 'OfflineAttendanceLogModel(localId: $localId, workerId: $workerId, punchType: $punchType, timestamp: $timestamp, latitude: $latitude, longitude: $longitude, siteId: $siteId, projectId: $projectId, contractorId: $contractorId, deviceUuid: $deviceUuid, isInsideGeofence: $isInsideGeofence, isSynced: $isSynced, syncError: $syncError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfflineAttendanceLogModelImpl &&
            (identical(other.localId, localId) || other.localId == localId) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.punchType, punchType) ||
                other.punchType == punchType) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.deviceUuid, deviceUuid) ||
                other.deviceUuid == deviceUuid) &&
            (identical(other.isInsideGeofence, isInsideGeofence) ||
                other.isInsideGeofence == isInsideGeofence) &&
            (identical(other.isSynced, isSynced) ||
                other.isSynced == isSynced) &&
            (identical(other.syncError, syncError) ||
                other.syncError == syncError));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    localId,
    workerId,
    punchType,
    timestamp,
    latitude,
    longitude,
    siteId,
    projectId,
    contractorId,
    deviceUuid,
    isInsideGeofence,
    isSynced,
    syncError,
  );

  /// Create a copy of OfflineAttendanceLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfflineAttendanceLogModelImplCopyWith<_$OfflineAttendanceLogModelImpl>
  get copyWith =>
      __$$OfflineAttendanceLogModelImplCopyWithImpl<
        _$OfflineAttendanceLogModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfflineAttendanceLogModelImplToJson(this);
  }
}

abstract class _OfflineAttendanceLogModel implements OfflineAttendanceLogModel {
  const factory _OfflineAttendanceLogModel({
    required final String localId,
    required final String workerId,
    required final String punchType,
    required final String timestamp,
    required final double latitude,
    required final double longitude,
    required final String siteId,
    final String? projectId,
    final String? contractorId,
    final String? deviceUuid,
    final bool isInsideGeofence,
    final bool isSynced,
    final String? syncError,
  }) = _$OfflineAttendanceLogModelImpl;

  factory _OfflineAttendanceLogModel.fromJson(Map<String, dynamic> json) =
      _$OfflineAttendanceLogModelImpl.fromJson;

  @override
  String get localId;
  @override
  String get workerId;
  @override
  String get punchType;
  @override
  String get timestamp;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  String get siteId;
  @override
  String? get projectId;
  @override
  String? get contractorId;
  @override
  String? get deviceUuid;
  @override
  bool get isInsideGeofence;
  @override
  bool get isSynced;
  @override
  String? get syncError;

  /// Create a copy of OfflineAttendanceLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfflineAttendanceLogModelImplCopyWith<_$OfflineAttendanceLogModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
