// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contractor_worker_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContractorWorkerModel _$ContractorWorkerModelFromJson(
  Map<String, dynamic> json,
) {
  return _ContractorWorkerModel.fromJson(json);
}

/// @nodoc
mixin _$ContractorWorkerModel {
  String get id => throw _privateConstructorUsedError;
  String get fullName => throw _privateConstructorUsedError;
  String get workerCode => throw _privateConstructorUsedError;
  String get nationalId => throw _privateConstructorUsedError;
  String get phone => throw _privateConstructorUsedError;
  String get jobTitle => throw _privateConstructorUsedError;
  String get projectName => throw _privateConstructorUsedError;
  String get siteName => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get startDate => throw _privateConstructorUsedError;
  String? get photoUrl => throw _privateConstructorUsedError;
  String? get lastCheckIn => throw _privateConstructorUsedError;
  String? get contractorId => throw _privateConstructorUsedError;
  String? get contractorName => throw _privateConstructorUsedError;
  String? get deviceUuid => throw _privateConstructorUsedError;

  /// Serializes this ContractorWorkerModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContractorWorkerModelCopyWith<ContractorWorkerModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContractorWorkerModelCopyWith<$Res> {
  factory $ContractorWorkerModelCopyWith(
    ContractorWorkerModel value,
    $Res Function(ContractorWorkerModel) then,
  ) = _$ContractorWorkerModelCopyWithImpl<$Res, ContractorWorkerModel>;
  @useResult
  $Res call({
    String id,
    String fullName,
    String workerCode,
    String nationalId,
    String phone,
    String jobTitle,
    String projectName,
    String siteName,
    String status,
    String startDate,
    String? photoUrl,
    String? lastCheckIn,
    String? contractorId,
    String? contractorName,
    String? deviceUuid,
  });
}

/// @nodoc
class _$ContractorWorkerModelCopyWithImpl<
  $Res,
  $Val extends ContractorWorkerModel
>
    implements $ContractorWorkerModelCopyWith<$Res> {
  _$ContractorWorkerModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? workerCode = null,
    Object? nationalId = null,
    Object? phone = null,
    Object? jobTitle = null,
    Object? projectName = null,
    Object? siteName = null,
    Object? status = null,
    Object? startDate = null,
    Object? photoUrl = freezed,
    Object? lastCheckIn = freezed,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? deviceUuid = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fullName: null == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String,
            workerCode: null == workerCode
                ? _value.workerCode
                : workerCode // ignore: cast_nullable_to_non_nullable
                      as String,
            nationalId: null == nationalId
                ? _value.nationalId
                : nationalId // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            jobTitle: null == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String,
            projectName: null == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String,
            siteName: null == siteName
                ? _value.siteName
                : siteName // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            photoUrl: freezed == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastCheckIn: freezed == lastCheckIn
                ? _value.lastCheckIn
                : lastCheckIn // ignore: cast_nullable_to_non_nullable
                      as String?,
            contractorId: freezed == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            contractorName: freezed == contractorName
                ? _value.contractorName
                : contractorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            deviceUuid: freezed == deviceUuid
                ? _value.deviceUuid
                : deviceUuid // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContractorWorkerModelImplCopyWith<$Res>
    implements $ContractorWorkerModelCopyWith<$Res> {
  factory _$$ContractorWorkerModelImplCopyWith(
    _$ContractorWorkerModelImpl value,
    $Res Function(_$ContractorWorkerModelImpl) then,
  ) = __$$ContractorWorkerModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fullName,
    String workerCode,
    String nationalId,
    String phone,
    String jobTitle,
    String projectName,
    String siteName,
    String status,
    String startDate,
    String? photoUrl,
    String? lastCheckIn,
    String? contractorId,
    String? contractorName,
    String? deviceUuid,
  });
}

