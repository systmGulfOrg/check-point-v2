// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contractor_attendance_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContractorAttendanceModel _$ContractorAttendanceModelFromJson(
  Map<String, dynamic> json,
) {
  return _ContractorAttendanceModel.fromJson(json);
}

/// @nodoc
mixin _$ContractorAttendanceModel {
  String get id => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get workerCode => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  String get siteName => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get checkInTime => throw _privateConstructorUsedError;
  String? get checkOutTime => throw _privateConstructorUsedError;
  String? get workedHours => throw _privateConstructorUsedError;
  bool get isInsideGeofence => throw _privateConstructorUsedError;
  bool get isOfflineSynced => throw _privateConstructorUsedError;
  String? get contractorId => throw _privateConstructorUsedError;
  String? get deviceUuid => throw _privateConstructorUsedError;
  String? get siteId => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;

  /// Serializes this ContractorAttendanceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContractorAttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContractorAttendanceModelCopyWith<ContractorAttendanceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractorAttendanceModelCopyWith<$Res> {
  factory $ContractorAttendanceModelCopyWith(
    ContractorAttendanceModel value,
    $Res Function(ContractorAttendanceModel) then,
  ) = _$ContractorAttendanceModelCopyWithImpl<$Res, ContractorAttendanceModel>;
  @useResult
  $Res call({
    String id,
    String workerId,
    String workerName,
    String workerCode,
    String jobTitle,
    String siteName,
    String projectName,
    String date,
    String status,
    String? checkInTime,
    String? checkOutTime,
    String? workedHours,
    bool isInsideGeofence,
    bool isOfflineSynced,
    String? contractorId,
    String? deviceUuid,
    String? siteId,
    String? projectId,
  });
}

/// @nodoc
class _$ContractorAttendanceModelCopyWithImpl<
  $Res,
  $Val extends ContractorAttendanceModel
>
    implements $ContractorAttendanceModelCopyWith<$Res> {
  _$ContractorAttendanceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContractorAttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? workerCode = null,
    Object? jobTitle = null,
    Object? siteName = null,
    Object? projectName = null,
    Object? date = null,
    Object? status = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? workedHours = freezed,
    Object? isInsideGeofence = null,
    Object? isOfflineSynced = null,
    Object? contractorId = freezed,
    Object? deviceUuid = freezed,
    Object? siteId = freezed,
    Object? projectId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            workerId: null == workerId
                ? _value.workerId
                : workerId // ignore: cast_nullable_to_non_nullable
                      as String,
            workerName: null == workerName
                ? _value.workerName
                : workerName // ignore: cast_nullable_to_non_nullable
                      as String,
            workerCode: null == workerCode
                ? _value.workerCode
                : workerCode // ignore: cast_nullable_to_non_nullable
                      as String,
            jobTitle: null == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            siteName: null == siteName
                ? _value.siteName
                : siteName // ignore: cast_nullable_to_non_nullable
                      as String,
            projectName: null == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            checkInTime: freezed == checkInTime
                ? _value.checkInTime
                : checkInTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            checkOutTime: freezed == checkOutTime
                ? _value.checkOutTime
                : checkOutTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            workedHours: freezed == workedHours
                ? _value.workedHours
                : workedHours // ignore: cast_nullable_to_non_nullable
                      as String?,
            isInsideGeofence: null == isInsideGeofence
                ? _value.isInsideGeofence
                : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                      as bool,
            isOfflineSynced: null == isOfflineSynced
                ? _value.isOfflineSynced
                : isOfflineSynced // ignore: cast_nullable_to_non_nullable
                      as bool,
            contractorId: freezed == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceUuid: freezed == deviceUuid
                ? _value.deviceUuid
                : deviceUuid // ignore: cast_nullable_to_non_nullable
                      as String?,
            siteId: freezed == siteId
                ? _value.siteId
                : siteId // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContractorAttendanceModelImplCopyWith<$Res>
    implements $ContractorAttendanceModelCopyWith<$Res> {
  factory _$$ContractorAttendanceModelImplCopyWith(
    _$ContractorAttendanceModelImpl value,
    $Res Function(_$ContractorAttendanceModelImpl) then,
  ) = __$$ContractorAttendanceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String workerId,
    String workerName,
    String workerCode,
    String jobTitle,
    String siteName,
    String projectName,
    String date,
    String status,
    String? checkInTime,
    String? checkOutTime,
    String? workedHours,
    bool isInsideGeofence,
    bool isOfflineSynced,
    String? contractorId,
    String? deviceUuid,
    String? siteId,
    String? projectId,
  });
}

