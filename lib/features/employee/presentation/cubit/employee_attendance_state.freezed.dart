// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'employee_attendance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$EmployeeAttendanceState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmployeeAttendanceStateCopyWith<$Res> {
  factory $EmployeeAttendanceStateCopyWith(
    EmployeeAttendanceState value,
    $Res Function(EmployeeAttendanceState) then,
  ) = _$EmployeeAttendanceStateCopyWithImpl<$Res, EmployeeAttendanceState>;
}

/// @nodoc
class _$EmployeeAttendanceStateCopyWithImpl<
  $Res,
  $Val extends EmployeeAttendanceState
>
    implements $EmployeeAttendanceStateCopyWith<$Res> {
  _$EmployeeAttendanceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateInitialImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateInitialImplCopyWith(
    _$EmployeeAttendanceStateInitialImpl value,
    $Res Function(_$EmployeeAttendanceStateInitialImpl) then,
  ) = __$$EmployeeAttendanceStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmployeeAttendanceStateInitialImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateInitialImpl
        >
    implements _$$EmployeeAttendanceStateInitialImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateInitialImplCopyWithImpl(
    _$EmployeeAttendanceStateInitialImpl _value,
    $Res Function(_$EmployeeAttendanceStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmployeeAttendanceStateInitialImpl
    implements EmployeeAttendanceStateInitial {
  const _$EmployeeAttendanceStateInitialImpl();

  @override
  String toString() {
    return 'EmployeeAttendanceState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateInitial
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateInitial() =
      _$EmployeeAttendanceStateInitialImpl;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateLoadingImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateLoadingImplCopyWith(
    _$EmployeeAttendanceStateLoadingImpl value,
    $Res Function(_$EmployeeAttendanceStateLoadingImpl) then,
  ) = __$$EmployeeAttendanceStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmployeeAttendanceStateLoadingImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateLoadingImpl
        >
    implements _$$EmployeeAttendanceStateLoadingImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateLoadingImplCopyWithImpl(
    _$EmployeeAttendanceStateLoadingImpl _value,
    $Res Function(_$EmployeeAttendanceStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmployeeAttendanceStateLoadingImpl
    implements EmployeeAttendanceStateLoading {
  const _$EmployeeAttendanceStateLoadingImpl();

  @override
  String toString() {
    return 'EmployeeAttendanceState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateLoading
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateLoading() =
      _$EmployeeAttendanceStateLoadingImpl;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateCheckInSuccessImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateCheckInSuccessImplCopyWith(
    _$EmployeeAttendanceStateCheckInSuccessImpl value,
    $Res Function(_$EmployeeAttendanceStateCheckInSuccessImpl) then,
  ) = __$$EmployeeAttendanceStateCheckInSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AdminAttendanceModel attendance});
}

/// @nodoc
class __$$EmployeeAttendanceStateCheckInSuccessImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateCheckInSuccessImpl
        >
    implements _$$EmployeeAttendanceStateCheckInSuccessImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateCheckInSuccessImplCopyWithImpl(
    _$EmployeeAttendanceStateCheckInSuccessImpl _value,
    $Res Function(_$EmployeeAttendanceStateCheckInSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attendance = null}) {
    return _then(
      _$EmployeeAttendanceStateCheckInSuccessImpl(
        null == attendance
            ? _value.attendance
            : attendance // ignore: cast_nullable_to_non_nullable
                  as AdminAttendanceModel,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateCheckInSuccessImpl
    implements EmployeeAttendanceStateCheckInSuccess {
  const _$EmployeeAttendanceStateCheckInSuccessImpl(this.attendance);

  @override
  final AdminAttendanceModel attendance;

  @override
  String toString() {
    return 'EmployeeAttendanceState.checkInSuccess(attendance: $attendance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateCheckInSuccessImpl &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attendance);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateCheckInSuccessImplCopyWith<
    _$EmployeeAttendanceStateCheckInSuccessImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateCheckInSuccessImplCopyWithImpl<
        _$EmployeeAttendanceStateCheckInSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return checkInSuccess(attendance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return checkInSuccess?.call(attendance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (checkInSuccess != null) {
      return checkInSuccess(attendance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return checkInSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return checkInSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (checkInSuccess != null) {
      return checkInSuccess(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateCheckInSuccess
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateCheckInSuccess(
    final AdminAttendanceModel attendance,
  ) = _$EmployeeAttendanceStateCheckInSuccessImpl;

  AdminAttendanceModel get attendance;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateCheckInSuccessImplCopyWith<
    _$EmployeeAttendanceStateCheckInSuccessImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateCheckOutSuccessImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateCheckOutSuccessImplCopyWith(
    _$EmployeeAttendanceStateCheckOutSuccessImpl value,
    $Res Function(_$EmployeeAttendanceStateCheckOutSuccessImpl) then,
  ) = __$$EmployeeAttendanceStateCheckOutSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AdminAttendanceModel attendance});
}

/// @nodoc
class __$$EmployeeAttendanceStateCheckOutSuccessImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateCheckOutSuccessImpl
        >
    implements _$$EmployeeAttendanceStateCheckOutSuccessImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateCheckOutSuccessImplCopyWithImpl(
    _$EmployeeAttendanceStateCheckOutSuccessImpl _value,
    $Res Function(_$EmployeeAttendanceStateCheckOutSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? attendance = null}) {
    return _then(
      _$EmployeeAttendanceStateCheckOutSuccessImpl(
        null == attendance
            ? _value.attendance
            : attendance // ignore: cast_nullable_to_non_nullable
                  as AdminAttendanceModel,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateCheckOutSuccessImpl
    implements EmployeeAttendanceStateCheckOutSuccess {
  const _$EmployeeAttendanceStateCheckOutSuccessImpl(this.attendance);

  @override
  final AdminAttendanceModel attendance;

  @override
  String toString() {
    return 'EmployeeAttendanceState.checkOutSuccess(attendance: $attendance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateCheckOutSuccessImpl &&
            (identical(other.attendance, attendance) ||
                other.attendance == attendance));
  }

  @override
  int get hashCode => Object.hash(runtimeType, attendance);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateCheckOutSuccessImplCopyWith<
    _$EmployeeAttendanceStateCheckOutSuccessImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateCheckOutSuccessImplCopyWithImpl<
        _$EmployeeAttendanceStateCheckOutSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return checkOutSuccess(attendance);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return checkOutSuccess?.call(attendance);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (checkOutSuccess != null) {
      return checkOutSuccess(attendance);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return checkOutSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return checkOutSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (checkOutSuccess != null) {
      return checkOutSuccess(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateCheckOutSuccess
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateCheckOutSuccess(
    final AdminAttendanceModel attendance,
  ) = _$EmployeeAttendanceStateCheckOutSuccessImpl;

  AdminAttendanceModel get attendance;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateCheckOutSuccessImplCopyWith<
    _$EmployeeAttendanceStateCheckOutSuccessImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateTargetsLoadedImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateTargetsLoadedImplCopyWith(
    _$EmployeeAttendanceStateTargetsLoadedImpl value,
    $Res Function(_$EmployeeAttendanceStateTargetsLoadedImpl) then,
  ) = __$$EmployeeAttendanceStateTargetsLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<CustomerModel> targets});
}

/// @nodoc
class __$$EmployeeAttendanceStateTargetsLoadedImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateTargetsLoadedImpl
        >
    implements _$$EmployeeAttendanceStateTargetsLoadedImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateTargetsLoadedImplCopyWithImpl(
    _$EmployeeAttendanceStateTargetsLoadedImpl _value,
    $Res Function(_$EmployeeAttendanceStateTargetsLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? targets = null}) {
    return _then(
      _$EmployeeAttendanceStateTargetsLoadedImpl(
        null == targets
            ? _value._targets
            : targets // ignore: cast_nullable_to_non_nullable
                  as List<CustomerModel>,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateTargetsLoadedImpl
    implements EmployeeAttendanceStateTargetsLoaded {
  const _$EmployeeAttendanceStateTargetsLoadedImpl(
    final List<CustomerModel> targets,
  ) : _targets = targets;

  final List<CustomerModel> _targets;
  @override
  List<CustomerModel> get targets {
    if (_targets is EqualUnmodifiableListView) return _targets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_targets);
  }

  @override
  String toString() {
    return 'EmployeeAttendanceState.targetsLoaded(targets: $targets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateTargetsLoadedImpl &&
            const DeepCollectionEquality().equals(other._targets, _targets));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_targets));

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateTargetsLoadedImplCopyWith<
    _$EmployeeAttendanceStateTargetsLoadedImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateTargetsLoadedImplCopyWithImpl<
        _$EmployeeAttendanceStateTargetsLoadedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return targetsLoaded(targets);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return targetsLoaded?.call(targets);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (targetsLoaded != null) {
      return targetsLoaded(targets);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return targetsLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return targetsLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (targetsLoaded != null) {
      return targetsLoaded(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateTargetsLoaded
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateTargetsLoaded(
    final List<CustomerModel> targets,
  ) = _$EmployeeAttendanceStateTargetsLoadedImpl;

  List<CustomerModel> get targets;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateTargetsLoadedImplCopyWith<
    _$EmployeeAttendanceStateTargetsLoadedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWith<
  $Res
> {
  factory _$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWith(
    _$EmployeeAttendanceStateAreaValidationSuccessImpl value,
    $Res Function(_$EmployeeAttendanceStateAreaValidationSuccessImpl) then,
  ) = __$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateAreaValidationSuccessImpl
        >
    implements
        _$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateAreaValidationSuccessImplCopyWithImpl(
    _$EmployeeAttendanceStateAreaValidationSuccessImpl _value,
    $Res Function(_$EmployeeAttendanceStateAreaValidationSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$EmployeeAttendanceStateAreaValidationSuccessImpl
    implements EmployeeAttendanceStateAreaValidationSuccess {
  const _$EmployeeAttendanceStateAreaValidationSuccessImpl();

  @override
  String toString() {
    return 'EmployeeAttendanceState.areaValidationSuccess()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateAreaValidationSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return areaValidationSuccess();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return areaValidationSuccess?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (areaValidationSuccess != null) {
      return areaValidationSuccess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return areaValidationSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return areaValidationSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (areaValidationSuccess != null) {
      return areaValidationSuccess(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateAreaValidationSuccess
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateAreaValidationSuccess() =
      _$EmployeeAttendanceStateAreaValidationSuccessImpl;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateAreaValidationErrorImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateAreaValidationErrorImplCopyWith(
    _$EmployeeAttendanceStateAreaValidationErrorImpl value,
    $Res Function(_$EmployeeAttendanceStateAreaValidationErrorImpl) then,
  ) = __$$EmployeeAttendanceStateAreaValidationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$EmployeeAttendanceStateAreaValidationErrorImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateAreaValidationErrorImpl
        >
    implements _$$EmployeeAttendanceStateAreaValidationErrorImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateAreaValidationErrorImplCopyWithImpl(
    _$EmployeeAttendanceStateAreaValidationErrorImpl _value,
    $Res Function(_$EmployeeAttendanceStateAreaValidationErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$EmployeeAttendanceStateAreaValidationErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateAreaValidationErrorImpl
    implements EmployeeAttendanceStateAreaValidationError {
  const _$EmployeeAttendanceStateAreaValidationErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'EmployeeAttendanceState.areaValidationError(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateAreaValidationErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateAreaValidationErrorImplCopyWith<
    _$EmployeeAttendanceStateAreaValidationErrorImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateAreaValidationErrorImplCopyWithImpl<
        _$EmployeeAttendanceStateAreaValidationErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return areaValidationError(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return areaValidationError?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (areaValidationError != null) {
      return areaValidationError(messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return areaValidationError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return areaValidationError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (areaValidationError != null) {
      return areaValidationError(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateAreaValidationError
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateAreaValidationError(
    final String messageKey,
  ) = _$EmployeeAttendanceStateAreaValidationErrorImpl;

  String get messageKey;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateAreaValidationErrorImplCopyWith<
    _$EmployeeAttendanceStateAreaValidationErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateHistoryLoadedImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateHistoryLoadedImplCopyWith(
    _$EmployeeAttendanceStateHistoryLoadedImpl value,
    $Res Function(_$EmployeeAttendanceStateHistoryLoadedImpl) then,
  ) = __$$EmployeeAttendanceStateHistoryLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AdminAttendanceModel> history});
}

/// @nodoc
class __$$EmployeeAttendanceStateHistoryLoadedImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateHistoryLoadedImpl
        >
    implements _$$EmployeeAttendanceStateHistoryLoadedImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateHistoryLoadedImplCopyWithImpl(
    _$EmployeeAttendanceStateHistoryLoadedImpl _value,
    $Res Function(_$EmployeeAttendanceStateHistoryLoadedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? history = null}) {
    return _then(
      _$EmployeeAttendanceStateHistoryLoadedImpl(
        null == history
            ? _value._history
            : history // ignore: cast_nullable_to_non_nullable
                  as List<AdminAttendanceModel>,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateHistoryLoadedImpl
    implements EmployeeAttendanceStateHistoryLoaded {
  const _$EmployeeAttendanceStateHistoryLoadedImpl(
    final List<AdminAttendanceModel> history,
  ) : _history = history;

  final List<AdminAttendanceModel> _history;
  @override
  List<AdminAttendanceModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  String toString() {
    return 'EmployeeAttendanceState.historyLoaded(history: $history)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateHistoryLoadedImpl &&
            const DeepCollectionEquality().equals(other._history, _history));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_history));

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateHistoryLoadedImplCopyWith<
    _$EmployeeAttendanceStateHistoryLoadedImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateHistoryLoadedImplCopyWithImpl<
        _$EmployeeAttendanceStateHistoryLoadedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return historyLoaded(history);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return historyLoaded?.call(history);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(history);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return historyLoaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return historyLoaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (historyLoaded != null) {
      return historyLoaded(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateHistoryLoaded
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateHistoryLoaded(
    final List<AdminAttendanceModel> history,
  ) = _$EmployeeAttendanceStateHistoryLoadedImpl;

  List<AdminAttendanceModel> get history;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateHistoryLoadedImplCopyWith<
    _$EmployeeAttendanceStateHistoryLoadedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWith<
  $Res
> {
  factory _$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWith(
    _$EmployeeAttendanceStateTrackingStatusChangedImpl value,
    $Res Function(_$EmployeeAttendanceStateTrackingStatusChangedImpl) then,
  ) = __$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({bool isEnabled});
}

/// @nodoc
class __$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateTrackingStatusChangedImpl
        >
    implements
        _$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWithImpl(
    _$EmployeeAttendanceStateTrackingStatusChangedImpl _value,
    $Res Function(_$EmployeeAttendanceStateTrackingStatusChangedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? isEnabled = null}) {
    return _then(
      _$EmployeeAttendanceStateTrackingStatusChangedImpl(
        null == isEnabled
            ? _value.isEnabled
            : isEnabled // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateTrackingStatusChangedImpl
    implements EmployeeAttendanceStateTrackingStatusChanged {
  const _$EmployeeAttendanceStateTrackingStatusChangedImpl(this.isEnabled);

  @override
  final bool isEnabled;

  @override
  String toString() {
    return 'EmployeeAttendanceState.trackingStatusChanged(isEnabled: $isEnabled)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateTrackingStatusChangedImpl &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isEnabled);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWith<
    _$EmployeeAttendanceStateTrackingStatusChangedImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWithImpl<
        _$EmployeeAttendanceStateTrackingStatusChangedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return trackingStatusChanged(isEnabled);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return trackingStatusChanged?.call(isEnabled);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (trackingStatusChanged != null) {
      return trackingStatusChanged(isEnabled);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return trackingStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return trackingStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (trackingStatusChanged != null) {
      return trackingStatusChanged(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateTrackingStatusChanged
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateTrackingStatusChanged(
    final bool isEnabled,
  ) = _$EmployeeAttendanceStateTrackingStatusChangedImpl;

  bool get isEnabled;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateTrackingStatusChangedImplCopyWith<
    _$EmployeeAttendanceStateTrackingStatusChangedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateActionSuccessImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateActionSuccessImplCopyWith(
    _$EmployeeAttendanceStateActionSuccessImpl value,
    $Res Function(_$EmployeeAttendanceStateActionSuccessImpl) then,
  ) = __$$EmployeeAttendanceStateActionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$EmployeeAttendanceStateActionSuccessImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateActionSuccessImpl
        >
    implements _$$EmployeeAttendanceStateActionSuccessImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateActionSuccessImplCopyWithImpl(
    _$EmployeeAttendanceStateActionSuccessImpl _value,
    $Res Function(_$EmployeeAttendanceStateActionSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$EmployeeAttendanceStateActionSuccessImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateActionSuccessImpl
    implements EmployeeAttendanceStateActionSuccess {
  const _$EmployeeAttendanceStateActionSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'EmployeeAttendanceState.actionSuccess(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateActionSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateActionSuccessImplCopyWith<
    _$EmployeeAttendanceStateActionSuccessImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateActionSuccessImplCopyWithImpl<
        _$EmployeeAttendanceStateActionSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return actionSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return actionSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (actionSuccess != null) {
      return actionSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return actionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return actionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (actionSuccess != null) {
      return actionSuccess(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateActionSuccess
    implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateActionSuccess(final String message) =
      _$EmployeeAttendanceStateActionSuccessImpl;

  String get message;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateActionSuccessImplCopyWith<
    _$EmployeeAttendanceStateActionSuccessImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$EmployeeAttendanceStateErrorImplCopyWith<$Res> {
  factory _$$EmployeeAttendanceStateErrorImplCopyWith(
    _$EmployeeAttendanceStateErrorImpl value,
    $Res Function(_$EmployeeAttendanceStateErrorImpl) then,
  ) = __$$EmployeeAttendanceStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$EmployeeAttendanceStateErrorImplCopyWithImpl<$Res>
    extends
        _$EmployeeAttendanceStateCopyWithImpl<
          $Res,
          _$EmployeeAttendanceStateErrorImpl
        >
    implements _$$EmployeeAttendanceStateErrorImplCopyWith<$Res> {
  __$$EmployeeAttendanceStateErrorImplCopyWithImpl(
    _$EmployeeAttendanceStateErrorImpl _value,
    $Res Function(_$EmployeeAttendanceStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$EmployeeAttendanceStateErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$EmployeeAttendanceStateErrorImpl
    implements EmployeeAttendanceStateError {
  const _$EmployeeAttendanceStateErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'EmployeeAttendanceState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$EmployeeAttendanceStateErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$EmployeeAttendanceStateErrorImplCopyWith<
    _$EmployeeAttendanceStateErrorImpl
  >
  get copyWith =>
      __$$EmployeeAttendanceStateErrorImplCopyWithImpl<
        _$EmployeeAttendanceStateErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AdminAttendanceModel attendance) checkInSuccess,
    required TResult Function(AdminAttendanceModel attendance) checkOutSuccess,
    required TResult Function(List<CustomerModel> targets) targetsLoaded,
    required TResult Function() areaValidationSuccess,
    required TResult Function(String messageKey) areaValidationError,
    required TResult Function(List<AdminAttendanceModel> history) historyLoaded,
    required TResult Function(bool isEnabled) trackingStatusChanged,
    required TResult Function(String message) actionSuccess,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult? Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult? Function(List<CustomerModel> targets)? targetsLoaded,
    TResult? Function()? areaValidationSuccess,
    TResult? Function(String messageKey)? areaValidationError,
    TResult? Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult? Function(bool isEnabled)? trackingStatusChanged,
    TResult? Function(String message)? actionSuccess,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AdminAttendanceModel attendance)? checkInSuccess,
    TResult Function(AdminAttendanceModel attendance)? checkOutSuccess,
    TResult Function(List<CustomerModel> targets)? targetsLoaded,
    TResult Function()? areaValidationSuccess,
    TResult Function(String messageKey)? areaValidationError,
    TResult Function(List<AdminAttendanceModel> history)? historyLoaded,
    TResult Function(bool isEnabled)? trackingStatusChanged,
    TResult Function(String message)? actionSuccess,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(EmployeeAttendanceStateInitial value) initial,
    required TResult Function(EmployeeAttendanceStateLoading value) loading,
    required TResult Function(EmployeeAttendanceStateCheckInSuccess value)
    checkInSuccess,
    required TResult Function(EmployeeAttendanceStateCheckOutSuccess value)
    checkOutSuccess,
    required TResult Function(EmployeeAttendanceStateTargetsLoaded value)
    targetsLoaded,
    required TResult Function(
      EmployeeAttendanceStateAreaValidationSuccess value,
    )
    areaValidationSuccess,
    required TResult Function(EmployeeAttendanceStateAreaValidationError value)
    areaValidationError,
    required TResult Function(EmployeeAttendanceStateHistoryLoaded value)
    historyLoaded,
    required TResult Function(
      EmployeeAttendanceStateTrackingStatusChanged value,
    )
    trackingStatusChanged,
    required TResult Function(EmployeeAttendanceStateActionSuccess value)
    actionSuccess,
    required TResult Function(EmployeeAttendanceStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(EmployeeAttendanceStateInitial value)? initial,
    TResult? Function(EmployeeAttendanceStateLoading value)? loading,
    TResult? Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult? Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult? Function(EmployeeAttendanceStateTargetsLoaded value)?
    targetsLoaded,
    TResult? Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult? Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult? Function(EmployeeAttendanceStateHistoryLoaded value)?
    historyLoaded,
    TResult? Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult? Function(EmployeeAttendanceStateActionSuccess value)?
    actionSuccess,
    TResult? Function(EmployeeAttendanceStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(EmployeeAttendanceStateInitial value)? initial,
    TResult Function(EmployeeAttendanceStateLoading value)? loading,
    TResult Function(EmployeeAttendanceStateCheckInSuccess value)?
    checkInSuccess,
    TResult Function(EmployeeAttendanceStateCheckOutSuccess value)?
    checkOutSuccess,
    TResult Function(EmployeeAttendanceStateTargetsLoaded value)? targetsLoaded,
    TResult Function(EmployeeAttendanceStateAreaValidationSuccess value)?
    areaValidationSuccess,
    TResult Function(EmployeeAttendanceStateAreaValidationError value)?
    areaValidationError,
    TResult Function(EmployeeAttendanceStateHistoryLoaded value)? historyLoaded,
    TResult Function(EmployeeAttendanceStateTrackingStatusChanged value)?
    trackingStatusChanged,
    TResult Function(EmployeeAttendanceStateActionSuccess value)? actionSuccess,
    TResult Function(EmployeeAttendanceStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class EmployeeAttendanceStateError implements EmployeeAttendanceState {
  const factory EmployeeAttendanceStateError(final String messageKey) =
      _$EmployeeAttendanceStateErrorImpl;

  String get messageKey;

  /// Create a copy of EmployeeAttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$EmployeeAttendanceStateErrorImplCopyWith<
    _$EmployeeAttendanceStateErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