/// @nodoc
class __$$ContractorWorkerModelImplCopyWithImpl<$Res>
    extends
        _$ContractorWorkerModelCopyWithImpl<$Res, _$ContractorWorkerModelImpl>
    implements _$$ContractorWorkerModelImplCopyWith<$Res> {
  __$$ContractorWorkerModelImplCopyWithImpl(
    _$ContractorWorkerModelImpl _value,
    $Res Function(_$ContractorWorkerModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fullName = null,
    Object? workerCode = null,
    Object? nationalId = null,
    Object? phone = null,
    Object? jobTitle = null,
    Object? projectName = null,
    Object? siteName = null,
    Object? status = null,
    Object? startDate = null,
    Object? photoUrl = freezed,
    Object? lastCheckIn = freezed,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? deviceUuid = freezed,
  }) {
    return _then(
      _$ContractorWorkerModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fullName: null == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String,
        workerCode: null == workerCode
            ? _value.workerCode
            : workerCode // ignore: cast_nullable_to_non_nullable
                  as String,
        nationalId: null == nationalId
            ? _value.nationalId
            : nationalId // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        jobTitle: null == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String,
        projectName: null == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String,
        siteName: null == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: freezed == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastCheckIn: freezed == lastCheckIn
            ? _value.lastCheckIn
            : lastCheckIn // ignore: cast_nullable_to_non_nullable
                  as String?,
        contractorId: freezed == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        contractorName: freezed == contractorName
            ? _value.contractorName
            : contractorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        deviceUuid: freezed == deviceUuid
            ? _value.deviceUuid
            : deviceUuid // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractorWorkerModelImpl implements _ContractorWorkerModel {
  const _$ContractorWorkerModelImpl({
    required this.id,
    required this.fullName,
    required this.workerCode,
    required this.nationalId,
    required this.phone,
    required this.jobTitle,
    required this.projectName,
    required this.siteName,
    this.status = 'active',
    this.startDate = '',
    this.photoUrl,
    this.lastCheckIn,
    this.contractorId,
    this.contractorName,
    this.deviceUuid,
  });

  factory _$ContractorWorkerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractorWorkerModelImplFromJson(json);

  @override
  final String id;
  @override
  final String fullName;
  @override
  final String workerCode;
  @override
  final String nationalId;
  @override
  final String phone;
  @override
  final String jobTitle;
  @override
  final String projectName;
  @override
  final String siteName;
  @override
  @JsonKey()
  final String status;
  @override
  @JsonKey()
  final String startDate;
  @override
  final String? photoUrl;
  @override
  final String? lastCheckIn;
  @override
  final String? contractorId;
  @override
  final String? contractorName;
  @override
  final String? deviceUuid;

  @override
  String toString() {
    return 'ContractorWorkerModel(id: $id, fullName: $fullName, workerCode: $workerCode, nationalId: $nationalId, phone: $phone, jobTitle: $jobTitle, projectName: $projectName, siteName: $siteName, status: $status, startDate: $startDate, photoUrl: $photoUrl, lastCheckIn: $lastCheckIn, contractorId: $contractorId, contractorName: $contractorName, deviceUuid: $deviceUuid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractorWorkerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.workerCode, workerCode) ||
                other.workerCode == workerCode) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.lastCheckIn, lastCheckIn) ||
                other.lastCheckIn == lastCheckIn) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.contractorName, contractorName) ||
                other.contractorName == contractorName) &&
            (identical(other.deviceUuid, deviceUuid) ||
                other.deviceUuid == deviceUuid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fullName,
    workerCode,
    nationalId,
    phone,
    jobTitle,
    projectName,
    siteName,
    status,
    startDate,
    photoUrl,
    lastCheckIn,
    contractorId,
    contractorName,
    deviceUuid,
  );

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContractorWorkerModelImplCopyWith<_$ContractorWorkerModelImpl>
  get copyWith =>
      __$$ContractorWorkerModelImplCopyWithImpl<_$ContractorWorkerModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractorWorkerModelImplToJson(this);
  }
}

abstract class _ContractorWorkerModel implements ContractorWorkerModel {
  const factory _ContractorWorkerModel({
    required final String id,
    required final String fullName,
    required final String workerCode,
    required final String nationalId,
    required final String phone,
    required final String jobTitle,
    required final String projectName,
    required final String siteName,
    final String status,
    final String startDate,
    final String? photoUrl,
    final String? lastCheckIn,
    final String? contractorId,
    final String? contractorName,
    final String? deviceUuid,
  }) = _$ContractorWorkerModelImpl;

  factory _ContractorWorkerModel.fromJson(Map<String, dynamic> json) =
      _$ContractorWorkerModelImpl.fromJson;

  @override
  String get id;
  @override
  String get fullName;
  @override
  String get workerCode;
  @override
  String get nationalId;
  @override
  String get phone;
  @override
  String get jobTitle;
  @override
  String get projectName;
  @override
  String get siteName;
  @override
  String get status;
  @override
  String get startDate;
  @override
  String? get photoUrl;
  @override
  String? get lastCheckIn;
  @override
  String? get contractorId;
  @override
  String? get contractorName;
  @override
  String? get deviceUuid;

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractorWorkerModelImplCopyWith<_$ContractorWorkerModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
