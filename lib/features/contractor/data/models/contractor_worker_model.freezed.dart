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
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'fullName')
  String? get fullName => throw _privateConstructorUsedError;
  @JsonKey(name: 'employeeCode')
  String? get employeeCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'workerCode')
  String? get workerCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'nationalId')
  String get nationalId => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone')
  String get phone => throw _privateConstructorUsedError;
  @JsonKey(name: 'position')
  String? get position => throw _privateConstructorUsedError;
  @JsonKey(name: 'jobTitle')
  String? get jobTitle => throw _privateConstructorUsedError;
  @JsonKey(name: 'projectName')
  String? get projectName => throw _privateConstructorUsedError;
  @JsonKey(name: 'siteName')
  String? get siteName => throw _privateConstructorUsedError;
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'startDate')
  String get startDate => throw _privateConstructorUsedError;
  @JsonKey(name: 'imageUrl')
  String? get imageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'photoUrl')
  String? get photoUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'lastCheckIn')
  String? get lastCheckIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'contractorId')
  String? get contractorId => throw _privateConstructorUsedError;
  @JsonKey(name: 'contractorName')
  String? get contractorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'deviceUuid')
  String? get deviceUuid => throw _privateConstructorUsedError;
  @JsonKey(name: 'contractor')
  ContractorCompanyModel? get contractor => throw _privateConstructorUsedError;
  @JsonKey(name: 'nationalIdDetails')
  NationalIdDetailsModel? get nationalIdDetails =>
      throw _privateConstructorUsedError;

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
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'fullName') String? fullName,
    @JsonKey(name: 'employeeCode') String? employeeCode,
    @JsonKey(name: 'workerCode') String? workerCode,
    @JsonKey(name: 'nationalId') String nationalId,
    @JsonKey(name: 'phone') String phone,
    @JsonKey(name: 'position') String? position,
    @JsonKey(name: 'jobTitle') String? jobTitle,
    @JsonKey(name: 'projectName') String? projectName,
    @JsonKey(name: 'siteName') String? siteName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startDate') String startDate,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'photoUrl') String? photoUrl,
    @JsonKey(name: 'lastCheckIn') String? lastCheckIn,
    @JsonKey(name: 'contractorId') String? contractorId,
    @JsonKey(name: 'contractorName') String? contractorName,
    @JsonKey(name: 'deviceUuid') String? deviceUuid,
    @JsonKey(name: 'contractor') ContractorCompanyModel? contractor,
    @JsonKey(name: 'nationalIdDetails')
    NationalIdDetailsModel? nationalIdDetails,
  });

  $ContractorCompanyModelCopyWith<$Res>? get contractor;
  $NationalIdDetailsModelCopyWith<$Res>? get nationalIdDetails;
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
    Object? name = freezed,
    Object? fullName = freezed,
    Object? employeeCode = freezed,
    Object? workerCode = freezed,
    Object? nationalId = null,
    Object? phone = null,
    Object? position = freezed,
    Object? jobTitle = freezed,
    Object? projectName = freezed,
    Object? siteName = freezed,
    Object? status = null,
    Object? startDate = null,
    Object? imageUrl = freezed,
    Object? photoUrl = freezed,
    Object? lastCheckIn = freezed,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? deviceUuid = freezed,
    Object? contractor = freezed,
    Object? nationalIdDetails = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            fullName: freezed == fullName
                ? _value.fullName
                : fullName // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeCode: freezed == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            workerCode: freezed == workerCode
                ? _value.workerCode
                : workerCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            nationalId: null == nationalId
                ? _value.nationalId
                : nationalId // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: null == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String?,
            jobTitle: freezed == jobTitle
                ? _value.jobTitle
                : jobTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectName: freezed == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String?,
            siteName: freezed == siteName
                ? _value.siteName
                : siteName // ignore: cast_nullable_to_non_nullable
                      as String?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
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
            contractor: freezed == contractor
                ? _value.contractor
                : contractor // ignore: cast_nullable_to_non_nullable
                      as ContractorCompanyModel?,
            nationalIdDetails: freezed == nationalIdDetails
                ? _value.nationalIdDetails
                : nationalIdDetails // ignore: cast_nullable_to_non_nullable
                      as NationalIdDetailsModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ContractorCompanyModelCopyWith<$Res>? get contractor {
    if (_value.contractor == null) {
      return null;
    }

    return $ContractorCompanyModelCopyWith<$Res>(_value.contractor!, (value) {
      return _then(_value.copyWith(contractor: value) as $Val);
    });
  }

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $NationalIdDetailsModelCopyWith<$Res>? get nationalIdDetails {
    if (_value.nationalIdDetails == null) {
      return null;
    }

    return $NationalIdDetailsModelCopyWith<$Res>(_value.nationalIdDetails!, (
      value,
    ) {
      return _then(_value.copyWith(nationalIdDetails: value) as $Val);
    });
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
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'fullName') String? fullName,
    @JsonKey(name: 'employeeCode') String? employeeCode,
    @JsonKey(name: 'workerCode') String? workerCode,
    @JsonKey(name: 'nationalId') String nationalId,
    @JsonKey(name: 'phone') String phone,
    @JsonKey(name: 'position') String? position,
    @JsonKey(name: 'jobTitle') String? jobTitle,
    @JsonKey(name: 'projectName') String? projectName,
    @JsonKey(name: 'siteName') String? siteName,
    @JsonKey(name: 'status') String status,
    @JsonKey(name: 'startDate') String startDate,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'photoUrl') String? photoUrl,
    @JsonKey(name: 'lastCheckIn') String? lastCheckIn,
    @JsonKey(name: 'contractorId') String? contractorId,
    @JsonKey(name: 'contractorName') String? contractorName,
    @JsonKey(name: 'deviceUuid') String? deviceUuid,
    @JsonKey(name: 'contractor') ContractorCompanyModel? contractor,
    @JsonKey(name: 'nationalIdDetails')
    NationalIdDetailsModel? nationalIdDetails,
  });

  @override
  $ContractorCompanyModelCopyWith<$Res>? get contractor;
  @override
  $NationalIdDetailsModelCopyWith<$Res>? get nationalIdDetails;
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
    Object? name = freezed,
    Object? fullName = freezed,
    Object? employeeCode = freezed,
    Object? workerCode = freezed,
    Object? nationalId = null,
    Object? phone = null,
    Object? position = freezed,
    Object? jobTitle = freezed,
    Object? projectName = freezed,
    Object? siteName = freezed,
    Object? status = null,
    Object? startDate = null,
    Object? imageUrl = freezed,
    Object? photoUrl = freezed,
    Object? lastCheckIn = freezed,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? deviceUuid = freezed,
    Object? contractor = freezed,
    Object? nationalIdDetails = freezed,
  }) {
    return _then(
      _$ContractorWorkerModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        fullName: freezed == fullName
            ? _value.fullName
            : fullName // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeCode: freezed == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        workerCode: freezed == workerCode
            ? _value.workerCode
            : workerCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        nationalId: null == nationalId
            ? _value.nationalId
            : nationalId // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: null == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String?,
        jobTitle: freezed == jobTitle
            ? _value.jobTitle
            : jobTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectName: freezed == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String?,
        siteName: freezed == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
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
        contractor: freezed == contractor
            ? _value.contractor
            : contractor // ignore: cast_nullable_to_non_nullable
                  as ContractorCompanyModel?,
        nationalIdDetails: freezed == nationalIdDetails
            ? _value.nationalIdDetails
            : nationalIdDetails // ignore: cast_nullable_to_non_nullable
                  as NationalIdDetailsModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContractorWorkerModelImpl extends _ContractorWorkerModel {
  const _$ContractorWorkerModelImpl({
    required this.id,
    @JsonKey(name: 'name') this.name,
    @JsonKey(name: 'fullName') this.fullName,
    @JsonKey(name: 'employeeCode') this.employeeCode,
    @JsonKey(name: 'workerCode') this.workerCode,
    @JsonKey(name: 'nationalId') this.nationalId = '',
    @JsonKey(name: 'phone') this.phone = '',
    @JsonKey(name: 'position') this.position,
    @JsonKey(name: 'jobTitle') this.jobTitle,
    @JsonKey(name: 'projectName') this.projectName,
    @JsonKey(name: 'siteName') this.siteName,
    @JsonKey(name: 'status') this.status = 'active',
    @JsonKey(name: 'startDate') this.startDate = '',
    @JsonKey(name: 'imageUrl') this.imageUrl,
    @JsonKey(name: 'photoUrl') this.photoUrl,
    @JsonKey(name: 'lastCheckIn') this.lastCheckIn,
    @JsonKey(name: 'contractorId') this.contractorId,
    @JsonKey(name: 'contractorName') this.contractorName,
    @JsonKey(name: 'deviceUuid') this.deviceUuid,
    @JsonKey(name: 'contractor') this.contractor,
    @JsonKey(name: 'nationalIdDetails') this.nationalIdDetails,
  }) : super._();

  factory _$ContractorWorkerModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContractorWorkerModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'fullName')
  final String? fullName;
  @override
  @JsonKey(name: 'employeeCode')
  final String? employeeCode;
  @override
  @JsonKey(name: 'workerCode')
  final String? workerCode;
  @override
  @JsonKey(name: 'nationalId')
  final String nationalId;
  @override
  @JsonKey(name: 'phone')
  final String phone;
  @override
  @JsonKey(name: 'position')
  final String? position;
  @override
  @JsonKey(name: 'jobTitle')
  final String? jobTitle;
  @override
  @JsonKey(name: 'projectName')
  final String? projectName;
  @override
  @JsonKey(name: 'siteName')
  final String? siteName;
  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'startDate')
  final String startDate;
  @override
  @JsonKey(name: 'imageUrl')
  final String? imageUrl;
  @override
  @JsonKey(name: 'photoUrl')
  final String? photoUrl;
  @override
  @JsonKey(name: 'lastCheckIn')
  final String? lastCheckIn;
  @override
  @JsonKey(name: 'contractorId')
  final String? contractorId;
  @override
  @JsonKey(name: 'contractorName')
  final String? contractorName;
  @override
  @JsonKey(name: 'deviceUuid')
  final String? deviceUuid;
  @override
  @JsonKey(name: 'contractor')
  final ContractorCompanyModel? contractor;
  @override
  @JsonKey(name: 'nationalIdDetails')
  final NationalIdDetailsModel? nationalIdDetails;

  @override
  String toString() {
    return 'ContractorWorkerModel(id: $id, name: $name, fullName: $fullName, employeeCode: $employeeCode, workerCode: $workerCode, nationalId: $nationalId, phone: $phone, position: $position, jobTitle: $jobTitle, projectName: $projectName, siteName: $siteName, status: $status, startDate: $startDate, imageUrl: $imageUrl, photoUrl: $photoUrl, lastCheckIn: $lastCheckIn, contractorId: $contractorId, contractorName: $contractorName, deviceUuid: $deviceUuid, contractor: $contractor, nationalIdDetails: $nationalIdDetails)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContractorWorkerModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fullName, fullName) ||
                other.fullName == fullName) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.workerCode, workerCode) ||
                other.workerCode == workerCode) &&
            (identical(other.nationalId, nationalId) ||
                other.nationalId == nationalId) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.jobTitle, jobTitle) ||
                other.jobTitle == jobTitle) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.lastCheckIn, lastCheckIn) ||
                other.lastCheckIn == lastCheckIn) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.contractorName, contractorName) ||
                other.contractorName == contractorName) &&
            (identical(other.deviceUuid, deviceUuid) ||
                other.deviceUuid == deviceUuid) &&
            (identical(other.contractor, contractor) ||
                other.contractor == contractor) &&
            (identical(other.nationalIdDetails, nationalIdDetails) ||
                other.nationalIdDetails == nationalIdDetails));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    name,
    fullName,
    employeeCode,
    workerCode,
    nationalId,
    phone,
    position,
    jobTitle,
    projectName,
    siteName,
    status,
    startDate,
    imageUrl,
    photoUrl,
    lastCheckIn,
    contractorId,
    contractorName,
    deviceUuid,
    contractor,
    nationalIdDetails,
  ]);

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

