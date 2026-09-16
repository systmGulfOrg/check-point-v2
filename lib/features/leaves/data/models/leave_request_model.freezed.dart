// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveRequestModel _$LeaveRequestModelFromJson(Map<String, dynamic> json) {
  return _LeaveRequestModel.fromJson(json);
}

/// @nodoc
mixin _$LeaveRequestModel {
  String get id => throw _privateConstructorUsedError;
  String get leaveTypeId => throw _privateConstructorUsedError;
  String? get leaveTypeName => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  int get totalDays => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get attachmentUrl => throw _privateConstructorUsedError;
  DateTime? get createdAt =>
      throw _privateConstructorUsedError; // Stage 1 - Manager
  String? get managerId => throw _privateConstructorUsedError;
  String? get managerName => throw _privateConstructorUsedError;
  DateTime? get managerActionAt => throw _privateConstructorUsedError;
  String? get managerRejectionReason =>
      throw _privateConstructorUsedError; // Stage 2 - HR
  String? get hrId => throw _privateConstructorUsedError;
  String? get hrName => throw _privateConstructorUsedError;
  DateTime? get hrActionAt => throw _privateConstructorUsedError;
  String? get hrRejectionReason => throw _privateConstructorUsedError;

  /// Serializes this LeaveRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveRequestModelCopyWith<LeaveRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveRequestModelCopyWith<$Res> {
  factory $LeaveRequestModelCopyWith(
    LeaveRequestModel value,
    $Res Function(LeaveRequestModel) then,
  ) = _$LeaveRequestModelCopyWithImpl<$Res, LeaveRequestModel>;
  @useResult
  $Res call({
    String id,
    String leaveTypeId,
    String? leaveTypeName,
    String employeeId,
    DateTime startDate,
    DateTime endDate,
    int totalDays,
    String status,
    String? reason,
    String? attachmentUrl,
    DateTime? createdAt,
    String? managerId,
    String? managerName,
    DateTime? managerActionAt,
    String? managerRejectionReason,
    String? hrId,
    String? hrName,
    DateTime? hrActionAt,
    String? hrRejectionReason,
  });
}

/// @nodoc
class _$LeaveRequestModelCopyWithImpl<$Res, $Val extends LeaveRequestModel>
    implements $LeaveRequestModelCopyWith<$Res> {
  _$LeaveRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? employeeId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalDays = null,
    Object? status = null,
    Object? reason = freezed,
    Object? attachmentUrl = freezed,
    Object? createdAt = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? managerActionAt = freezed,
    Object? managerRejectionReason = freezed,
    Object? hrId = freezed,
    Object? hrName = freezed,
    Object? hrActionAt = freezed,
    Object? hrRejectionReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            leaveTypeId: null == leaveTypeId
                ? _value.leaveTypeId
                : leaveTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            leaveTypeName: freezed == leaveTypeName
                ? _value.leaveTypeName
                : leaveTypeName // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            totalDays: null == totalDays
                ? _value.totalDays
                : totalDays // ignore: cast_nullable_to_non_nullable
                      as int,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            attachmentUrl: freezed == attachmentUrl
                ? _value.attachmentUrl
                : attachmentUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            managerId: freezed == managerId
                ? _value.managerId
                : managerId // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerName: freezed == managerName
                ? _value.managerName
                : managerName // ignore: cast_nullable_to_non_nullable
                      as String?,
            managerActionAt: freezed == managerActionAt
                ? _value.managerActionAt
                : managerActionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            managerRejectionReason: freezed == managerRejectionReason
                ? _value.managerRejectionReason
                : managerRejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
            hrId: freezed == hrId
                ? _value.hrId
                : hrId // ignore: cast_nullable_to_non_nullable
                      as String?,
            hrName: freezed == hrName
                ? _value.hrName
                : hrName // ignore: cast_nullable_to_non_nullable
                      as String?,
            hrActionAt: freezed == hrActionAt
                ? _value.hrActionAt
                : hrActionAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            hrRejectionReason: freezed == hrRejectionReason
                ? _value.hrRejectionReason
                : hrRejectionReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveRequestModelImplCopyWith<$Res>
    implements $LeaveRequestModelCopyWith<$Res> {
  factory _$$LeaveRequestModelImplCopyWith(
    _$LeaveRequestModelImpl value,
    $Res Function(_$LeaveRequestModelImpl) then,
  ) = __$$LeaveRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String leaveTypeId,
    String? leaveTypeName,
    String employeeId,
    DateTime startDate,
    DateTime endDate,
    int totalDays,
    String status,
    String? reason,
    String? attachmentUrl,
    DateTime? createdAt,
    String? managerId,
    String? managerName,
    DateTime? managerActionAt,
    String? managerRejectionReason,
    String? hrId,
    String? hrName,
    DateTime? hrActionAt,
    String? hrRejectionReason,
  });
}

