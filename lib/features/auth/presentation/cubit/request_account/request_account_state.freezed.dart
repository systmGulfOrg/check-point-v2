// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_account_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RequestAccountState {
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
    required TResult Function(RequestAccountInitial value) initial,
    required TResult Function(RequestAccountLoading value) loading,
    required TResult Function(RequestAccountSuccess value) success,
    required TResult Function(RequestAccountError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountInitial value)? initial,
    TResult? Function(RequestAccountLoading value)? loading,
    TResult? Function(RequestAccountSuccess value)? success,
    TResult? Function(RequestAccountError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountInitial value)? initial,
    TResult Function(RequestAccountLoading value)? loading,
    TResult Function(RequestAccountSuccess value)? success,
    TResult Function(RequestAccountError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestAccountStateCopyWith<$Res> {
  factory $RequestAccountStateCopyWith(
    RequestAccountState value,
    $Res Function(RequestAccountState) then,
  ) = _$RequestAccountStateCopyWithImpl<$Res, RequestAccountState>;
}

/// @nodoc
class _$RequestAccountStateCopyWithImpl<$Res, $Val extends RequestAccountState>
    implements $RequestAccountStateCopyWith<$Res> {
  _$RequestAccountStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RequestAccountInitialImplCopyWith<$Res> {
  factory _$$RequestAccountInitialImplCopyWith(
    _$RequestAccountInitialImpl value,
    $Res Function(_$RequestAccountInitialImpl) then,
  ) = __$$RequestAccountInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestAccountInitialImplCopyWithImpl<$Res>
    extends _$RequestAccountStateCopyWithImpl<$Res, _$RequestAccountInitialImpl>
    implements _$$RequestAccountInitialImplCopyWith<$Res> {
  __$$RequestAccountInitialImplCopyWithImpl(
    _$RequestAccountInitialImpl _value,
    $Res Function(_$RequestAccountInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestAccountInitialImpl implements RequestAccountInitial {
  const _$RequestAccountInitialImpl();

  @override
  String toString() {
    return 'RequestAccountState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountInitialImpl);
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
    required TResult Function(RequestAccountInitial value) initial,
    required TResult Function(RequestAccountLoading value) loading,
    required TResult Function(RequestAccountSuccess value) success,
    required TResult Function(RequestAccountError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountInitial value)? initial,
    TResult? Function(RequestAccountLoading value)? loading,
    TResult? Function(RequestAccountSuccess value)? success,
    TResult? Function(RequestAccountError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountInitial value)? initial,
    TResult Function(RequestAccountLoading value)? loading,
    TResult Function(RequestAccountSuccess value)? success,
    TResult Function(RequestAccountError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RequestAccountInitial implements RequestAccountState {
  const factory RequestAccountInitial() = _$RequestAccountInitialImpl;
}

/// @nodoc
abstract class _$$RequestAccountLoadingImplCopyWith<$Res> {
  factory _$$RequestAccountLoadingImplCopyWith(
    _$RequestAccountLoadingImpl value,
    $Res Function(_$RequestAccountLoadingImpl) then,
  ) = __$$RequestAccountLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestAccountLoadingImplCopyWithImpl<$Res>
    extends _$RequestAccountStateCopyWithImpl<$Res, _$RequestAccountLoadingImpl>
    implements _$$RequestAccountLoadingImplCopyWith<$Res> {
  __$$RequestAccountLoadingImplCopyWithImpl(
    _$RequestAccountLoadingImpl _value,
    $Res Function(_$RequestAccountLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestAccountLoadingImpl implements RequestAccountLoading {
  const _$RequestAccountLoadingImpl();

  @override
  String toString() {
    return 'RequestAccountState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountLoadingImpl);
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
    required TResult Function(RequestAccountInitial value) initial,
    required TResult Function(RequestAccountLoading value) loading,
    required TResult Function(RequestAccountSuccess value) success,
    required TResult Function(RequestAccountError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountInitial value)? initial,
    TResult? Function(RequestAccountLoading value)? loading,
    TResult? Function(RequestAccountSuccess value)? success,
    TResult? Function(RequestAccountError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountInitial value)? initial,
    TResult Function(RequestAccountLoading value)? loading,
    TResult Function(RequestAccountSuccess value)? success,
    TResult Function(RequestAccountError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RequestAccountLoading implements RequestAccountState {
  const factory RequestAccountLoading() = _$RequestAccountLoadingImpl;
}

/// @nodoc
abstract class _$$RequestAccountSuccessImplCopyWith<$Res> {
  factory _$$RequestAccountSuccessImplCopyWith(
    _$RequestAccountSuccessImpl value,
    $Res Function(_$RequestAccountSuccessImpl) then,
  ) = __$$RequestAccountSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestAccountSuccessImplCopyWithImpl<$Res>
    extends _$RequestAccountStateCopyWithImpl<$Res, _$RequestAccountSuccessImpl>
    implements _$$RequestAccountSuccessImplCopyWith<$Res> {
  __$$RequestAccountSuccessImplCopyWithImpl(
    _$RequestAccountSuccessImpl _value,
    $Res Function(_$RequestAccountSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestAccountSuccessImpl implements RequestAccountSuccess {
  const _$RequestAccountSuccessImpl();

  @override
  String toString() {
    return 'RequestAccountState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountSuccessImpl);
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
    required TResult Function(RequestAccountInitial value) initial,
    required TResult Function(RequestAccountLoading value) loading,
    required TResult Function(RequestAccountSuccess value) success,
    required TResult Function(RequestAccountError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountInitial value)? initial,
    TResult? Function(RequestAccountLoading value)? loading,
    TResult? Function(RequestAccountSuccess value)? success,
    TResult? Function(RequestAccountError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountInitial value)? initial,
    TResult Function(RequestAccountLoading value)? loading,
    TResult Function(RequestAccountSuccess value)? success,
    TResult Function(RequestAccountError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RequestAccountSuccess implements RequestAccountState {
  const factory RequestAccountSuccess() = _$RequestAccountSuccessImpl;
}

/// @nodoc
abstract class _$$RequestAccountErrorImplCopyWith<$Res> {
  factory _$$RequestAccountErrorImplCopyWith(
    _$RequestAccountErrorImpl value,
    $Res Function(_$RequestAccountErrorImpl) then,
  ) = __$$RequestAccountErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$RequestAccountErrorImplCopyWithImpl<$Res>
    extends _$RequestAccountStateCopyWithImpl<$Res, _$RequestAccountErrorImpl>
    implements _$$RequestAccountErrorImplCopyWith<$Res> {
  __$$RequestAccountErrorImplCopyWithImpl(
    _$RequestAccountErrorImpl _value,
    $Res Function(_$RequestAccountErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$RequestAccountErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RequestAccountErrorImpl implements RequestAccountError {
  const _$RequestAccountErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'RequestAccountState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestAccountErrorImplCopyWith<_$RequestAccountErrorImpl> get copyWith =>
      __$$RequestAccountErrorImplCopyWithImpl<_$RequestAccountErrorImpl>(
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
    required TResult Function(RequestAccountInitial value) initial,
    required TResult Function(RequestAccountLoading value) loading,
    required TResult Function(RequestAccountSuccess value) success,
    required TResult Function(RequestAccountError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountInitial value)? initial,
    TResult? Function(RequestAccountLoading value)? loading,
    TResult? Function(RequestAccountSuccess value)? success,
    TResult? Function(RequestAccountError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountInitial value)? initial,
    TResult Function(RequestAccountLoading value)? loading,
    TResult Function(RequestAccountSuccess value)? success,
    TResult Function(RequestAccountError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RequestAccountError implements RequestAccountState {
  const factory RequestAccountError(final String messageKey) =
      _$RequestAccountErrorImpl;

  String get messageKey;

  /// Create a copy of RequestAccountState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestAccountErrorImplCopyWith<_$RequestAccountErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
