// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_session_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthSessionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthSessionInitial value) initial,
    required TResult Function(AuthSessionLoading value) loading,
    required TResult Function(AuthSessionSuccess value) success,
    required TResult Function(AuthSessionError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthSessionInitial value)? initial,
    TResult? Function(AuthSessionLoading value)? loading,
    TResult? Function(AuthSessionSuccess value)? success,
    TResult? Function(AuthSessionError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSessionInitial value)? initial,
    TResult Function(AuthSessionLoading value)? loading,
    TResult Function(AuthSessionSuccess value)? success,
    TResult Function(AuthSessionError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthSessionStateCopyWith<$Res> {
  factory $AuthSessionStateCopyWith(
    AuthSessionState value,
    $Res Function(AuthSessionState) then,
  ) = _$AuthSessionStateCopyWithImpl<$Res, AuthSessionState>;
}

/// @nodoc
class _$AuthSessionStateCopyWithImpl<$Res, $Val extends AuthSessionState>
    implements $AuthSessionStateCopyWith<$Res> {
  _$AuthSessionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthSessionInitialImplCopyWith<$Res> {
  factory _$$AuthSessionInitialImplCopyWith(
    _$AuthSessionInitialImpl value,
    $Res Function(_$AuthSessionInitialImpl) then,
  ) = __$$AuthSessionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSessionInitialImplCopyWithImpl<$Res>
    extends _$AuthSessionStateCopyWithImpl<$Res, _$AuthSessionInitialImpl>
    implements _$$AuthSessionInitialImplCopyWith<$Res> {
  __$$AuthSessionInitialImplCopyWithImpl(
    _$AuthSessionInitialImpl _value,
    $Res Function(_$AuthSessionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSessionInitialImpl implements AuthSessionInitial {
  const _$AuthSessionInitialImpl();

  @override
  String toString() {
    return 'AuthSessionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthSessionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(AuthSessionInitial value) initial,
    required TResult Function(AuthSessionLoading value) loading,
    required TResult Function(AuthSessionSuccess value) success,
    required TResult Function(AuthSessionError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthSessionInitial value)? initial,
    TResult? Function(AuthSessionLoading value)? loading,
    TResult? Function(AuthSessionSuccess value)? success,
    TResult? Function(AuthSessionError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSessionInitial value)? initial,
    TResult Function(AuthSessionLoading value)? loading,
    TResult Function(AuthSessionSuccess value)? success,
    TResult Function(AuthSessionError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthSessionInitial implements AuthSessionState {
  const factory AuthSessionInitial() = _$AuthSessionInitialImpl;
}

/// @nodoc
abstract class _$$AuthSessionLoadingImplCopyWith<$Res> {
  factory _$$AuthSessionLoadingImplCopyWith(
    _$AuthSessionLoadingImpl value,
    $Res Function(_$AuthSessionLoadingImpl) then,
  ) = __$$AuthSessionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSessionLoadingImplCopyWithImpl<$Res>
    extends _$AuthSessionStateCopyWithImpl<$Res, _$AuthSessionLoadingImpl>
    implements _$$AuthSessionLoadingImplCopyWith<$Res> {
  __$$AuthSessionLoadingImplCopyWithImpl(
    _$AuthSessionLoadingImpl _value,
    $Res Function(_$AuthSessionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSessionLoadingImpl implements AuthSessionLoading {
  const _$AuthSessionLoadingImpl();

  @override
  String toString() {
    return 'AuthSessionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthSessionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function()? success,
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
    required TResult Function(AuthSessionInitial value) initial,
    required TResult Function(AuthSessionLoading value) loading,
    required TResult Function(AuthSessionSuccess value) success,
    required TResult Function(AuthSessionError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthSessionInitial value)? initial,
    TResult? Function(AuthSessionLoading value)? loading,
    TResult? Function(AuthSessionSuccess value)? success,
    TResult? Function(AuthSessionError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSessionInitial value)? initial,
    TResult Function(AuthSessionLoading value)? loading,
    TResult Function(AuthSessionSuccess value)? success,
    TResult Function(AuthSessionError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthSessionLoading implements AuthSessionState {
  const factory AuthSessionLoading() = _$AuthSessionLoadingImpl;
}

/// @nodoc
abstract class _$$AuthSessionSuccessImplCopyWith<$Res> {
  factory _$$AuthSessionSuccessImplCopyWith(
    _$AuthSessionSuccessImpl value,
    $Res Function(_$AuthSessionSuccessImpl) then,
  ) = __$$AuthSessionSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthSessionSuccessImplCopyWithImpl<$Res>
    extends _$AuthSessionStateCopyWithImpl<$Res, _$AuthSessionSuccessImpl>
    implements _$$AuthSessionSuccessImplCopyWith<$Res> {
  __$$AuthSessionSuccessImplCopyWithImpl(
    _$AuthSessionSuccessImpl _value,
    $Res Function(_$AuthSessionSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthSessionSuccessImpl implements AuthSessionSuccess {
  const _$AuthSessionSuccessImpl();

  @override
  String toString() {
    return 'AuthSessionState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthSessionSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(AuthSessionInitial value) initial,
    required TResult Function(AuthSessionLoading value) loading,
    required TResult Function(AuthSessionSuccess value) success,
    required TResult Function(AuthSessionError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthSessionInitial value)? initial,
    TResult? Function(AuthSessionLoading value)? loading,
    TResult? Function(AuthSessionSuccess value)? success,
    TResult? Function(AuthSessionError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSessionInitial value)? initial,
    TResult Function(AuthSessionLoading value)? loading,
    TResult Function(AuthSessionSuccess value)? success,
    TResult Function(AuthSessionError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AuthSessionSuccess implements AuthSessionState {
  const factory AuthSessionSuccess() = _$AuthSessionSuccessImpl;
}

/// @nodoc
abstract class _$$AuthSessionErrorImplCopyWith<$Res> {
  factory _$$AuthSessionErrorImplCopyWith(
    _$AuthSessionErrorImpl value,
    $Res Function(_$AuthSessionErrorImpl) then,
  ) = __$$AuthSessionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AuthSessionErrorImplCopyWithImpl<$Res>
    extends _$AuthSessionStateCopyWithImpl<$Res, _$AuthSessionErrorImpl>
    implements _$$AuthSessionErrorImplCopyWith<$Res> {
  __$$AuthSessionErrorImplCopyWithImpl(
    _$AuthSessionErrorImpl _value,
    $Res Function(_$AuthSessionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AuthSessionErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthSessionErrorImpl implements AuthSessionError {
  const _$AuthSessionErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AuthSessionState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthSessionErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthSessionErrorImplCopyWith<_$AuthSessionErrorImpl> get copyWith =>
      __$$AuthSessionErrorImplCopyWithImpl<_$AuthSessionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
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
    required TResult Function(AuthSessionInitial value) initial,
    required TResult Function(AuthSessionLoading value) loading,
    required TResult Function(AuthSessionSuccess value) success,
    required TResult Function(AuthSessionError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthSessionInitial value)? initial,
    TResult? Function(AuthSessionLoading value)? loading,
    TResult? Function(AuthSessionSuccess value)? success,
    TResult? Function(AuthSessionError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthSessionInitial value)? initial,
    TResult Function(AuthSessionLoading value)? loading,
    TResult Function(AuthSessionSuccess value)? success,
    TResult Function(AuthSessionError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthSessionError implements AuthSessionState {
  const factory AuthSessionError(final String messageKey) =
      _$AuthSessionErrorImpl;

  String get messageKey;

  /// Create a copy of AuthSessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthSessionErrorImplCopyWith<_$AuthSessionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
