// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'worker_site_assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkerSiteAssignmentModel _$WorkerSiteAssignmentModelFromJson(
  Map<String, dynamic> json,
) {
  return _WorkerSiteAssignmentModel.fromJson(json);
}

/// @nodoc
mixin _$WorkerSiteAssignmentModel {
  String get id => throw _privateConstructorUsedError;
  String get workerId => throw _privateConstructorUsedError;
  String get workerName => throw _privateConstructorUsedError;
  String get branchId => throw _privateConstructorUsedError;
  String get siteName => throw _privateConstructorUsedError;
  String? get assignedById => throw _privateConstructorUsedError;
  String? get assignedByName => throw _privateConstructorUsedError;
  String? get validFrom => throw _privateConstructorUsedError;
  String? get validUntil => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  String? get contractorId => throw _privateConstructorUsedError;
  String? get contractorName => throw _privateConstructorUsedError;
  String? get projectId => throw _privateConstructorUsedError;
  String? get projectName => throw _privateConstructorUsedError;

  /// Serializes this WorkerSiteAssignmentModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkerSiteAssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkerSiteAssignmentModelCopyWith<WorkerSiteAssignmentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkerSiteAssignmentModelCopyWith<$Res> {
  factory $WorkerSiteAssignmentModelCopyWith(
    WorkerSiteAssignmentModel value,
    $Res Function(WorkerSiteAssignmentModel) then,
  ) = _$WorkerSiteAssignmentModelCopyWithImpl<$Res, WorkerSiteAssignmentModel>;
  @useResult
  $Res call({
    String id,
    String workerId,
    String workerName,
    String branchId,
    String siteName,
    String? assignedById,
    String? assignedByName,
    String? validFrom,
    String? validUntil,
    bool isActive,
    String? contractorId,
    String? contractorName,
    String? projectId,
    String? projectName,
  });
}

/// @nodoc
class _$WorkerSiteAssignmentModelCopyWithImpl<
  $Res,
  $Val extends WorkerSiteAssignmentModel
>
    implements $WorkerSiteAssignmentModelCopyWith<$Res> {
  _$WorkerSiteAssignmentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkerSiteAssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? branchId = null,
    Object? siteName = null,
    Object? assignedById = freezed,
    Object? assignedByName = freezed,
    Object? validFrom = freezed,
    Object? validUntil = freezed,
    Object? isActive = null,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? projectId = freezed,
    Object? projectName = freezed,
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
            branchId: null == branchId
                ? _value.branchId
                : branchId // ignore: cast_nullable_to_non_nullable
                      as String,
            siteName: null == siteName
                ? _value.siteName
                : siteName // ignore: cast_nullable_to_non_nullable
                      as String,
            assignedById: freezed == assignedById
                ? _value.assignedById
                : assignedById // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignedByName: freezed == assignedByName
                ? _value.assignedByName
                : assignedByName // ignore: cast_nullable_to_non_nullable
                      as String?,
            validFrom: freezed == validFrom
                ? _value.validFrom
                : validFrom // ignore: cast_nullable_to_non_nullable
                      as String?,
            validUntil: freezed == validUntil
                ? _value.validUntil
                : validUntil // ignore: cast_nullable_to_non_nullable
                      as String?,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            contractorId: freezed == contractorId
                ? _value.contractorId
                : contractorId // ignore: cast_nullable_to_non_nullable
                      as String?,
            contractorName: freezed == contractorName
                ? _value.contractorName
                : contractorName // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectId: freezed == projectId
                ? _value.projectId
                : projectId // ignore: cast_nullable_to_non_nullable
                      as String?,
            projectName: freezed == projectName
                ? _value.projectName
                : projectName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkerSiteAssignmentModelImplCopyWith<$Res>
    implements $WorkerSiteAssignmentModelCopyWith<$Res> {
  factory _$$WorkerSiteAssignmentModelImplCopyWith(
    _$WorkerSiteAssignmentModelImpl value,
    $Res Function(_$WorkerSiteAssignmentModelImpl) then,
  ) = __$$WorkerSiteAssignmentModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String workerId,
    String workerName,
    String branchId,
    String siteName,
    String? assignedById,
    String? assignedByName,
    String? validFrom,
    String? validUntil,
    bool isActive,
    String? contractorId,
    String? contractorName,
    String? projectId,
    String? projectName,
  });
}

