// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_request_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LeaveRequestBody _$LeaveRequestBodyFromJson(Map<String, dynamic> json) {
  return _LeaveRequestBody.fromJson(json);
}

/// @nodoc
mixin _$LeaveRequestBody {
  String get leaveTypeId => throw _privateConstructorUsedError;
  DateTime get startDate => throw _privateConstructorUsedError;
  DateTime get endDate => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  String? get attachmentUrl => throw _privateConstructorUsedError;

  /// Serializes this LeaveRequestBody to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaveRequestBodyCopyWith<LeaveRequestBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaveRequestBodyCopyWith<$Res> {
  factory $LeaveRequestBodyCopyWith(
    LeaveRequestBody value,
    $Res Function(LeaveRequestBody) then,
  ) = _$LeaveRequestBodyCopyWithImpl<$Res, LeaveRequestBody>;
  @useResult
  $Res call({
    String leaveTypeId,
    DateTime startDate,
    DateTime endDate,
    String? reason,
    String? attachmentUrl,
  });
}

/// @nodoc
class _$LeaveRequestBodyCopyWithImpl<$Res, $Val extends LeaveRequestBody>
    implements $LeaveRequestBodyCopyWith<$Res> {
  _$LeaveRequestBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveTypeId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = freezed,
    Object? attachmentUrl = freezed,
  }) {
    return _then(
      _value.copyWith(
            leaveTypeId: null == leaveTypeId
                ? _value.leaveTypeId
                : leaveTypeId // ignore: cast_nullable_to_non_nullable
                      as String,
            startDate: null == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            endDate: null == endDate
                ? _value.endDate
                : endDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            reason: freezed == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String?,
            attachmentUrl: freezed == attachmentUrl
                ? _value.attachmentUrl
                : attachmentUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeaveRequestBodyImplCopyWith<$Res>
    implements $LeaveRequestBodyCopyWith<$Res> {
  factory _$$LeaveRequestBodyImplCopyWith(
    _$LeaveRequestBodyImpl value,
    $Res Function(_$LeaveRequestBodyImpl) then,
  ) = __$$LeaveRequestBodyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String leaveTypeId,
    DateTime startDate,
    DateTime endDate,
    String? reason,
    String? attachmentUrl,
  });
}

/// @nodoc
class __$$LeaveRequestBodyImplCopyWithImpl<$Res>
    extends _$LeaveRequestBodyCopyWithImpl<$Res, _$LeaveRequestBodyImpl>
    implements _$$LeaveRequestBodyImplCopyWith<$Res> {
  __$$LeaveRequestBodyImplCopyWithImpl(
    _$LeaveRequestBodyImpl _value,
    $Res Function(_$LeaveRequestBodyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? leaveTypeId = null,
    Object? startDate = null,
    Object? endDate = null,
    Object? reason = freezed,
    Object? attachmentUrl = freezed,
  }) {
    return _then(
      _$LeaveRequestBodyImpl(
        leaveTypeId: null == leaveTypeId
            ? _value.leaveTypeId
            : leaveTypeId // ignore: cast_nullable_to_non_nullable
                  as String,
        startDate: null == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        endDate: null == endDate
            ? _value.endDate
            : endDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        reason: freezed == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String?,
        attachmentUrl: freezed == attachmentUrl
            ? _value.attachmentUrl
            : attachmentUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaveRequestBodyImpl implements _LeaveRequestBody {
  const _$LeaveRequestBodyImpl({
    required this.leaveTypeId,
    required this.startDate,
    required this.endDate,
    this.reason,
    this.attachmentUrl,
  });

  factory _$LeaveRequestBodyImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaveRequestBodyImplFromJson(json);

  @override
  final String leaveTypeId;
  @override
  final DateTime startDate;
  @override
  final DateTime endDate;
  @override
  final String? reason;
  @override
  final String? attachmentUrl;

  @override
  String toString() {
    return 'LeaveRequestBody(leaveTypeId: $leaveTypeId, startDate: $startDate, endDate: $endDate, reason: $reason, attachmentUrl: $attachmentUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaveRequestBodyImpl &&
            (identical(other.leaveTypeId, leaveTypeId) ||
                other.leaveTypeId == leaveTypeId) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.endDate, endDate) || other.endDate == endDate) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.attachmentUrl, attachmentUrl) ||
                other.attachmentUrl == attachmentUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    leaveTypeId,
    startDate,
    endDate,
    reason,
    attachmentUrl,
  );

  /// Create a copy of LeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaveRequestBodyImplCopyWith<_$LeaveRequestBodyImpl> get copyWith =>
      __$$LeaveRequestBodyImplCopyWithImpl<_$LeaveRequestBodyImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaveRequestBodyImplToJson(this);
  }
}

abstract class _LeaveRequestBody implements LeaveRequestBody {
  const factory _LeaveRequestBody({
    required final String leaveTypeId,
    required final DateTime startDate,
    required final DateTime endDate,
    final String? reason,
    final String? attachmentUrl,
  }) = _$LeaveRequestBodyImpl;

  factory _LeaveRequestBody.fromJson(Map<String, dynamic> json) =
      _$LeaveRequestBodyImpl.fromJson;

  @override
  String get leaveTypeId;
  @override
  DateTime get startDate;
  @override
  DateTime get endDate;
  @override
  String? get reason;
  @override
  String? get attachmentUrl;

  /// Create a copy of LeaveRequestBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaveRequestBodyImplCopyWith<_$LeaveRequestBodyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