/// @nodoc
class __$$ContractorAttendanceModelImplCopyWithImpl<$Res>
    extends
        _$ContractorAttendanceModelCopyWithImpl<
          $Res,
          _$ContractorAttendanceModelImpl
        >
    implements _$$ContractorAttendanceModelImplCopyWith<$Res> {
  __$$ContractorAttendanceModelImplCopyWithImpl(
    _$ContractorAttendanceModelImpl _value,
    $Res Function(_$ContractorAttendanceModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContractorAttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? workerCode = null,
    Object? jobTitle = null,
    Object? siteName = null,
    Object? projectName = null,
    Object? date = null,
    Object? status = null,
    Object? checkInTime = freezed,
    Object? checkOutTime = freezed,
    Object? workedHours = freezed,
    Object? isInsideGeofence = null,
    Object? isOfflineSynced = null,
    Object? contractorId = freezed,
    Object? deviceUuid = freezed,
    Object? siteId = freezed,
    Object? projectId = freezed,
  }) {
    return _then(
      _$ContractorAttendanceModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        workerId: null == workerId
            ? _value.workerId
            : workerId // ignore: cast_nullable_to_non_nullable
                  as String,
        workerName: null == workerName
            ? _value.workerName
            : workerName // ignore: cast_nullable_to_non_nullable
                  as String,
        workerCode: null == workerCode
            ? _value.workerCode
            : workerCode // ignore: cast_nullable_to_non_nullable
                  as String,
        jobTitle: null == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        siteName: null == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String,
        projectName: null == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        checkInTime: freezed == checkInTime
            ? _value.checkInTime
            : checkInTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        checkOutTime: freezed == checkOutTime
            ? _value.checkOutTime
            : checkOutTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        workedHours: freezed == workedHours
            ? _value.workedHours
            : workedHours // ignore: cast_nullable_to_non_nullable
                  as String?,
        isInsideGeofence: null == isInsideGeofence
            ? _value.isInsideGeofence
            : isInsideGeofence // ignore: cast_nullable_to_non_nullable
                  as bool,
        isOfflineSynced: null == isOfflineSynced
            ? _value.isOfflineSynced
            : isOfflineSynced // ignore: cast_nullable_to_non_nullable
                  as bool,
        contractorId: freezed == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceUuid: freezed == deviceUuid
            ? _value.deviceUuid
            : deviceUuid // ignore: cast_nullable_to_non_nullable
                  as String?,
        siteId: freezed == siteId
            ? _value.siteId
            : siteId // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractorAttendanceModelImpl implements _ContractorAttendanceModel {
  const _$ContractorAttendanceModelImpl({
    required this.id,
    required this.workerId,
    required this.workerName,
    required this.workerCode,
    required this.jobTitle,
    required this.siteName,
    required this.projectName,
    required this.date,
    required this.status,
    this.checkInTime,
    this.checkOutTime,
    this.workedHours,
    this.isInsideGeofence = true,
    this.isOfflineSynced = false,
    this.contractorId,
    this.deviceUuid,
    this.siteId,
    this.projectId,
  });

  factory _$ContractorAttendanceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractorAttendanceModelImplFromJson(json);

  @override
  final String id;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String workerCode;
  @override
  final String jobTitle;
  @override
  final String siteName;
  @override
  final String projectName;
  @override
  final String date;
  @override
  final String status;
  @override
  final String? checkInTime;
  @override
  final String? checkOutTime;
  @override
  final String? workedHours;
  @override
  @JsonKey()
  final bool isInsideGeofence;
  @override
  @JsonKey()
  final bool isOfflineSynced;
  @override
  final String? contractorId;
  @override
  final String? deviceUuid;
  @override
  final String? siteId;
  @override
  final String? projectId;

  @override
  String toString() {
    return 'ContractorAttendanceModel(id: $id, workerId: $workerId, workerName: $workerName, workerCode: $workerCode, jobTitle: $jobTitle, siteName: $siteName, projectName: $projectName, date: $date, status: $status, checkInTime: $checkInTime, checkOutTime: $checkOutTime, workedHours: $workedHours, isInsideGeofence: $isInsideGeofence, isOfflineSynced: $isOfflineSynced, contractorId: $contractorId, deviceUuid: $deviceUuid, siteId: $siteId, projectId: $projectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractorAttendanceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.workerCode, workerCode) ||
                other.workerCode == workerCode) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.checkInTime, checkInTime) ||
                other.checkInTime == checkInTime) &&
            (identical(other.checkOutTime, checkOutTime) ||
                other.checkOutTime == checkOutTime) &&
            (identical(other.workedHours, workedHours) ||
                other.workedHours == workedHours) &&
            (identical(other.isInsideGeofence, isInsideGeofence) ||
                other.isInsideGeofence == isInsideGeofence) &&
            (identical(other.isOfflineSynced, isOfflineSynced) ||
                other.isOfflineSynced == isOfflineSynced) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.deviceUuid, deviceUuid) ||
                other.deviceUuid == deviceUuid) &&
            (identical(other.siteId, siteId) || other.siteId == siteId) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    workerId,
    workerName,
    workerCode,
    jobTitle,
    siteName,
    projectName,
    date,
    status,
    checkInTime,
    checkOutTime,
    workedHours,
    isInsideGeofence,
    isOfflineSynced,
    contractorId,
    deviceUuid,
    siteId,
    projectId,
  );

  /// Create a copy of ContractorAttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractorAttendanceModelImplCopyWith<_$ContractorAttendanceModelImpl>
  get copyWith =>
      __$$ContractorAttendanceModelImplCopyWithImpl<
        _$ContractorAttendanceModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractorAttendanceModelImplToJson(this);
  }
}