/// @nodoc
class __$$LeaveRequestModelImplCopyWithImpl<$Res>
    extends _$LeaveRequestModelCopyWithImpl<$Res, _$LeaveRequestModelImpl>
    implements _$$LeaveRequestModelImplCopyWith<$Res> {
  __$$LeaveRequestModelImplCopyWithImpl(
    _$LeaveRequestModelImpl _value,
    $Res Function(_$LeaveRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? leaveTypeId = null,
    Object? leaveTypeName = freezed,
    Object? employeeId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? totalDays = null,
    Object? status = null,
    Object? reason = freezed,
    Object? attachmentUrl = freezed,
    Object? createdAt = freezed,
    Object? managerId = freezed,
    Object? managerName = freezed,
    Object? managerActionAt = freezed,
    Object? managerRejectionReason = freezed,
    Object? hrId = freezed,
    Object? hrName = freezed,
    Object? hrActionAt = freezed,
    Object? hrRejectionReason = freezed,
  }) {
    return _then(
      _$LeaveRequestModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        leaveTypeId: null == leaveTypeId
            ? _value.leaveTypeId
            : leaveTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        leaveTypeName: freezed == leaveTypeName
            ? _value.leaveTypeName
            : leaveTypeName // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        totalDays: null == totalDays
            ? _value.totalDays
            : totalDays // ignore: cast_nullable_to_non_nullable
                  as int,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        attachmentUrl: freezed == attachmentUrl
            ? _value.attachmentUrl
            : attachmentUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        managerId: freezed == managerId
            ? _value.managerId
            : managerId // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerName: freezed == managerName
            ? _value.managerName
            : managerName // ignore: cast_nullable_to_non_nullable
                  as String?,
        managerActionAt: freezed == managerActionAt
            ? _value.managerActionAt
            : managerActionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        managerRejectionReason: freezed == managerRejectionReason
            ? _value.managerRejectionReason
            : managerRejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
        hrId: freezed == hrId
            ? _value.hrId
            : hrId // ignore: cast_nullable_to_non_nullable
                  as String?,
        hrName: freezed == hrName
            ? _value.hrName
            : hrName // ignore: cast_nullable_to_non_nullable
                  as String?,
        hrActionAt: freezed == hrActionAt
            ? _value.hrActionAt
            : hrActionAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        hrRejectionReason: freezed == hrRejectionReason
            ? _value.hrRejectionReason
            : hrRejectionReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveRequestModelImpl implements _LeaveRequestModel {
  const _$LeaveRequestModelImpl({
    required this.id,
    required this.leaveTypeId,
    this.leaveTypeName,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.totalDays,
    required this.status,
    this.reason,
    this.attachmentUrl,
    this.createdAt,
    this.managerId,
    this.managerName,
    this.managerActionAt,
    this.managerRejectionReason,
    this.hrId,
    this.hrName,
    this.hrActionAt,
    this.hrRejectionReason,
  });

  factory _$LeaveRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveRequestModelImplFromJson(json);

  @override
  final String id;
  @override
  final String leaveTypeId;
  @override
  final String? leaveTypeName;
  @override
  final String employeeId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final int totalDays;
  @override
  final String status;
  @override
  final String? reason;
  @override
  final String? attachmentUrl;
  @override
  final DateTime? createdAt;
  // Stage 1 - Manager
  @override
  final String? managerId;
  @override
  final String? managerName;
  @override
  final DateTime? managerActionAt;
  @override
  final String? managerRejectionReason;
  // Stage 2 - HR
  @override
  final String? hrId;
  @override
  final String? hrName;
  @override
  final DateTime? hrActionAt;
  @override
  final String? hrRejectionReason;

  @override
  String toString() {
    return 'LeaveRequestModel(id: $id, leaveTypeId: $leaveTypeId, leaveTypeName: $leaveTypeName, employeeId: $employeeId, startDate: $startDate, endDate: $endDate, totalDays: $totalDays, status: $status, reason: $reason, attachmentUrl: $attachmentUrl, createdAt: $createdAt, managerId: $managerId, managerName: $managerName, managerActionAt: $managerActionAt, managerRejectionReason: $managerRejectionReason, hrId: $hrId, hrName: $hrName, hrActionAt: $hrActionAt, hrRejectionReason: $hrRejectionReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveRequestModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.leaveTypeName, leaveTypeName) ||
                other.leaveTypeName == leaveTypeName) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.totalDays, totalDays) ||
                other.totalDays == totalDays) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.managerId, managerId) ||
                other.managerId == managerId) &&
            (identical(other.managerName, managerName) ||
                other.managerName == managerName) &&
            (identical(other.managerActionAt, managerActionAt) ||
                other.managerActionAt == managerActionAt) &&
            (identical(other.managerRejectionReason, managerRejectionReason) ||
                other.managerRejectionReason == managerRejectionReason) &&
            (identical(other.hrId, hrId) || other.hrId == hrId) &&
            (identical(other.hrName, hrName) || other.hrName == hrName) &&
            (identical(other.hrActionAt, hrActionAt) ||
                other.hrActionAt == hrActionAt) &&
            (identical(other.hrRejectionReason, hrRejectionReason) ||
                other.hrRejectionReason == hrRejectionReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    leaveTypeId,
    leaveTypeName,
    employeeId,
    startDate,
    endDate,
    totalDays,
    status,
    reason,
    attachmentUrl,
    createdAt,
    managerId,
    managerName,
    managerActionAt,
    managerRejectionReason,
    hrId,
    hrName,
    hrActionAt,
    hrRejectionReason,
  ]);

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveRequestModelImplCopyWith<_$LeaveRequestModelImpl> get copyWith =>
      __$$LeaveRequestModelImplCopyWithImpl<_$LeaveRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveRequestModelImplToJson(this);
  }
}