/// @nodoc
class __$$WorkerSiteAssignmentModelImplCopyWithImpl<$Res>
    extends
        _$WorkerSiteAssignmentModelCopyWithImpl<
          $Res,
          _$WorkerSiteAssignmentModelImpl
        >
    implements _$$WorkerSiteAssignmentModelImplCopyWith<$Res> {
  __$$WorkerSiteAssignmentModelImplCopyWithImpl(
    _$WorkerSiteAssignmentModelImpl _value,
    $Res Function(_$WorkerSiteAssignmentModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkerSiteAssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? workerId = null,
    Object? workerName = null,
    Object? branchId = null,
    Object? siteName = null,
    Object? assignedById = freezed,
    Object? assignedByName = freezed,
    Object? validFrom = freezed,
    Object? validUntil = freezed,
    Object? isActive = null,
    Object? contractorId = freezed,
    Object? contractorName = freezed,
    Object? projectId = freezed,
    Object? projectName = freezed,
  }) {
    return _then(
      _$WorkerSiteAssignmentModelImpl(
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
        branchId: null == branchId
            ? _value.branchId
            : branchId // ignore: cast_nullable_to_non_nullable
                  as String,
        siteName: null == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String,
        assignedById: freezed == assignedById
            ? _value.assignedById
            : assignedById // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignedByName: freezed == assignedByName
            ? _value.assignedByName
            : assignedByName // ignore: cast_nullable_to_non_nullable
                  as String?,
        validFrom: freezed == validFrom
            ? _value.validFrom
            : validFrom // ignore: cast_nullable_to_non_nullable
                  as String?,
        validUntil: freezed == validUntil
            ? _value.validUntil
            : validUntil // ignore: cast_nullable_to_non_nullable
                  as String?,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        contractorId: freezed == contractorId
            ? _value.contractorId
            : contractorId // ignore: cast_nullable_to_non_nullable
                  as String?,
        contractorName: freezed == contractorName
            ? _value.contractorName
            : contractorName // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectId: freezed == projectId
            ? _value.projectId
            : projectId // ignore: cast_nullable_to_non_nullable
                  as String?,
        projectName: freezed == projectName
            ? _value.projectName
            : projectName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkerSiteAssignmentModelImpl implements _WorkerSiteAssignmentModel {
  const _$WorkerSiteAssignmentModelImpl({
    required this.id,
    required this.workerId,
    required this.workerName,
    required this.branchId,
    required this.siteName,
    this.assignedById,
    this.assignedByName,
    this.validFrom,
    this.validUntil,
    this.isActive = true,
    this.contractorId,
    this.contractorName,
    this.projectId,
    this.projectName,
  });

  factory _$WorkerSiteAssignmentModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkerSiteAssignmentModelImplFromJson(json);

  @override
  final String id;
  @override
  final String workerId;
  @override
  final String workerName;
  @override
  final String branchId;
  @override
  final String siteName;
  @override
  final String? assignedById;
  @override
  final String? assignedByName;
  @override
  final String? validFrom;
  @override
  final String? validUntil;
  @override
  @JsonKey()
  final bool isActive;
  @override
  final String? contractorId;
  @override
  final String? contractorName;
  @override
  final String? projectId;
  @override
  final String? projectName;

  @override
  String toString() {
    return 'WorkerSiteAssignmentModel(id: $id, workerId: $workerId, workerName: $workerName, branchId: $branchId, siteName: $siteName, assignedById: $assignedById, assignedByName: $assignedByName, validFrom: $validFrom, validUntil: $validUntil, isActive: $isActive, contractorId: $contractorId, contractorName: $contractorName, projectId: $projectId, projectName: $projectName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkerSiteAssignmentModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.workerId, workerId) ||
                other.workerId == workerId) &&
            (identical(other.workerName, workerName) ||
                other.workerName == workerName) &&
            (identical(other.branchId, branchId) ||
                other.branchId == branchId) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.assignedById, assignedById) ||
                other.assignedById == assignedById) &&
            (identical(other.assignedByName, assignedByName) ||
                other.assignedByName == assignedByName) &&
            (identical(other.validFrom, validFrom) ||
                other.validFrom == validFrom) &&
            (identical(other.validUntil, validUntil) ||
                other.validUntil == validUntil) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.contractorId, contractorId) ||
                other.contractorId == contractorId) &&
            (identical(other.contractorName, contractorName) ||
                other.contractorName == contractorName) &&
            (identical(other.projectId, projectId) ||
                other.projectId == projectId) &&
            (identical(other.projectName, projectName) ||
                other.projectName == projectName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    workerId,
    workerName,
    branchId,
    siteName,
    assignedById,
    assignedByName,
    validFrom,
    validUntil,
    isActive,
    contractorId,
    contractorName,
    projectId,
    projectName,
  );

  /// Create a copy of WorkerSiteAssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkerSiteAssignmentModelImplCopyWith<_$WorkerSiteAssignmentModelImpl>
  get copyWith =>
      __$$WorkerSiteAssignmentModelImplCopyWithImpl<
        _$WorkerSiteAssignmentModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkerSiteAssignmentModelImplToJson(this);
  }
}

abstract class _WorkerSiteAssignmentModel implements WorkerSiteAssignmentModel {
  const factory _WorkerSiteAssignmentModel({
    required final String id,
    required final String workerId,
    required final String workerName,
    required final String branchId,
    required final String siteName,
    final String? assignedById,
    final String? assignedByName,
    final String? validFrom,
    final String? validUntil,
    final bool isActive,
    final String? contractorId,
    final String? contractorName,
    final String? projectId,
    final String? projectName,
  }) = _$WorkerSiteAssignmentModelImpl;

  factory _WorkerSiteAssignmentModel.fromJson(Map<String, dynamic> json) =
      _$WorkerSiteAssignmentModelImpl.fromJson;

  @override
  String get id;
  @override
  String get workerId;
  @override
  String get workerName;
  @override
  String get branchId;
  @override
  String get siteName;
  @override
  String? get assignedById;
  @override
  String? get assignedByName;
  @override
  String? get validFrom;
  @override
  String? get validUntil;
  @override
  bool get isActive;
  @override
  String? get contractorId;
  @override
  String? get contractorName;
  @override
  String? get projectId;
  @override
  String? get projectName;

  /// Create a copy of WorkerSiteAssignmentModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkerSiteAssignmentModelImplCopyWith<_$WorkerSiteAssignmentModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
