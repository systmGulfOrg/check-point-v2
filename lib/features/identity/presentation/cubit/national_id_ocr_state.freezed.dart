// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'national_id_ocr_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NationalIdOcrState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NationalIdOcrStateCopyWith<$Res> {
  factory $NationalIdOcrStateCopyWith(
    NationalIdOcrState value,
    $Res Function(NationalIdOcrState) then,
  ) = _$NationalIdOcrStateCopyWithImpl<$Res, NationalIdOcrState>;
}

/// @nodoc
class _$NationalIdOcrStateCopyWithImpl<$Res, $Val extends NationalIdOcrState>
    implements $NationalIdOcrStateCopyWith<$Res> {
  _$NationalIdOcrStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NationalIdOcrInitialImplCopyWith<$Res> {
  factory _$$NationalIdOcrInitialImplCopyWith(
    _$NationalIdOcrInitialImpl value,
    $Res Function(_$NationalIdOcrInitialImpl) then,
  ) = __$$NationalIdOcrInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NationalIdOcrInitialImplCopyWithImpl<$Res>
    extends _$NationalIdOcrStateCopyWithImpl<$Res, _$NationalIdOcrInitialImpl>
    implements _$$NationalIdOcrInitialImplCopyWith<$Res> {
  __$$NationalIdOcrInitialImplCopyWithImpl(
    _$NationalIdOcrInitialImpl _value,
    $Res Function(_$NationalIdOcrInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NationalIdOcrInitialImpl implements NationalIdOcrInitial {
  const _$NationalIdOcrInitialImpl();

  @override
  String toString() {
    return 'NationalIdOcrState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NationalIdOcrInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
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
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NationalIdOcrInitial implements NationalIdOcrState {
  const factory NationalIdOcrInitial() = _$NationalIdOcrInitialImpl;
}

/// @nodoc
abstract class _$$NationalIdOcrLoadingImplCopyWith<$Res> {
  factory _$$NationalIdOcrLoadingImplCopyWith(
    _$NationalIdOcrLoadingImpl value,
    $Res Function(_$NationalIdOcrLoadingImpl) then,
  ) = __$$NationalIdOcrLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NationalIdOcrLoadingImplCopyWithImpl<$Res>
    extends _$NationalIdOcrStateCopyWithImpl<$Res, _$NationalIdOcrLoadingImpl>
    implements _$$NationalIdOcrLoadingImplCopyWith<$Res> {
  __$$NationalIdOcrLoadingImplCopyWithImpl(
    _$NationalIdOcrLoadingImpl _value,
    $Res Function(_$NationalIdOcrLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NationalIdOcrLoadingImpl implements NationalIdOcrLoading {
  const _$NationalIdOcrLoadingImpl();

  @override
  String toString() {
    return 'NationalIdOcrState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NationalIdOcrLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
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
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NationalIdOcrLoading implements NationalIdOcrState {
  const factory NationalIdOcrLoading() = _$NationalIdOcrLoadingImpl;
}

/// @nodoc
abstract class _$$NationalIdOcrSuccessImplCopyWith<$Res> {
  factory _$$NationalIdOcrSuccessImplCopyWith(
    _$NationalIdOcrSuccessImpl value,
    $Res Function(_$NationalIdOcrSuccessImpl) then,
  ) = __$$NationalIdOcrSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NationalIdScanResult result});
}

/// @nodoc
class __$$NationalIdOcrSuccessImplCopyWithImpl<$Res>
    extends _$NationalIdOcrStateCopyWithImpl<$Res, _$NationalIdOcrSuccessImpl>
    implements _$$NationalIdOcrSuccessImplCopyWith<$Res> {
  __$$NationalIdOcrSuccessImplCopyWithImpl(
    _$NationalIdOcrSuccessImpl _value,
    $Res Function(_$NationalIdOcrSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$NationalIdOcrSuccessImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as NationalIdScanResult,
      ),
    );
  }
}

/// @nodoc

class _$NationalIdOcrSuccessImpl implements NationalIdOcrSuccess {
  const _$NationalIdOcrSuccessImpl(this.result);

  @override
  final NationalIdScanResult result;

  @override
  String toString() {
    return 'NationalIdOcrState.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NationalIdOcrSuccessImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NationalIdOcrSuccessImplCopyWith<_$NationalIdOcrSuccessImpl>
  get copyWith =>
      __$$NationalIdOcrSuccessImplCopyWithImpl<_$NationalIdOcrSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) {
    return success(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(result);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class NationalIdOcrSuccess implements NationalIdOcrState {
  const factory NationalIdOcrSuccess(final NationalIdScanResult result) =
      _$NationalIdOcrSuccessImpl;

  NationalIdScanResult get result;

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NationalIdOcrSuccessImplCopyWith<_$NationalIdOcrSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NationalIdOcrEmptyImplCopyWith<$Res> {
  factory _$$NationalIdOcrEmptyImplCopyWith(
    _$NationalIdOcrEmptyImpl value,
    $Res Function(_$NationalIdOcrEmptyImpl) then,
  ) = __$$NationalIdOcrEmptyImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NationalIdOcrEmptyImplCopyWithImpl<$Res>
    extends _$NationalIdOcrStateCopyWithImpl<$Res, _$NationalIdOcrEmptyImpl>
    implements _$$NationalIdOcrEmptyImplCopyWith<$Res> {
  __$$NationalIdOcrEmptyImplCopyWithImpl(
    _$NationalIdOcrEmptyImpl _value,
    $Res Function(_$NationalIdOcrEmptyImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NationalIdOcrEmptyImpl implements NationalIdOcrEmpty {
  const _$NationalIdOcrEmptyImpl();

  @override
  String toString() {
    return 'NationalIdOcrState.empty()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NationalIdOcrEmptyImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) {
    return empty();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) {
    return empty?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) {
    return empty(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) {
    return empty?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) {
    if (empty != null) {
      return empty(this);
    }
    return orElse();
  }
}

abstract class NationalIdOcrEmpty implements NationalIdOcrState {
  const factory NationalIdOcrEmpty() = _$NationalIdOcrEmptyImpl;
}

/// @nodoc
abstract class _$$NationalIdOcrErrorImplCopyWith<$Res> {
  factory _$$NationalIdOcrErrorImplCopyWith(
    _$NationalIdOcrErrorImpl value,
    $Res Function(_$NationalIdOcrErrorImpl) then,
  ) = __$$NationalIdOcrErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$NationalIdOcrErrorImplCopyWithImpl<$Res>
    extends _$NationalIdOcrStateCopyWithImpl<$Res, _$NationalIdOcrErrorImpl>
    implements _$$NationalIdOcrErrorImplCopyWith<$Res> {
  __$$NationalIdOcrErrorImplCopyWithImpl(
    _$NationalIdOcrErrorImpl _value,
    $Res Function(_$NationalIdOcrErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$NationalIdOcrErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NationalIdOcrErrorImpl implements NationalIdOcrError {
  const _$NationalIdOcrErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'NationalIdOcrState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NationalIdOcrErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NationalIdOcrErrorImplCopyWith<_$NationalIdOcrErrorImpl> get copyWith =>
      __$$NationalIdOcrErrorImplCopyWithImpl<_$NationalIdOcrErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(NationalIdScanResult result) success,
    required TResult Function() empty,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(NationalIdScanResult result)? success,
    TResult? Function()? empty,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(NationalIdScanResult result)? success,
    TResult Function()? empty,
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
    required TResult Function(NationalIdOcrInitial value) initial,
    required TResult Function(NationalIdOcrLoading value) loading,
    required TResult Function(NationalIdOcrSuccess value) success,
    required TResult Function(NationalIdOcrEmpty value) empty,
    required TResult Function(NationalIdOcrError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NationalIdOcrInitial value)? initial,
    TResult? Function(NationalIdOcrLoading value)? loading,
    TResult? Function(NationalIdOcrSuccess value)? success,
    TResult? Function(NationalIdOcrEmpty value)? empty,
    TResult? Function(NationalIdOcrError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NationalIdOcrInitial value)? initial,
    TResult Function(NationalIdOcrLoading value)? loading,
    TResult Function(NationalIdOcrSuccess value)? success,
    TResult Function(NationalIdOcrEmpty value)? empty,
    TResult Function(NationalIdOcrError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NationalIdOcrError implements NationalIdOcrState {
  const factory NationalIdOcrError(final String messageKey) =
      _$NationalIdOcrErrorImpl;

  String get messageKey;

  /// Create a copy of NationalIdOcrState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NationalIdOcrErrorImplCopyWith<_$NationalIdOcrErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
