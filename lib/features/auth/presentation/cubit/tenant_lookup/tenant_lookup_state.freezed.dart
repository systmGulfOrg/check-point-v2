// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_lookup_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$TenantLookupState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String tenantSlug) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String tenantSlug)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String tenantSlug)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TenantLookupInitial value) initial,
    required TResult Function(TenantLookupLoading value) loading,
    required TResult Function(TenantLookupSuccess value) success,
    required TResult Function(TenantLookupError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TenantLookupInitial value)? initial,
    TResult? Function(TenantLookupLoading value)? loading,
    TResult? Function(TenantLookupSuccess value)? success,
    TResult? Function(TenantLookupError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TenantLookupInitial value)? initial,
    TResult Function(TenantLookupLoading value)? loading,
    TResult Function(TenantLookupSuccess value)? success,
    TResult Function(TenantLookupError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TenantLookupStateCopyWith<$Res> {
  factory $TenantLookupStateCopyWith(
    TenantLookupState value,
    $Res Function(TenantLookupState) then,
  ) = _$TenantLookupStateCopyWithImpl<$Res, TenantLookupState>;
}

/// @nodoc
class _$TenantLookupStateCopyWithImpl<$Res, $Val extends TenantLookupState>
    implements $TenantLookupStateCopyWith<$Res> {
  _$TenantLookupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$TenantLookupInitialImplCopyWith<$Res> {
  factory _$$TenantLookupInitialImplCopyWith(
    _$TenantLookupInitialImpl value,
    $Res Function(_$TenantLookupInitialImpl) then,
  ) = __$$TenantLookupInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TenantLookupInitialImplCopyWithImpl<$Res>
    extends _$TenantLookupStateCopyWithImpl<$Res, _$TenantLookupInitialImpl>
    implements _$$TenantLookupInitialImplCopyWith<$Res> {
  __$$TenantLookupInitialImplCopyWithImpl(
    _$TenantLookupInitialImpl _value,
    $Res Function(_$TenantLookupInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TenantLookupInitialImpl implements TenantLookupInitial {
  const _$TenantLookupInitialImpl();

  @override
  String toString() {
    return 'TenantLookupState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantLookupInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String tenantSlug) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String tenantSlug)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String tenantSlug)? success,
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
    required TResult Function(TenantLookupInitial value) initial,
    required TResult Function(TenantLookupLoading value) loading,
    required TResult Function(TenantLookupSuccess value) success,
    required TResult Function(TenantLookupError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TenantLookupInitial value)? initial,
    TResult? Function(TenantLookupLoading value)? loading,
    TResult? Function(TenantLookupSuccess value)? success,
    TResult? Function(TenantLookupError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TenantLookupInitial value)? initial,
    TResult Function(TenantLookupLoading value)? loading,
    TResult Function(TenantLookupSuccess value)? success,
    TResult Function(TenantLookupError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class TenantLookupInitial implements TenantLookupState {
  const factory TenantLookupInitial() = _$TenantLookupInitialImpl;
}

/// @nodoc
abstract class _$$TenantLookupLoadingImplCopyWith<$Res> {
  factory _$$TenantLookupLoadingImplCopyWith(
    _$TenantLookupLoadingImpl value,
    $Res Function(_$TenantLookupLoadingImpl) then,
  ) = __$$TenantLookupLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$TenantLookupLoadingImplCopyWithImpl<$Res>
    extends _$TenantLookupStateCopyWithImpl<$Res, _$TenantLookupLoadingImpl>
    implements _$$TenantLookupLoadingImplCopyWith<$Res> {
  __$$TenantLookupLoadingImplCopyWithImpl(
    _$TenantLookupLoadingImpl _value,
    $Res Function(_$TenantLookupLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$TenantLookupLoadingImpl implements TenantLookupLoading {
  const _$TenantLookupLoadingImpl();

  @override
  String toString() {
    return 'TenantLookupState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantLookupLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String tenantSlug) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String tenantSlug)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String tenantSlug)? success,
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
    required TResult Function(TenantLookupInitial value) initial,
    required TResult Function(TenantLookupLoading value) loading,
    required TResult Function(TenantLookupSuccess value) success,
    required TResult Function(TenantLookupError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TenantLookupInitial value)? initial,
    TResult? Function(TenantLookupLoading value)? loading,
    TResult? Function(TenantLookupSuccess value)? success,
    TResult? Function(TenantLookupError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TenantLookupInitial value)? initial,
    TResult Function(TenantLookupLoading value)? loading,
    TResult Function(TenantLookupSuccess value)? success,
    TResult Function(TenantLookupError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class TenantLookupLoading implements TenantLookupState {
  const factory TenantLookupLoading() = _$TenantLookupLoadingImpl;
}

/// @nodoc
abstract class _$$TenantLookupSuccessImplCopyWith<$Res> {
  factory _$$TenantLookupSuccessImplCopyWith(
    _$TenantLookupSuccessImpl value,
    $Res Function(_$TenantLookupSuccessImpl) then,
  ) = __$$TenantLookupSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String tenantSlug});
}

/// @nodoc
class __$$TenantLookupSuccessImplCopyWithImpl<$Res>
    extends _$TenantLookupStateCopyWithImpl<$Res, _$TenantLookupSuccessImpl>
    implements _$$TenantLookupSuccessImplCopyWith<$Res> {
  __$$TenantLookupSuccessImplCopyWithImpl(
    _$TenantLookupSuccessImpl _value,
    $Res Function(_$TenantLookupSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? tenantSlug = null}) {
    return _then(
      _$TenantLookupSuccessImpl(
        null == tenantSlug
            ? _value.tenantSlug
            : tenantSlug // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TenantLookupSuccessImpl implements TenantLookupSuccess {
  const _$TenantLookupSuccessImpl(this.tenantSlug);

  @override
  final String tenantSlug;

  @override
  String toString() {
    return 'TenantLookupState.success(tenantSlug: $tenantSlug)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantLookupSuccessImpl &&
            (identical(other.tenantSlug, tenantSlug) ||
                other.tenantSlug == tenantSlug));
  }

  @override
  int get hashCode => Object.hash(runtimeType, tenantSlug);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantLookupSuccessImplCopyWith<_$TenantLookupSuccessImpl> get copyWith =>
      __$$TenantLookupSuccessImplCopyWithImpl<_$TenantLookupSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String tenantSlug) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(tenantSlug);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String tenantSlug)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(tenantSlug);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String tenantSlug)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(tenantSlug);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TenantLookupInitial value) initial,
    required TResult Function(TenantLookupLoading value) loading,
    required TResult Function(TenantLookupSuccess value) success,
    required TResult Function(TenantLookupError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TenantLookupInitial value)? initial,
    TResult? Function(TenantLookupLoading value)? loading,
    TResult? Function(TenantLookupSuccess value)? success,
    TResult? Function(TenantLookupError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TenantLookupInitial value)? initial,
    TResult Function(TenantLookupLoading value)? loading,
    TResult Function(TenantLookupSuccess value)? success,
    TResult Function(TenantLookupError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class TenantLookupSuccess implements TenantLookupState {
  const factory TenantLookupSuccess(final String tenantSlug) =
      _$TenantLookupSuccessImpl;

  String get tenantSlug;

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantLookupSuccessImplCopyWith<_$TenantLookupSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TenantLookupErrorImplCopyWith<$Res> {
  factory _$$TenantLookupErrorImplCopyWith(
    _$TenantLookupErrorImpl value,
    $Res Function(_$TenantLookupErrorImpl) then,
  ) = __$$TenantLookupErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$TenantLookupErrorImplCopyWithImpl<$Res>
    extends _$TenantLookupStateCopyWithImpl<$Res, _$TenantLookupErrorImpl>
    implements _$$TenantLookupErrorImplCopyWith<$Res> {
  __$$TenantLookupErrorImplCopyWithImpl(
    _$TenantLookupErrorImpl _value,
    $Res Function(_$TenantLookupErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$TenantLookupErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$TenantLookupErrorImpl implements TenantLookupError {
  const _$TenantLookupErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'TenantLookupState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TenantLookupErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TenantLookupErrorImplCopyWith<_$TenantLookupErrorImpl> get copyWith =>
      __$$TenantLookupErrorImplCopyWithImpl<_$TenantLookupErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String tenantSlug) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String tenantSlug)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String tenantSlug)? success,
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
    required TResult Function(TenantLookupInitial value) initial,
    required TResult Function(TenantLookupLoading value) loading,
    required TResult Function(TenantLookupSuccess value) success,
    required TResult Function(TenantLookupError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TenantLookupInitial value)? initial,
    TResult? Function(TenantLookupLoading value)? loading,
    TResult? Function(TenantLookupSuccess value)? success,
    TResult? Function(TenantLookupError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TenantLookupInitial value)? initial,
    TResult Function(TenantLookupLoading value)? loading,
    TResult Function(TenantLookupSuccess value)? success,
    TResult Function(TenantLookupError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class TenantLookupError implements TenantLookupState {
  const factory TenantLookupError(final String messageKey) =
      _$TenantLookupErrorImpl;

  String get messageKey;

  /// Create a copy of TenantLookupState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TenantLookupErrorImplCopyWith<_$TenantLookupErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
