// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exchange_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ExchangeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PointsExchangeResultModel result) success,
    required TResult Function(String message) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PointsExchangeResultModel result)? success,
    TResult? Function(String message)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PointsExchangeResultModel result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExchangeInitial value) initial,
    required TResult Function(ExchangeLoading value) loading,
    required TResult Function(ExchangeSuccess value) success,
    required TResult Function(ExchangeError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExchangeInitial value)? initial,
    TResult? Function(ExchangeLoading value)? loading,
    TResult? Function(ExchangeSuccess value)? success,
    TResult? Function(ExchangeError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExchangeInitial value)? initial,
    TResult Function(ExchangeLoading value)? loading,
    TResult Function(ExchangeSuccess value)? success,
    TResult Function(ExchangeError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExchangeStateCopyWith<$Res> {
  factory $ExchangeStateCopyWith(
    ExchangeState value,
    $Res Function(ExchangeState) then,
  ) = _$ExchangeStateCopyWithImpl<$Res, ExchangeState>;
}

/// @nodoc
class _$ExchangeStateCopyWithImpl<$Res, $Val extends ExchangeState>
    implements $ExchangeStateCopyWith<$Res> {
  _$ExchangeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ExchangeInitialImplCopyWith<$Res> {
  factory _$$ExchangeInitialImplCopyWith(
    _$ExchangeInitialImpl value,
    $Res Function(_$ExchangeInitialImpl) then,
  ) = __$$ExchangeInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExchangeInitialImplCopyWithImpl<$Res>
    extends _$ExchangeStateCopyWithImpl<$Res, _$ExchangeInitialImpl>
    implements _$$ExchangeInitialImplCopyWith<$Res> {
  __$$ExchangeInitialImplCopyWithImpl(
    _$ExchangeInitialImpl _value,
    $Res Function(_$ExchangeInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExchangeInitialImpl implements ExchangeInitial {
  const _$ExchangeInitialImpl();

  @override
  String toString() {
    return 'ExchangeState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExchangeInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PointsExchangeResultModel result) success,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PointsExchangeResultModel result)? success,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PointsExchangeResultModel result)? success,
    TResult Function(String message)? error,
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
    required TResult Function(ExchangeInitial value) initial,
    required TResult Function(ExchangeLoading value) loading,
    required TResult Function(ExchangeSuccess value) success,
    required TResult Function(ExchangeError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExchangeInitial value)? initial,
    TResult? Function(ExchangeLoading value)? loading,
    TResult? Function(ExchangeSuccess value)? success,
    TResult? Function(ExchangeError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExchangeInitial value)? initial,
    TResult Function(ExchangeLoading value)? loading,
    TResult Function(ExchangeSuccess value)? success,
    TResult Function(ExchangeError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ExchangeInitial implements ExchangeState {
  const factory ExchangeInitial() = _$ExchangeInitialImpl;
}

/// @nodoc
abstract class _$$ExchangeLoadingImplCopyWith<$Res> {
  factory _$$ExchangeLoadingImplCopyWith(
    _$ExchangeLoadingImpl value,
    $Res Function(_$ExchangeLoadingImpl) then,
  ) = __$$ExchangeLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ExchangeLoadingImplCopyWithImpl<$Res>
    extends _$ExchangeStateCopyWithImpl<$Res, _$ExchangeLoadingImpl>
    implements _$$ExchangeLoadingImplCopyWith<$Res> {
  __$$ExchangeLoadingImplCopyWithImpl(
    _$ExchangeLoadingImpl _value,
    $Res Function(_$ExchangeLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ExchangeLoadingImpl implements ExchangeLoading {
  const _$ExchangeLoadingImpl();

  @override
  String toString() {
    return 'ExchangeState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ExchangeLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PointsExchangeResultModel result) success,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PointsExchangeResultModel result)? success,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PointsExchangeResultModel result)? success,
    TResult Function(String message)? error,
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
    required TResult Function(ExchangeInitial value) initial,
    required TResult Function(ExchangeLoading value) loading,
    required TResult Function(ExchangeSuccess value) success,
    required TResult Function(ExchangeError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExchangeInitial value)? initial,
    TResult? Function(ExchangeLoading value)? loading,
    TResult? Function(ExchangeSuccess value)? success,
    TResult? Function(ExchangeError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExchangeInitial value)? initial,
    TResult Function(ExchangeLoading value)? loading,
    TResult Function(ExchangeSuccess value)? success,
    TResult Function(ExchangeError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ExchangeLoading implements ExchangeState {
  const factory ExchangeLoading() = _$ExchangeLoadingImpl;
}

/// @nodoc
abstract class _$$ExchangeSuccessImplCopyWith<$Res> {
  factory _$$ExchangeSuccessImplCopyWith(
    _$ExchangeSuccessImpl value,
    $Res Function(_$ExchangeSuccessImpl) then,
  ) = __$$ExchangeSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PointsExchangeResultModel result});

  $PointsExchangeResultModelCopyWith<$Res> get result;
}

/// @nodoc
class __$$ExchangeSuccessImplCopyWithImpl<$Res>
    extends _$ExchangeStateCopyWithImpl<$Res, _$ExchangeSuccessImpl>
    implements _$$ExchangeSuccessImplCopyWith<$Res> {
  __$$ExchangeSuccessImplCopyWithImpl(
    _$ExchangeSuccessImpl _value,
    $Res Function(_$ExchangeSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? result = null}) {
    return _then(
      _$ExchangeSuccessImpl(
        null == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as PointsExchangeResultModel,
      ),
    );
  }

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PointsExchangeResultModelCopyWith<$Res> get result {
    return $PointsExchangeResultModelCopyWith<$Res>(_value.result, (value) {
      return _then(_value.copyWith(result: value));
    });
  }
}

/// @nodoc

class _$ExchangeSuccessImpl implements ExchangeSuccess {
  const _$ExchangeSuccessImpl(this.result);

  @override
  final PointsExchangeResultModel result;

  @override
  String toString() {
    return 'ExchangeState.success(result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExchangeSuccessImpl &&
            (identical(other.result, result) || other.result == result));
  }

  @override
  int get hashCode => Object.hash(runtimeType, result);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExchangeSuccessImplCopyWith<_$ExchangeSuccessImpl> get copyWith =>
      __$$ExchangeSuccessImplCopyWithImpl<_$ExchangeSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PointsExchangeResultModel result) success,
    required TResult Function(String message) error,
  }) {
    return success(result);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PointsExchangeResultModel result)? success,
    TResult? Function(String message)? error,
  }) {
    return success?.call(result);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PointsExchangeResultModel result)? success,
    TResult Function(String message)? error,
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
    required TResult Function(ExchangeInitial value) initial,
    required TResult Function(ExchangeLoading value) loading,
    required TResult Function(ExchangeSuccess value) success,
    required TResult Function(ExchangeError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExchangeInitial value)? initial,
    TResult? Function(ExchangeLoading value)? loading,
    TResult? Function(ExchangeSuccess value)? success,
    TResult? Function(ExchangeError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExchangeInitial value)? initial,
    TResult Function(ExchangeLoading value)? loading,
    TResult Function(ExchangeSuccess value)? success,
    TResult Function(ExchangeError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class ExchangeSuccess implements ExchangeState {
  const factory ExchangeSuccess(final PointsExchangeResultModel result) =
      _$ExchangeSuccessImpl;

  PointsExchangeResultModel get result;

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExchangeSuccessImplCopyWith<_$ExchangeSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ExchangeErrorImplCopyWith<$Res> {
  factory _$$ExchangeErrorImplCopyWith(
    _$ExchangeErrorImpl value,
    $Res Function(_$ExchangeErrorImpl) then,
  ) = __$$ExchangeErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ExchangeErrorImplCopyWithImpl<$Res>
    extends _$ExchangeStateCopyWithImpl<$Res, _$ExchangeErrorImpl>
    implements _$$ExchangeErrorImplCopyWith<$Res> {
  __$$ExchangeErrorImplCopyWithImpl(
    _$ExchangeErrorImpl _value,
    $Res Function(_$ExchangeErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$ExchangeErrorImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$ExchangeErrorImpl implements ExchangeError {
  const _$ExchangeErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ExchangeState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExchangeErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExchangeErrorImplCopyWith<_$ExchangeErrorImpl> get copyWith =>
      __$$ExchangeErrorImplCopyWithImpl<_$ExchangeErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(PointsExchangeResultModel result) success,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(PointsExchangeResultModel result)? success,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(PointsExchangeResultModel result)? success,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ExchangeInitial value) initial,
    required TResult Function(ExchangeLoading value) loading,
    required TResult Function(ExchangeSuccess value) success,
    required TResult Function(ExchangeError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ExchangeInitial value)? initial,
    TResult? Function(ExchangeLoading value)? loading,
    TResult? Function(ExchangeSuccess value)? success,
    TResult? Function(ExchangeError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ExchangeInitial value)? initial,
    TResult Function(ExchangeLoading value)? loading,
    TResult Function(ExchangeSuccess value)? success,
    TResult Function(ExchangeError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ExchangeError implements ExchangeState {
  const factory ExchangeError(final String message) = _$ExchangeErrorImpl;

  String get message;

  /// Create a copy of ExchangeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExchangeErrorImplCopyWith<_$ExchangeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
