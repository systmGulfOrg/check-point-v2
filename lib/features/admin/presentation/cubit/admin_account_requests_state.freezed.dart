// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_account_requests_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminAccountRequestsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AccountRequestModel> requests) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AccountRequestModel> requests)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AccountRequestModel> requests)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminAccountRequestsStateInitial value) initial,
    required TResult Function(AdminAccountRequestsStateLoading value) loading,
    required TResult Function(AdminAccountRequestsStateSuccess value) success,
    required TResult Function(AdminAccountRequestsStateError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminAccountRequestsStateInitial value)? initial,
    TResult? Function(AdminAccountRequestsStateLoading value)? loading,
    TResult? Function(AdminAccountRequestsStateSuccess value)? success,
    TResult? Function(AdminAccountRequestsStateError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminAccountRequestsStateInitial value)? initial,
    TResult Function(AdminAccountRequestsStateLoading value)? loading,
    TResult Function(AdminAccountRequestsStateSuccess value)? success,
    TResult Function(AdminAccountRequestsStateError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminAccountRequestsStateCopyWith<$Res> {
  factory $AdminAccountRequestsStateCopyWith(
    AdminAccountRequestsState value,
    $Res Function(AdminAccountRequestsState) then,
  ) = _$AdminAccountRequestsStateCopyWithImpl<$Res, AdminAccountRequestsState>;
}

/// @nodoc
class _$AdminAccountRequestsStateCopyWithImpl<
  $Res,
  $Val extends AdminAccountRequestsState
>
    implements $AdminAccountRequestsStateCopyWith<$Res> {
  _$AdminAccountRequestsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminAccountRequestsStateInitialImplCopyWith<$Res> {
  factory _$$AdminAccountRequestsStateInitialImplCopyWith(
    _$AdminAccountRequestsStateInitialImpl value,
    $Res Function(_$AdminAccountRequestsStateInitialImpl) then,
  ) = __$$AdminAccountRequestsStateInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminAccountRequestsStateInitialImplCopyWithImpl<$Res>
    extends
        _$AdminAccountRequestsStateCopyWithImpl<
          $Res,
          _$AdminAccountRequestsStateInitialImpl
        >
    implements _$$AdminAccountRequestsStateInitialImplCopyWith<$Res> {
  __$$AdminAccountRequestsStateInitialImplCopyWithImpl(
    _$AdminAccountRequestsStateInitialImpl _value,
    $Res Function(_$AdminAccountRequestsStateInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminAccountRequestsStateInitialImpl
    implements AdminAccountRequestsStateInitial {
  const _$AdminAccountRequestsStateInitialImpl();

  @override
  String toString() {
    return 'AdminAccountRequestsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminAccountRequestsStateInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AccountRequestModel> requests) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AccountRequestModel> requests)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AccountRequestModel> requests)? success,
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
    required TResult Function(AdminAccountRequestsStateInitial value) initial,
    required TResult Function(AdminAccountRequestsStateLoading value) loading,
    required TResult Function(AdminAccountRequestsStateSuccess value) success,
    required TResult Function(AdminAccountRequestsStateError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminAccountRequestsStateInitial value)? initial,
    TResult? Function(AdminAccountRequestsStateLoading value)? loading,
    TResult? Function(AdminAccountRequestsStateSuccess value)? success,
    TResult? Function(AdminAccountRequestsStateError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminAccountRequestsStateInitial value)? initial,
    TResult Function(AdminAccountRequestsStateLoading value)? loading,
    TResult Function(AdminAccountRequestsStateSuccess value)? success,
    TResult Function(AdminAccountRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AdminAccountRequestsStateInitial
    implements AdminAccountRequestsState {
  const factory AdminAccountRequestsStateInitial() =
      _$AdminAccountRequestsStateInitialImpl;
}

/// @nodoc
abstract class _$$AdminAccountRequestsStateLoadingImplCopyWith<$Res> {
  factory _$$AdminAccountRequestsStateLoadingImplCopyWith(
    _$AdminAccountRequestsStateLoadingImpl value,
    $Res Function(_$AdminAccountRequestsStateLoadingImpl) then,
  ) = __$$AdminAccountRequestsStateLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminAccountRequestsStateLoadingImplCopyWithImpl<$Res>
    extends
        _$AdminAccountRequestsStateCopyWithImpl<
          $Res,
          _$AdminAccountRequestsStateLoadingImpl
        >
    implements _$$AdminAccountRequestsStateLoadingImplCopyWith<$Res> {
  __$$AdminAccountRequestsStateLoadingImplCopyWithImpl(
    _$AdminAccountRequestsStateLoadingImpl _value,
    $Res Function(_$AdminAccountRequestsStateLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminAccountRequestsStateLoadingImpl
    implements AdminAccountRequestsStateLoading {
  const _$AdminAccountRequestsStateLoadingImpl();

  @override
  String toString() {
    return 'AdminAccountRequestsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminAccountRequestsStateLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AccountRequestModel> requests) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AccountRequestModel> requests)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AccountRequestModel> requests)? success,
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
    required TResult Function(AdminAccountRequestsStateInitial value) initial,
    required TResult Function(AdminAccountRequestsStateLoading value) loading,
    required TResult Function(AdminAccountRequestsStateSuccess value) success,
    required TResult Function(AdminAccountRequestsStateError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminAccountRequestsStateInitial value)? initial,
    TResult? Function(AdminAccountRequestsStateLoading value)? loading,
    TResult? Function(AdminAccountRequestsStateSuccess value)? success,
    TResult? Function(AdminAccountRequestsStateError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminAccountRequestsStateInitial value)? initial,
    TResult Function(AdminAccountRequestsStateLoading value)? loading,
    TResult Function(AdminAccountRequestsStateSuccess value)? success,
    TResult Function(AdminAccountRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AdminAccountRequestsStateLoading
    implements AdminAccountRequestsState {
  const factory AdminAccountRequestsStateLoading() =
      _$AdminAccountRequestsStateLoadingImpl;
}

/// @nodoc
abstract class _$$AdminAccountRequestsStateSuccessImplCopyWith<$Res> {
  factory _$$AdminAccountRequestsStateSuccessImplCopyWith(
    _$AdminAccountRequestsStateSuccessImpl value,
    $Res Function(_$AdminAccountRequestsStateSuccessImpl) then,
  ) = __$$AdminAccountRequestsStateSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<AccountRequestModel> requests});
}

/// @nodoc
class __$$AdminAccountRequestsStateSuccessImplCopyWithImpl<$Res>
    extends
        _$AdminAccountRequestsStateCopyWithImpl<
          $Res,
          _$AdminAccountRequestsStateSuccessImpl
        >
    implements _$$AdminAccountRequestsStateSuccessImplCopyWith<$Res> {
  __$$AdminAccountRequestsStateSuccessImplCopyWithImpl(
    _$AdminAccountRequestsStateSuccessImpl _value,
    $Res Function(_$AdminAccountRequestsStateSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? requests = null}) {
    return _then(
      _$AdminAccountRequestsStateSuccessImpl(
        null == requests
            ? _value._requests
            : requests // ignore: cast_nullable_to_non_nullable
                  as List<AccountRequestModel>,
      ),
    );
  }
}

/// @nodoc

class _$AdminAccountRequestsStateSuccessImpl
    implements AdminAccountRequestsStateSuccess {
  const _$AdminAccountRequestsStateSuccessImpl(
    final List<AccountRequestModel> requests,
  ) : _requests = requests;

  final List<AccountRequestModel> _requests;
  @override
  List<AccountRequestModel> get requests {
    if (_requests is EqualUnmodifiableListView) return _requests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requests);
  }

  @override
  String toString() {
    return 'AdminAccountRequestsState.success(requests: $requests)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminAccountRequestsStateSuccessImpl &&
            const DeepCollectionEquality().equals(other._requests, _requests));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_requests));

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminAccountRequestsStateSuccessImplCopyWith<
    _$AdminAccountRequestsStateSuccessImpl
  >
  get copyWith =>
      __$$AdminAccountRequestsStateSuccessImplCopyWithImpl<
        _$AdminAccountRequestsStateSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AccountRequestModel> requests) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(requests);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AccountRequestModel> requests)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(requests);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AccountRequestModel> requests)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(requests);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminAccountRequestsStateInitial value) initial,
    required TResult Function(AdminAccountRequestsStateLoading value) loading,
    required TResult Function(AdminAccountRequestsStateSuccess value) success,
    required TResult Function(AdminAccountRequestsStateError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminAccountRequestsStateInitial value)? initial,
    TResult? Function(AdminAccountRequestsStateLoading value)? loading,
    TResult? Function(AdminAccountRequestsStateSuccess value)? success,
    TResult? Function(AdminAccountRequestsStateError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminAccountRequestsStateInitial value)? initial,
    TResult Function(AdminAccountRequestsStateLoading value)? loading,
    TResult Function(AdminAccountRequestsStateSuccess value)? success,
    TResult Function(AdminAccountRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AdminAccountRequestsStateSuccess
    implements AdminAccountRequestsState {
  const factory AdminAccountRequestsStateSuccess(
    final List<AccountRequestModel> requests,
  ) = _$AdminAccountRequestsStateSuccessImpl;

  List<AccountRequestModel> get requests;

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminAccountRequestsStateSuccessImplCopyWith<
    _$AdminAccountRequestsStateSuccessImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminAccountRequestsStateErrorImplCopyWith<$Res> {
  factory _$$AdminAccountRequestsStateErrorImplCopyWith(
    _$AdminAccountRequestsStateErrorImpl value,
    $Res Function(_$AdminAccountRequestsStateErrorImpl) then,
  ) = __$$AdminAccountRequestsStateErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AdminAccountRequestsStateErrorImplCopyWithImpl<$Res>
    extends
        _$AdminAccountRequestsStateCopyWithImpl<
          $Res,
          _$AdminAccountRequestsStateErrorImpl
        >
    implements _$$AdminAccountRequestsStateErrorImplCopyWith<$Res> {
  __$$AdminAccountRequestsStateErrorImplCopyWithImpl(
    _$AdminAccountRequestsStateErrorImpl _value,
    $Res Function(_$AdminAccountRequestsStateErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AdminAccountRequestsStateErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminAccountRequestsStateErrorImpl
    implements AdminAccountRequestsStateError {
  const _$AdminAccountRequestsStateErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AdminAccountRequestsState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminAccountRequestsStateErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminAccountRequestsStateErrorImplCopyWith<
    _$AdminAccountRequestsStateErrorImpl
  >
  get copyWith =>
      __$$AdminAccountRequestsStateErrorImplCopyWithImpl<
        _$AdminAccountRequestsStateErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<AccountRequestModel> requests) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<AccountRequestModel> requests)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<AccountRequestModel> requests)? success,
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
    required TResult Function(AdminAccountRequestsStateInitial value) initial,
    required TResult Function(AdminAccountRequestsStateLoading value) loading,
    required TResult Function(AdminAccountRequestsStateSuccess value) success,
    required TResult Function(AdminAccountRequestsStateError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminAccountRequestsStateInitial value)? initial,
    TResult? Function(AdminAccountRequestsStateLoading value)? loading,
    TResult? Function(AdminAccountRequestsStateSuccess value)? success,
    TResult? Function(AdminAccountRequestsStateError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminAccountRequestsStateInitial value)? initial,
    TResult Function(AdminAccountRequestsStateLoading value)? loading,
    TResult Function(AdminAccountRequestsStateSuccess value)? success,
    TResult Function(AdminAccountRequestsStateError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AdminAccountRequestsStateError
    implements AdminAccountRequestsState {
  const factory AdminAccountRequestsStateError(final String messageKey) =
      _$AdminAccountRequestsStateErrorImpl;

  String get messageKey;

  /// Create a copy of AdminAccountRequestsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminAccountRequestsStateErrorImplCopyWith<
    _$AdminAccountRequestsStateErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
