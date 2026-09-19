// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'permit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PermitState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermitInitial value) initial,
    required TResult Function(PermitSubmitting value) submitting,
    required TResult Function(PermitSuccess value) success,
    required TResult Function(PermitError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermitInitial value)? initial,
    TResult? Function(PermitSubmitting value)? submitting,
    TResult? Function(PermitSuccess value)? success,
    TResult? Function(PermitError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermitInitial value)? initial,
    TResult Function(PermitSubmitting value)? submitting,
    TResult Function(PermitSuccess value)? success,
    TResult Function(PermitError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PermitStateCopyWith<$Res> {
  factory $PermitStateCopyWith(
    PermitState value,
    $Res Function(PermitState) then,
  ) = _$PermitStateCopyWithImpl<$Res, PermitState>;
}

/// @nodoc
class _$PermitStateCopyWithImpl<$Res, $Val extends PermitState>
    implements $PermitStateCopyWith<$Res> {
  _$PermitStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$PermitInitialImplCopyWith<$Res> {
  factory _$$PermitInitialImplCopyWith(
    _$PermitInitialImpl value,
    $Res Function(_$PermitInitialImpl) then,
  ) = __$$PermitInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermitInitialImplCopyWithImpl<$Res>
    extends _$PermitStateCopyWithImpl<$Res, _$PermitInitialImpl>
    implements _$$PermitInitialImplCopyWith<$Res> {
  __$$PermitInitialImplCopyWithImpl(
    _$PermitInitialImpl _value,
    $Res Function(_$PermitInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermitInitialImpl implements PermitInitial {
  const _$PermitInitialImpl();

  @override
  String toString() {
    return 'PermitState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermitInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(PermitInitial value) initial,
    required TResult Function(PermitSubmitting value) submitting,
    required TResult Function(PermitSuccess value) success,
    required TResult Function(PermitError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermitInitial value)? initial,
    TResult? Function(PermitSubmitting value)? submitting,
    TResult? Function(PermitSuccess value)? success,
    TResult? Function(PermitError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermitInitial value)? initial,
    TResult Function(PermitSubmitting value)? submitting,
    TResult Function(PermitSuccess value)? success,
    TResult Function(PermitError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PermitInitial implements PermitState {
  const factory PermitInitial() = _$PermitInitialImpl;
}

/// @nodoc
abstract class _$$PermitSubmittingImplCopyWith<$Res> {
  factory _$$PermitSubmittingImplCopyWith(
    _$PermitSubmittingImpl value,
    $Res Function(_$PermitSubmittingImpl) then,
  ) = __$$PermitSubmittingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermitSubmittingImplCopyWithImpl<$Res>
    extends _$PermitStateCopyWithImpl<$Res, _$PermitSubmittingImpl>
    implements _$$PermitSubmittingImplCopyWith<$Res> {
  __$$PermitSubmittingImplCopyWithImpl(
    _$PermitSubmittingImpl _value,
    $Res Function(_$PermitSubmittingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermitSubmittingImpl implements PermitSubmitting {
  const _$PermitSubmittingImpl();

  @override
  String toString() {
    return 'PermitState.submitting()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermitSubmittingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return submitting();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return submitting?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermitInitial value) initial,
    required TResult Function(PermitSubmitting value) submitting,
    required TResult Function(PermitSuccess value) success,
    required TResult Function(PermitError value) error,
  }) {
    return submitting(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermitInitial value)? initial,
    TResult? Function(PermitSubmitting value)? submitting,
    TResult? Function(PermitSuccess value)? success,
    TResult? Function(PermitError value)? error,
  }) {
    return submitting?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermitInitial value)? initial,
    TResult Function(PermitSubmitting value)? submitting,
    TResult Function(PermitSuccess value)? success,
    TResult Function(PermitError value)? error,
    required TResult orElse(),
  }) {
    if (submitting != null) {
      return submitting(this);
    }
    return orElse();
  }
}

abstract class PermitSubmitting implements PermitState {
  const factory PermitSubmitting() = _$PermitSubmittingImpl;
}

/// @nodoc
abstract class _$$PermitSuccessImplCopyWith<$Res> {
  factory _$$PermitSuccessImplCopyWith(
    _$PermitSuccessImpl value,
    $Res Function(_$PermitSuccessImpl) then,
  ) = __$$PermitSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PermitSuccessImplCopyWithImpl<$Res>
    extends _$PermitStateCopyWithImpl<$Res, _$PermitSuccessImpl>
    implements _$$PermitSuccessImplCopyWith<$Res> {
  __$$PermitSuccessImplCopyWithImpl(
    _$PermitSuccessImpl _value,
    $Res Function(_$PermitSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PermitSuccessImpl implements PermitSuccess {
  const _$PermitSuccessImpl();

  @override
  String toString() {
    return 'PermitState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PermitSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PermitInitial value) initial,
    required TResult Function(PermitSubmitting value) submitting,
    required TResult Function(PermitSuccess value) success,
    required TResult Function(PermitError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermitInitial value)? initial,
    TResult? Function(PermitSubmitting value)? submitting,
    TResult? Function(PermitSuccess value)? success,
    TResult? Function(PermitError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermitInitial value)? initial,
    TResult Function(PermitSubmitting value)? submitting,
    TResult Function(PermitSuccess value)? success,
    TResult Function(PermitError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class PermitSuccess implements PermitState {
  const factory PermitSuccess() = _$PermitSuccessImpl;
}

/// @nodoc
abstract class _$$PermitErrorImplCopyWith<$Res> {
  factory _$$PermitErrorImplCopyWith(
    _$PermitErrorImpl value,
    $Res Function(_$PermitErrorImpl) then,
  ) = __$$PermitErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$PermitErrorImplCopyWithImpl<$Res>
    extends _$PermitStateCopyWithImpl<$Res, _$PermitErrorImpl>
    implements _$$PermitErrorImplCopyWith<$Res> {
  __$$PermitErrorImplCopyWithImpl(
    _$PermitErrorImpl _value,
    $Res Function(_$PermitErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$PermitErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$PermitErrorImpl implements PermitError {
  const _$PermitErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'PermitState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PermitErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PermitErrorImplCopyWith<_$PermitErrorImpl> get copyWith =>
      __$$PermitErrorImplCopyWithImpl<_$PermitErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() submitting,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? submitting,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? submitting,
    TResult Function()? success,
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
    required TResult Function(PermitInitial value) initial,
    required TResult Function(PermitSubmitting value) submitting,
    required TResult Function(PermitSuccess value) success,
    required TResult Function(PermitError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PermitInitial value)? initial,
    TResult? Function(PermitSubmitting value)? submitting,
    TResult? Function(PermitSuccess value)? success,
    TResult? Function(PermitError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PermitInitial value)? initial,
    TResult Function(PermitSubmitting value)? submitting,
    TResult Function(PermitSuccess value)? success,
    TResult Function(PermitError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PermitError implements PermitState {
  const factory PermitError(final String messageKey) = _$PermitErrorImpl;

  String get messageKey;

  /// Create a copy of PermitState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PermitErrorImplCopyWith<_$PermitErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
