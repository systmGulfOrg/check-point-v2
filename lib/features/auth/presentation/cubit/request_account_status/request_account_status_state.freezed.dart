// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'request_account_status_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$RequestAccountStatusState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AccountRequestStatusModel? request) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AccountRequestStatusModel? request)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AccountRequestStatusModel? request)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestAccountStatusInitial value) initial,
    required TResult Function(RequestAccountStatusLoading value) loading,
    required TResult Function(RequestAccountStatusSuccess value) success,
    required TResult Function(RequestAccountStatusError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountStatusInitial value)? initial,
    TResult? Function(RequestAccountStatusLoading value)? loading,
    TResult? Function(RequestAccountStatusSuccess value)? success,
    TResult? Function(RequestAccountStatusError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountStatusInitial value)? initial,
    TResult Function(RequestAccountStatusLoading value)? loading,
    TResult Function(RequestAccountStatusSuccess value)? success,
    TResult Function(RequestAccountStatusError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestAccountStatusStateCopyWith<$Res> {
  factory $RequestAccountStatusStateCopyWith(
    RequestAccountStatusState value,
    $Res Function(RequestAccountStatusState) then,
  ) = _$RequestAccountStatusStateCopyWithImpl<$Res, RequestAccountStatusState>;
}

/// @nodoc
class _$RequestAccountStatusStateCopyWithImpl<
  $Res,
  $Val extends RequestAccountStatusState
>
    implements $RequestAccountStatusStateCopyWith<$Res> {
  _$RequestAccountStatusStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$RequestAccountStatusInitialImplCopyWith<$Res> {
  factory _$$RequestAccountStatusInitialImplCopyWith(
    _$RequestAccountStatusInitialImpl value,
    $Res Function(_$RequestAccountStatusInitialImpl) then,
  ) = __$$RequestAccountStatusInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestAccountStatusInitialImplCopyWithImpl<$Res>
    extends
        _$RequestAccountStatusStateCopyWithImpl<
          $Res,
          _$RequestAccountStatusInitialImpl
        >
    implements _$$RequestAccountStatusInitialImplCopyWith<$Res> {
  __$$RequestAccountStatusInitialImplCopyWithImpl(
    _$RequestAccountStatusInitialImpl _value,
    $Res Function(_$RequestAccountStatusInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestAccountStatusInitialImpl implements RequestAccountStatusInitial {
  const _$RequestAccountStatusInitialImpl();

  @override
  String toString() {
    return 'RequestAccountStatusState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountStatusInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AccountRequestStatusModel? request) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AccountRequestStatusModel? request)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AccountRequestStatusModel? request)? success,
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
    required TResult Function(RequestAccountStatusInitial value) initial,
    required TResult Function(RequestAccountStatusLoading value) loading,
    required TResult Function(RequestAccountStatusSuccess value) success,
    required TResult Function(RequestAccountStatusError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountStatusInitial value)? initial,
    TResult? Function(RequestAccountStatusLoading value)? loading,
    TResult? Function(RequestAccountStatusSuccess value)? success,
    TResult? Function(RequestAccountStatusError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountStatusInitial value)? initial,
    TResult Function(RequestAccountStatusLoading value)? loading,
    TResult Function(RequestAccountStatusSuccess value)? success,
    TResult Function(RequestAccountStatusError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RequestAccountStatusInitial
    implements RequestAccountStatusState {
  const factory RequestAccountStatusInitial() =
      _$RequestAccountStatusInitialImpl;
}

/// @nodoc
abstract class _$$RequestAccountStatusLoadingImplCopyWith<$Res> {
  factory _$$RequestAccountStatusLoadingImplCopyWith(
    _$RequestAccountStatusLoadingImpl value,
    $Res Function(_$RequestAccountStatusLoadingImpl) then,
  ) = __$$RequestAccountStatusLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RequestAccountStatusLoadingImplCopyWithImpl<$Res>
    extends
        _$RequestAccountStatusStateCopyWithImpl<
          $Res,
          _$RequestAccountStatusLoadingImpl
        >
    implements _$$RequestAccountStatusLoadingImplCopyWith<$Res> {
  __$$RequestAccountStatusLoadingImplCopyWithImpl(
    _$RequestAccountStatusLoadingImpl _value,
    $Res Function(_$RequestAccountStatusLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RequestAccountStatusLoadingImpl implements RequestAccountStatusLoading {
  const _$RequestAccountStatusLoadingImpl();

  @override
  String toString() {
    return 'RequestAccountStatusState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountStatusLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AccountRequestStatusModel? request) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AccountRequestStatusModel? request)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AccountRequestStatusModel? request)? success,
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
    required TResult Function(RequestAccountStatusInitial value) initial,
    required TResult Function(RequestAccountStatusLoading value) loading,
    required TResult Function(RequestAccountStatusSuccess value) success,
    required TResult Function(RequestAccountStatusError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountStatusInitial value)? initial,
    TResult? Function(RequestAccountStatusLoading value)? loading,
    TResult? Function(RequestAccountStatusSuccess value)? success,
    TResult? Function(RequestAccountStatusError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountStatusInitial value)? initial,
    TResult Function(RequestAccountStatusLoading value)? loading,
    TResult Function(RequestAccountStatusSuccess value)? success,
    TResult Function(RequestAccountStatusError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RequestAccountStatusLoading
    implements RequestAccountStatusState {
  const factory RequestAccountStatusLoading() =
      _$RequestAccountStatusLoadingImpl;
}

/// @nodoc
abstract class _$$RequestAccountStatusSuccessImplCopyWith<$Res> {
  factory _$$RequestAccountStatusSuccessImplCopyWith(
    _$RequestAccountStatusSuccessImpl value,
    $Res Function(_$RequestAccountStatusSuccessImpl) then,
  ) = __$$RequestAccountStatusSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AccountRequestStatusModel? request});
}

/// @nodoc
class __$$RequestAccountStatusSuccessImplCopyWithImpl<$Res>
    extends
        _$RequestAccountStatusStateCopyWithImpl<
          $Res,
          _$RequestAccountStatusSuccessImpl
        >
    implements _$$RequestAccountStatusSuccessImplCopyWith<$Res> {
  __$$RequestAccountStatusSuccessImplCopyWithImpl(
    _$RequestAccountStatusSuccessImpl _value,
    $Res Function(_$RequestAccountStatusSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? request = freezed}) {
    return _then(
      _$RequestAccountStatusSuccessImpl(
        freezed == request
            ? _value.request
            : request // ignore: cast_nullable_to_non_nullable
                  as AccountRequestStatusModel?,
      ),
    );
  }
}

/// @nodoc

class _$RequestAccountStatusSuccessImpl implements RequestAccountStatusSuccess {
  const _$RequestAccountStatusSuccessImpl(this.request);

  @override
  final AccountRequestStatusModel? request;

  @override
  String toString() {
    return 'RequestAccountStatusState.success(request: $request)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountStatusSuccessImpl &&
            (identical(other.request, request) || other.request == request));
  }

  @override
  int get hashCode => Object.hash(runtimeType, request);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestAccountStatusSuccessImplCopyWith<_$RequestAccountStatusSuccessImpl>
  get copyWith =>
      __$$RequestAccountStatusSuccessImplCopyWithImpl<
        _$RequestAccountStatusSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AccountRequestStatusModel? request) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(request);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AccountRequestStatusModel? request)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(request);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AccountRequestStatusModel? request)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(request);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestAccountStatusInitial value) initial,
    required TResult Function(RequestAccountStatusLoading value) loading,
    required TResult Function(RequestAccountStatusSuccess value) success,
    required TResult Function(RequestAccountStatusError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountStatusInitial value)? initial,
    TResult? Function(RequestAccountStatusLoading value)? loading,
    TResult? Function(RequestAccountStatusSuccess value)? success,
    TResult? Function(RequestAccountStatusError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountStatusInitial value)? initial,
    TResult Function(RequestAccountStatusLoading value)? loading,
    TResult Function(RequestAccountStatusSuccess value)? success,
    TResult Function(RequestAccountStatusError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class RequestAccountStatusSuccess
    implements RequestAccountStatusState {
  const factory RequestAccountStatusSuccess(
    final AccountRequestStatusModel? request,
  ) = _$RequestAccountStatusSuccessImpl;

  AccountRequestStatusModel? get request;

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestAccountStatusSuccessImplCopyWith<_$RequestAccountStatusSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RequestAccountStatusErrorImplCopyWith<$Res> {
  factory _$$RequestAccountStatusErrorImplCopyWith(
    _$RequestAccountStatusErrorImpl value,
    $Res Function(_$RequestAccountStatusErrorImpl) then,
  ) = __$$RequestAccountStatusErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$RequestAccountStatusErrorImplCopyWithImpl<$Res>
    extends
        _$RequestAccountStatusStateCopyWithImpl<
          $Res,
          _$RequestAccountStatusErrorImpl
        >
    implements _$$RequestAccountStatusErrorImplCopyWith<$Res> {
  __$$RequestAccountStatusErrorImplCopyWithImpl(
    _$RequestAccountStatusErrorImpl _value,
    $Res Function(_$RequestAccountStatusErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$RequestAccountStatusErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$RequestAccountStatusErrorImpl implements RequestAccountStatusError {
  const _$RequestAccountStatusErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'RequestAccountStatusState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequestAccountStatusErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequestAccountStatusErrorImplCopyWith<_$RequestAccountStatusErrorImpl>
  get copyWith =>
      __$$RequestAccountStatusErrorImplCopyWithImpl<
        _$RequestAccountStatusErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AccountRequestStatusModel? request) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AccountRequestStatusModel? request)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AccountRequestStatusModel? request)? success,
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
    required TResult Function(RequestAccountStatusInitial value) initial,
    required TResult Function(RequestAccountStatusLoading value) loading,
    required TResult Function(RequestAccountStatusSuccess value) success,
    required TResult Function(RequestAccountStatusError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RequestAccountStatusInitial value)? initial,
    TResult? Function(RequestAccountStatusLoading value)? loading,
    TResult? Function(RequestAccountStatusSuccess value)? success,
    TResult? Function(RequestAccountStatusError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestAccountStatusInitial value)? initial,
    TResult Function(RequestAccountStatusLoading value)? loading,
    TResult Function(RequestAccountStatusSuccess value)? success,
    TResult Function(RequestAccountStatusError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RequestAccountStatusError implements RequestAccountStatusState {
  const factory RequestAccountStatusError(final String messageKey) =
      _$RequestAccountStatusErrorImpl;

  String get messageKey;

  /// Create a copy of RequestAccountStatusState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequestAccountStatusErrorImplCopyWith<_$RequestAccountStatusErrorImpl>
  get copyWith => throw _privateConstructorUsedError;
}
