// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_point_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttendancePointModel _$AttendancePointModelFromJson(Map<String, dynamic> json) {
  return _AttendancePointModel.fromJson(json);
}

/// @nodoc
mixin _$AttendancePointModel {
  String get id => throw _privateConstructorUsedError;
  String get pointType => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  String get attendanceDate => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AttendancePointModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendancePointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendancePointModelCopyWith<AttendancePointModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendancePointModelCopyWith<$Res> {
  factory $AttendancePointModelCopyWith(
    AttendancePointModel value,
    $Res Function(AttendancePointModel) then,
  ) = _$AttendancePointModelCopyWithImpl<$Res, AttendancePointModel>;
  @useResult
  $Res call({
    String id,
    String pointType,
    String status,
    String source,
    int points,
    String attendanceDate,
    String reason,
    DateTime? createdAt,
  });
}

/// @nodoc
class _$AttendancePointModelCopyWithImpl<
  $Res,
  $Val extends AttendancePointModel
>
    implements $AttendancePointModelCopyWith<$Res> {
  _$AttendancePointModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendancePointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointType = null,
    Object? status = null,
    Object? source = null,
    Object? points = null,
    Object? attendanceDate = null,
    Object? reason = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            pointType: null == pointType
                ? _value.pointType
                : pointType // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            attendanceDate: null == attendanceDate
                ? _value.attendanceDate
                : attendanceDate // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
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
abstract class _$$AttendancePointModelImplCopyWith<$Res>
    implements $AttendancePointModelCopyWith<$Res> {
  factory _$$AttendancePointModelImplCopyWith(
    _$AttendancePointModelImpl value,
    $Res Function(_$AttendancePointModelImpl) then,
  ) = __$$AttendancePointModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String pointType,
    String status,
    String source,
    int points,
    String attendanceDate,
    String reason,
    DateTime? createdAt,
  });
}

/// @nodoc
class __$$AttendancePointModelImplCopyWithImpl<$Res>
    extends _$AttendancePointModelCopyWithImpl<$Res, _$AttendancePointModelImpl>
    implements _$$AttendancePointModelImplCopyWith<$Res> {
  __$$AttendancePointModelImplCopyWithImpl(
    _$AttendancePointModelImpl _value,
    $Res Function(_$AttendancePointModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendancePointModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pointType = null,
    Object? status = null,
    Object? source = null,
    Object? points = null,
    Object? attendanceDate = null,
    Object? reason = null,
    Object? createdAt = freezed,
  }) {
    return _then(
      _$AttendancePointModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        pointType: null == pointType
            ? _value.pointType
            : pointType // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        attendanceDate: null == attendanceDate
            ? _value.attendanceDate
            : attendanceDate // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
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
class _$AttendancePointModelImpl implements _AttendancePointModel {
  const _$AttendancePointModelImpl({
    required this.id,
    required this.pointType,
    required this.status,
    required this.source,
    required this.points,
    required this.attendanceDate,
    required this.reason,
    this.createdAt,
  });

  factory _$AttendancePointModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendancePointModelImplFromJson(json);

  @override
  final String id;
  @override
  final String pointType;
  @override
  final String status;
  @override
  final String source;
  @override
  final int points;
  @override
  final String attendanceDate;
  @override
  final String reason;
  @override
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AttendancePointModel(id: $id, pointType: $pointType, status: $status, source: $source, points: $points, attendanceDate: $attendanceDate, reason: $reason, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendancePointModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pointType, pointType) ||
                other.pointType == pointType) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.attendanceDate, attendanceDate) ||
                other.attendanceDate == attendanceDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    pointType,
    status,
    source,
    points,
    attendanceDate,
    reason,
    createdAt,
  );

  /// Create a copy of AttendancePointModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendancePointModelImplCopyWith<_$AttendancePointModelImpl>
  get copyWith =>
      __$$AttendancePointModelImplCopyWithImpl<_$AttendancePointModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendancePointModelImplToJson(this);
  }
}

abstract class _AttendancePointModel implements AttendancePointModel {
  const factory _AttendancePointModel({
    required final String id,
    required final String pointType,
    required final String status,
    required final String source,
    required final int points,
    required final String attendanceDate,
    required final String reason,
    final DateTime? createdAt,
  }) = _$AttendancePointModelImpl;

  factory _AttendancePointModel.fromJson(Map<String, dynamic> json) =
      _$AttendancePointModelImpl.fromJson;

  @override
  String get id;
  @override
  String get pointType;
  @override
  String get status;
  @override
  String get source;
  @override
  int get points;
  @override
  String get attendanceDate;
  @override
  String get reason;
  @override
  DateTime? get createdAt;

  /// Create a copy of AttendancePointModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendancePointModelImplCopyWith<_$AttendancePointModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