abstract class _ContractorWorkerModel extends ContractorWorkerModel {
  const factory _ContractorWorkerModel({
    required final String id,
    @JsonKey(name: 'name') final String? name,
    @JsonKey(name: 'fullName') final String? fullName,
    @JsonKey(name: 'employeeCode') final String? employeeCode,
    @JsonKey(name: 'workerCode') final String? workerCode,
    @JsonKey(name: 'nationalId') final String nationalId,
    @JsonKey(name: 'phone') final String phone,
    @JsonKey(name: 'position') final String? position,
    @JsonKey(name: 'jobTitle') final String? jobTitle,
    @JsonKey(name: 'projectName') final String? projectName,
    @JsonKey(name: 'siteName') final String? siteName,
    @JsonKey(name: 'status') final String status,
    @JsonKey(name: 'startDate') final String startDate,
    @JsonKey(name: 'imageUrl') final String? imageUrl,
    @JsonKey(name: 'photoUrl') final String? photoUrl,
    @JsonKey(name: 'lastCheckIn') final String? lastCheckIn,
    @JsonKey(name: 'contractorId') final String? contractorId,
    @JsonKey(name: 'contractorName') final String? contractorName,
    @JsonKey(name: 'deviceUuid') final String? deviceUuid,
    @JsonKey(name: 'contractor') final ContractorCompanyModel? contractor,
    @JsonKey(name: 'nationalIdDetails')
    final NationalIdDetailsModel? nationalIdDetails,
  }) = _$ContractorWorkerModelImpl;
  const _ContractorWorkerModel._() : super._();

