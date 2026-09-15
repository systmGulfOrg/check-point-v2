// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'short_leave_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShortLeaveModel _$ShortLeaveModelFromJson(Map<String, dynamic> json) {
  return _ShortLeaveModel.fromJson(json);
}

/// @nodoc
mixin _$ShortLeaveModel {
  String get id => throw _privateConstructorUsedError;
  String get employeeId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  double get totalHours => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ShortLeaveModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShortLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShortLeaveModelCopyWith<ShortLeaveModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortLeaveModelCopyWith<$Res> {
  factory $ShortLeaveModelCopyWith(
    ShortLeaveModel value,
    $Res Function(ShortLeaveModel) then,
  ) = _$ShortLeaveModelCopyWithImpl<$Res, ShortLeaveModel>;
  @useResult
  $Res call({
    String id,
    String employeeId,
    DateTime date,
    String startTime,
    String endTime,
    double totalHours,
    String status,
    String? reason,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$ShortLeaveModelCopyWithImpl<$Res, $Val extends ShortLeaveModel>
    implements $ShortLeaveModelCopyWith<$Res> {
  _$ShortLeaveModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? totalHours = null,
    Object? status = null,
    Object? reason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            employeeId: null == employeeId
                ? _value.employeeId
                : employeeId // ignore: cast_nullable_to_non_nullable
                      as String,
            date: null == date
                ? _value.date
                : date // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            startTime: null == startTime
                ? _value.startTime
                : startTime // ignore: cast_nullable_to_non_nullable
                      as String,
            endTime: null == endTime
                ? _value.endTime
                : endTime // ignore: cast_nullable_to_non_nullable
                      as String,
            totalHours: null == totalHours
                ? _value.totalHours
                : totalHours // ignore: cast_nullable_to_non_nullable
                      as double,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShortLeaveModelImplCopyWith<$Res>
    implements $ShortLeaveModelCopyWith<$Res> {
  factory _$$ShortLeaveModelImplCopyWith(
    _$ShortLeaveModelImpl value,
    $Res Function(_$ShortLeaveModelImpl) then,
  ) = __$$ShortLeaveModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String employeeId,
    DateTime date,
    String startTime,
    String endTime,
    double totalHours,
    String status,
    String? reason,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$ShortLeaveModelImplCopyWithImpl<$Res>
    extends _$ShortLeaveModelCopyWithImpl<$Res, _$ShortLeaveModelImpl>
    implements _$$ShortLeaveModelImplCopyWith<$Res> {
  __$$ShortLeaveModelImplCopyWithImpl(
    _$ShortLeaveModelImpl _value,
    $Res Function(_$ShortLeaveModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShortLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? employeeId = null,
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? totalHours = null,
    Object? status = null,
    Object? reason = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$ShortLeaveModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        employeeId: null == employeeId
            ? _value.employeeId
            : employeeId // ignore: cast_nullable_to_non_nullable
                  as String,
        date: null == date
            ? _value.date
            : date // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        startTime: null == startTime
            ? _value.startTime
            : startTime // ignore: cast_nullable_to_non_nullable
                  as String,
        endTime: null == endTime
            ? _value.endTime
            : endTime // ignore: cast_nullable_to_non_nullable
                  as String,
        totalHours: null == totalHours
            ? _value.totalHours
            : totalHours // ignore: cast_nullable_to_non_nullable
                  as double,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShortLeaveModelImpl implements _ShortLeaveModel {
  const _$ShortLeaveModelImpl({
    required this.id,
    required this.employeeId,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.totalHours,
    required this.status,
    this.reason,
    this.createdAt,
  });

  factory _$ShortLeaveModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShortLeaveModelImplFromJson(json);

  @override
  final String id;
  @override
  final String employeeId;
  @override
  final DateTime date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final double totalHours;
  @override
  final String status;
  @override
  final String? reason;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'ShortLeaveModel(id: $id, employeeId: $employeeId, date: $date, startTime: $startTime, endTime: $endTime, totalHours: $totalHours, status: $status, reason: $reason, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortLeaveModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.totalHours, totalHours) ||
                other.totalHours == totalHours) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    employeeId,
    date,
    startTime,
    endTime,
    totalHours,
    status,
    reason,
    createdAt,
  );

  /// Create a copy of ShortLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortLeaveModelImplCopyWith<_$ShortLeaveModelImpl> get copyWith =>
      __$$ShortLeaveModelImplCopyWithImpl<_$ShortLeaveModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShortLeaveModelImplToJson(this);
  }
}

abstract class _ShortLeaveModel implements ShortLeaveModel {
  const factory _ShortLeaveModel({
    required final String id,
    required final String employeeId,
    required final DateTime date,
    required final String startTime,
    required final String endTime,
    required final double totalHours,
    required final String status,
    final String? reason,
    final DateTime? createdAt,
  }) = _$ShortLeaveModelImpl;

  factory _ShortLeaveModel.fromJson(Map<String, dynamic> json) =
      _$ShortLeaveModelImpl.fromJson;

  @override
  String get id;
  @override
  String get employeeId;
  @override
  DateTime get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  double get totalHours;
  @override
  String get status;
  @override
  String? get reason;
  @override
  DateTime? get createdAt;

  /// Create a copy of ShortLeaveModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortLeaveModelImplCopyWith<_$ShortLeaveModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