abstract class _ContractorAttendanceModel implements ContractorAttendanceModel {
  const factory _ContractorAttendanceModel({
    required final String id,
    required final String workerId,
    required final String workerName,
    required final String workerCode,
    required final String jobTitle,
    required final String siteName,
    required final String projectName,
    required final String date,
    required final String status,
    final String? checkInTime,
    final String? checkOutTime,
    final String? workedHours,
    final bool isInsideGeofence,
    final bool isOfflineSynced,
    final String? contractorId,
    final String? deviceUuid,
    final String? siteId,
    final String? projectId,
  }) = _$ContractorAttendanceModelImpl;

  factory _ContractorAttendanceModel.fromJson(Map<String, dynamic> json) =
      _$ContractorAttendanceModelImpl.fromJson;

  @override
  String get id;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get workerCode;
  @override
  String get jobTitle;
  @override
  String get siteName;
  @override
  String get projectName;
  @override
  String get date;
  @override
  String get status;
  @override
  String? get checkInTime;
  @override
  String? get checkOutTime;
  @override
  String? get workedHours;
  @override
  bool get isInsideGeofence;
  @override
  bool get isOfflineSynced;
  @override
  String? get contractorId;
  @override
  String? get deviceUuid;
  @override
  String? get siteId;
  @override
  String? get projectId;

  /// Create a copy of ContractorAttendanceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractorAttendanceModelImplCopyWith<_$ContractorAttendanceModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