abstract class _LeaveRequestModel implements LeaveRequestModel {
  const factory _LeaveRequestModel({
    required final String id,
    required final String leaveTypeId,
    final String? leaveTypeName,
    required final String employeeId,
    required final DateTime startDate,
    required final DateTime endDate,
    required final int totalDays,
    required final String status,
    final String? reason,
    final String? attachmentUrl,
    final DateTime? createdAt,
    final String? managerId,
    final String? managerName,
    final DateTime? managerActionAt,
    final String? managerRejectionReason,
    final String? hrId,
    final String? hrName,
    final DateTime? hrActionAt,
    final String? hrRejectionReason,
  }) = _$LeaveRequestModelImpl;

  factory _LeaveRequestModel.fromJson(Map<String, dynamic> json) =
      _$LeaveRequestModelImpl.fromJson;

  @override
  String get id;
  @override
  String get leaveTypeId;
  @override
  String? get leaveTypeName;
  @override
  String get employeeId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  int get totalDays;
  @override
  String get status;
  @override
  String? get reason;
  @override
  String? get attachmentUrl;
  @override
  DateTime? get createdAt; // Stage 1 - Manager
  @override
  String? get managerId;
  @override
  String? get managerName;
  @override
  DateTime? get managerActionAt;
  @override
  String? get managerRejectionReason; // Stage 2 - HR
  @override
  String? get hrId;
  @override
  String? get hrName;
  @override
  DateTime? get hrActionAt;
  @override
  String? get hrRejectionReason;

  /// Create a copy of LeaveRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveRequestModelImplCopyWith<_$LeaveRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