  factory _ContractorWorkerModel.fromJson(Map<String, dynamic> json) =
      _$ContractorWorkerModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'fullName')
  String? get fullName;
  @override
  @JsonKey(name: 'employeeCode')
  String? get employeeCode;
  @override
  @JsonKey(name: 'workerCode')
  String? get workerCode;
  @override
  @JsonKey(name: 'nationalId')
  String get nationalId;
  @override
  @JsonKey(name: 'phone')
  String get phone;
  @override
  @JsonKey(name: 'position')
  String? get position;
  @override
  @JsonKey(name: 'jobTitle')
  String? get jobTitle;
  @override
  @JsonKey(name: 'projectName')
  String? get projectName;
  @override
  @JsonKey(name: 'siteName')
  String? get siteName;
  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'startDate')
  String get startDate;
  @override
  @JsonKey(name: 'imageUrl')
  String? get imageUrl;
  @override
  @JsonKey(name: 'photoUrl')
  String? get photoUrl;
  @override
  @JsonKey(name: 'lastCheckIn')
  String? get lastCheckIn;
  @override
  @JsonKey(name: 'contractorId')
  String? get contractorId;
  @override
  @JsonKey(name: 'contractorName')
  String? get contractorName;
  @override
  @JsonKey(name: 'deviceUuid')
  String? get deviceUuid;
  @override
  @JsonKey(name: 'contractor')
  ContractorCompanyModel? get contractor;
  @override
  @JsonKey(name: 'nationalIdDetails')
  NationalIdDetailsModel? get nationalIdDetails;

  /// Create a copy of ContractorWorkerModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContractorWorkerModelImplCopyWith<_$ContractorWorkerModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
