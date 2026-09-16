// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'short_leave_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ShortLeaveRequestBody _$ShortLeaveRequestBodyFromJson(
  Map<String, dynamic> json,
) {
  return _ShortLeaveRequestBody.fromJson(json);
}

/// @nodoc
mixin _$ShortLeaveRequestBody {
  DateTime get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get permitType => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;

  /// Serializes this ShortLeaveRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ShortLeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ShortLeaveRequestBodyCopyWith<ShortLeaveRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortLeaveRequestBodyCopyWith<$Res> {
  factory $ShortLeaveRequestBodyCopyWith(
    ShortLeaveRequestBody value,
    $Res Function(ShortLeaveRequestBody) then,
  ) = _$ShortLeaveRequestBodyCopyWithImpl<$Res, ShortLeaveRequestBody>;
  @useResult
  $Res call({
    DateTime date,
    String startTime,
    String endTime,
    String permitType,
    String? reason,
  });
}

/// @nodoc
class _$ShortLeaveRequestBodyCopyWithImpl<
  $Res,
  $Val extends ShortLeaveRequestBody
>
    implements $ShortLeaveRequestBodyCopyWith<$Res> {
  _$ShortLeaveRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ShortLeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? permitType = null,
    Object? reason = freezed,
  }) {
    return _then(
      _value.copyWith(
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
            permitType: null == permitType
                ? _value.permitType
                : permitType // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ShortLeaveRequestBodyImplCopyWith<$Res>
    implements $ShortLeaveRequestBodyCopyWith<$Res> {
  factory _$$ShortLeaveRequestBodyImplCopyWith(
    _$ShortLeaveRequestBodyImpl value,
    $Res Function(_$ShortLeaveRequestBodyImpl) then,
  ) = __$$ShortLeaveRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    DateTime date,
    String startTime,
    String endTime,
    String permitType,
    String? reason,
  });
}

/// @nodoc
class __$$ShortLeaveRequestBodyImplCopyWithImpl<$Res>
    extends
        _$ShortLeaveRequestBodyCopyWithImpl<$Res, _$ShortLeaveRequestBodyImpl>
    implements _$$ShortLeaveRequestBodyImplCopyWith<$Res> {
  __$$ShortLeaveRequestBodyImplCopyWithImpl(
    _$ShortLeaveRequestBodyImpl _value,
    $Res Function(_$ShortLeaveRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ShortLeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? permitType = null,
    Object? reason = freezed,
  }) {
    return _then(
      _$ShortLeaveRequestBodyImpl(
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
        permitType: null == permitType
            ? _value.permitType
            : permitType // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ShortLeaveRequestBodyImpl implements _ShortLeaveRequestBody {
  const _$ShortLeaveRequestBodyImpl({
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.permitType,
    this.reason,
  });

  factory _$ShortLeaveRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ShortLeaveRequestBodyImplFromJson(json);

  @override
  final DateTime date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String permitType;
  @override
  final String? reason;

  @override
  String toString() {
    return 'ShortLeaveRequestBody(date: $date, startTime: $startTime, endTime: $endTime, permitType: $permitType, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ShortLeaveRequestBodyImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.permitType, permitType) ||
                other.permitType == permitType) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, date, startTime, endTime, permitType, reason);

  /// Create a copy of ShortLeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ShortLeaveRequestBodyImplCopyWith<_$ShortLeaveRequestBodyImpl>
  get copyWith =>
      __$$ShortLeaveRequestBodyImplCopyWithImpl<_$ShortLeaveRequestBodyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ShortLeaveRequestBodyImplToJson(this);
  }
}

abstract class _ShortLeaveRequestBody implements ShortLeaveRequestBody {
  const factory _ShortLeaveRequestBody({
    required final DateTime date,
    required final String startTime,
    required final String endTime,
    required final String permitType,
    final String? reason,
  }) = _$ShortLeaveRequestBodyImpl;

  factory _ShortLeaveRequestBody.fromJson(Map<String, dynamic> json) =
      _$ShortLeaveRequestBodyImpl.fromJson;

  @override
  DateTime get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get permitType;
  @override
  String? get reason;

  /// Create a copy of ShortLeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ShortLeaveRequestBodyImplCopyWith<_$ShortLeaveRequestBodyImpl>
  get copyWith => throw _privateConstructorUsedError;
}
