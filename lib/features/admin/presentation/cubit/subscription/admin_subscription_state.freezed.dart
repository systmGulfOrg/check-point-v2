// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_subscription_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminSubscriptionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminSubscriptionStateCopyWith<$Res> {
  factory $AdminSubscriptionStateCopyWith(
    AdminSubscriptionState value,
    $Res Function(AdminSubscriptionState) then,
  ) = _$AdminSubscriptionStateCopyWithImpl<$Res, AdminSubscriptionState>;
}

/// @nodoc
class _$AdminSubscriptionStateCopyWithImpl<
  $Res,
  $Val extends AdminSubscriptionState
>
    implements $AdminSubscriptionStateCopyWith<$Res> {
  _$AdminSubscriptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminSubscriptionInitialImplCopyWith<$Res> {
  factory _$$AdminSubscriptionInitialImplCopyWith(
    _$AdminSubscriptionInitialImpl value,
    $Res Function(_$AdminSubscriptionInitialImpl) then,
  ) = __$$AdminSubscriptionInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminSubscriptionInitialImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<
          $Res,
          _$AdminSubscriptionInitialImpl
        >
    implements _$$AdminSubscriptionInitialImplCopyWith<$Res> {
  __$$AdminSubscriptionInitialImplCopyWithImpl(
    _$AdminSubscriptionInitialImpl _value,
    $Res Function(_$AdminSubscriptionInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminSubscriptionInitialImpl implements AdminSubscriptionInitial {
  const _$AdminSubscriptionInitialImpl();

  @override
  String toString() {
    return 'AdminSubscriptionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
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
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionInitial implements AdminSubscriptionState {
  const factory AdminSubscriptionInitial() = _$AdminSubscriptionInitialImpl;
}

/// @nodoc
abstract class _$$AdminSubscriptionLoadingImplCopyWith<$Res> {
  factory _$$AdminSubscriptionLoadingImplCopyWith(
    _$AdminSubscriptionLoadingImpl value,
    $Res Function(_$AdminSubscriptionLoadingImpl) then,
  ) = __$$AdminSubscriptionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminSubscriptionLoadingImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<
          $Res,
          _$AdminSubscriptionLoadingImpl
        >
    implements _$$AdminSubscriptionLoadingImplCopyWith<$Res> {
  __$$AdminSubscriptionLoadingImplCopyWithImpl(
    _$AdminSubscriptionLoadingImpl _value,
    $Res Function(_$AdminSubscriptionLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminSubscriptionLoadingImpl implements AdminSubscriptionLoading {
  const _$AdminSubscriptionLoadingImpl();

  @override
  String toString() {
    return 'AdminSubscriptionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
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
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionLoading implements AdminSubscriptionState {
  const factory AdminSubscriptionLoading() = _$AdminSubscriptionLoadingImpl;
}

/// @nodoc
abstract class _$$AdminSubscriptionSuccessImplCopyWith<$Res> {
  factory _$$AdminSubscriptionSuccessImplCopyWith(
    _$AdminSubscriptionSuccessImpl value,
    $Res Function(_$AdminSubscriptionSuccessImpl) then,
  ) = __$$AdminSubscriptionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({SubscriptionSummaryModel summary});
}

/// @nodoc
class __$$AdminSubscriptionSuccessImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<
          $Res,
          _$AdminSubscriptionSuccessImpl
        >
    implements _$$AdminSubscriptionSuccessImplCopyWith<$Res> {
  __$$AdminSubscriptionSuccessImplCopyWithImpl(
    _$AdminSubscriptionSuccessImpl _value,
    $Res Function(_$AdminSubscriptionSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? summary = null}) {
    return _then(
      _$AdminSubscriptionSuccessImpl(
        null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as SubscriptionSummaryModel,
      ),
    );
  }
}

/// @nodoc

class _$AdminSubscriptionSuccessImpl implements AdminSubscriptionSuccess {
  const _$AdminSubscriptionSuccessImpl(this.summary);

  @override
  final SubscriptionSummaryModel summary;

  @override
  String toString() {
    return 'AdminSubscriptionState.success(summary: $summary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionSuccessImpl &&
            (identical(other.summary, summary) || other.summary == summary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, summary);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSubscriptionSuccessImplCopyWith<_$AdminSubscriptionSuccessImpl>
  get copyWith =>
      __$$AdminSubscriptionSuccessImplCopyWithImpl<
        _$AdminSubscriptionSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return success(summary);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return success?.call(summary);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(summary);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionSuccess implements AdminSubscriptionState {
  const factory AdminSubscriptionSuccess(
    final SubscriptionSummaryModel summary,
  ) = _$AdminSubscriptionSuccessImpl;

  SubscriptionSummaryModel get summary;

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSubscriptionSuccessImplCopyWith<_$AdminSubscriptionSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminSubscriptionErrorImplCopyWith<$Res> {
  factory _$$AdminSubscriptionErrorImplCopyWith(
    _$AdminSubscriptionErrorImpl value,
    $Res Function(_$AdminSubscriptionErrorImpl) then,
  ) = __$$AdminSubscriptionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AdminSubscriptionErrorImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<$Res, _$AdminSubscriptionErrorImpl>
    implements _$$AdminSubscriptionErrorImplCopyWith<$Res> {
  __$$AdminSubscriptionErrorImplCopyWithImpl(
    _$AdminSubscriptionErrorImpl _value,
    $Res Function(_$AdminSubscriptionErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AdminSubscriptionErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminSubscriptionErrorImpl implements AdminSubscriptionError {
  const _$AdminSubscriptionErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AdminSubscriptionState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSubscriptionErrorImplCopyWith<_$AdminSubscriptionErrorImpl>
  get copyWith =>
      __$$AdminSubscriptionErrorImplCopyWithImpl<_$AdminSubscriptionErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
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
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionError implements AdminSubscriptionState {
  const factory AdminSubscriptionError(final String messageKey) =
      _$AdminSubscriptionErrorImpl;

  String get messageKey;

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSubscriptionErrorImplCopyWith<_$AdminSubscriptionErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminSubscriptionRequestSentImplCopyWith<$Res> {
  factory _$$AdminSubscriptionRequestSentImplCopyWith(
    _$AdminSubscriptionRequestSentImpl value,
    $Res Function(_$AdminSubscriptionRequestSentImpl) then,
  ) = __$$AdminSubscriptionRequestSentImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminSubscriptionRequestSentImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<
          $Res,
          _$AdminSubscriptionRequestSentImpl
        >
    implements _$$AdminSubscriptionRequestSentImplCopyWith<$Res> {
  __$$AdminSubscriptionRequestSentImplCopyWithImpl(
    _$AdminSubscriptionRequestSentImpl _value,
    $Res Function(_$AdminSubscriptionRequestSentImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminSubscriptionRequestSentImpl
    implements AdminSubscriptionRequestSent {
  const _$AdminSubscriptionRequestSentImpl();

  @override
  String toString() {
    return 'AdminSubscriptionState.requestSent()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionRequestSentImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return requestSent();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return requestSent?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
    required TResult orElse(),
  }) {
    if (requestSent != null) {
      return requestSent();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return requestSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return requestSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (requestSent != null) {
      return requestSent(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionRequestSent implements AdminSubscriptionState {
  const factory AdminSubscriptionRequestSent() =
      _$AdminSubscriptionRequestSentImpl;
}

/// @nodoc
abstract class _$$AdminSubscriptionRequestFailedImplCopyWith<$Res> {
  factory _$$AdminSubscriptionRequestFailedImplCopyWith(
    _$AdminSubscriptionRequestFailedImpl value,
    $Res Function(_$AdminSubscriptionRequestFailedImpl) then,
  ) = __$$AdminSubscriptionRequestFailedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AdminSubscriptionRequestFailedImplCopyWithImpl<$Res>
    extends
        _$AdminSubscriptionStateCopyWithImpl<
          $Res,
          _$AdminSubscriptionRequestFailedImpl
        >
    implements _$$AdminSubscriptionRequestFailedImplCopyWith<$Res> {
  __$$AdminSubscriptionRequestFailedImplCopyWithImpl(
    _$AdminSubscriptionRequestFailedImpl _value,
    $Res Function(_$AdminSubscriptionRequestFailedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AdminSubscriptionRequestFailedImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminSubscriptionRequestFailedImpl
    implements AdminSubscriptionRequestFailed {
  const _$AdminSubscriptionRequestFailedImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AdminSubscriptionState.requestFailed(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminSubscriptionRequestFailedImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminSubscriptionRequestFailedImplCopyWith<
    _$AdminSubscriptionRequestFailedImpl
  >
  get copyWith =>
      __$$AdminSubscriptionRequestFailedImplCopyWithImpl<
        _$AdminSubscriptionRequestFailedImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(SubscriptionSummaryModel summary) success,
    required TResult Function(String messageKey) error,
    required TResult Function() requestSent,
    required TResult Function(String messageKey) requestFailed,
  }) {
    return requestFailed(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(SubscriptionSummaryModel summary)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? requestSent,
    TResult? Function(String messageKey)? requestFailed,
  }) {
    return requestFailed?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(SubscriptionSummaryModel summary)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? requestSent,
    TResult Function(String messageKey)? requestFailed,
    required TResult orElse(),
  }) {
    if (requestFailed != null) {
      return requestFailed(messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminSubscriptionInitial value) initial,
    required TResult Function(AdminSubscriptionLoading value) loading,
    required TResult Function(AdminSubscriptionSuccess value) success,
    required TResult Function(AdminSubscriptionError value) error,
    required TResult Function(AdminSubscriptionRequestSent value) requestSent,
    required TResult Function(AdminSubscriptionRequestFailed value)
    requestFailed,
  }) {
    return requestFailed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminSubscriptionInitial value)? initial,
    TResult? Function(AdminSubscriptionLoading value)? loading,
    TResult? Function(AdminSubscriptionSuccess value)? success,
    TResult? Function(AdminSubscriptionError value)? error,
    TResult? Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult? Function(AdminSubscriptionRequestFailed value)? requestFailed,
  }) {
    return requestFailed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminSubscriptionInitial value)? initial,
    TResult Function(AdminSubscriptionLoading value)? loading,
    TResult Function(AdminSubscriptionSuccess value)? success,
    TResult Function(AdminSubscriptionError value)? error,
    TResult Function(AdminSubscriptionRequestSent value)? requestSent,
    TResult Function(AdminSubscriptionRequestFailed value)? requestFailed,
    required TResult orElse(),
  }) {
    if (requestFailed != null) {
      return requestFailed(this);
    }
    return orElse();
  }
}

abstract class AdminSubscriptionRequestFailed
    implements AdminSubscriptionState {
  const factory AdminSubscriptionRequestFailed(final String messageKey) =
      _$AdminSubscriptionRequestFailedImpl;

  String get messageKey;

  /// Create a copy of AdminSubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminSubscriptionRequestFailedImplCopyWith<
    _$AdminSubscriptionRequestFailedImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
