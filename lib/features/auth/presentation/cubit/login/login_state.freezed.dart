// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$LoginState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
    LoginState value,
    $Res Function(LoginState) then,
  ) = _$LoginStateCopyWithImpl<$Res, LoginState>;
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res, $Val extends LoginState>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoginInitialImplCopyWith<$Res> {
  factory _$$LoginInitialImplCopyWith(
    _$LoginInitialImpl value,
    $Res Function(_$LoginInitialImpl) then,
  ) = __$$LoginInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginInitialImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginInitialImpl>
    implements _$$LoginInitialImplCopyWith<$Res> {
  __$$LoginInitialImplCopyWithImpl(
    _$LoginInitialImpl _value,
    $Res Function(_$LoginInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginInitialImpl implements LoginInitial {
  const _$LoginInitialImpl();

  @override
  String toString() {
    return 'LoginState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
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
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class LoginInitial implements LoginState {
  const factory LoginInitial() = _$LoginInitialImpl;
}

/// @nodoc
abstract class _$$LoginLoadingImplCopyWith<$Res> {
  factory _$$LoginLoadingImplCopyWith(
    _$LoginLoadingImpl value,
    $Res Function(_$LoginLoadingImpl) then,
  ) = __$$LoginLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginLoadingImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginLoadingImpl>
    implements _$$LoginLoadingImplCopyWith<$Res> {
  __$$LoginLoadingImplCopyWithImpl(
    _$LoginLoadingImpl _value,
    $Res Function(_$LoginLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginLoadingImpl implements LoginLoading {
  const _$LoginLoadingImpl();

  @override
  String toString() {
    return 'LoginState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoginLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
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
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class LoginLoading implements LoginState {
  const factory LoginLoading() = _$LoginLoadingImpl;
}

/// @nodoc
abstract class _$$LoginSuccessImplCopyWith<$Res> {
  factory _$$LoginSuccessImplCopyWith(
    _$LoginSuccessImpl value,
    $Res Function(_$LoginSuccessImpl) then,
  ) = __$$LoginSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({LoginResponseModel user, String? selectedRole});
}

/// @nodoc
class __$$LoginSuccessImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginSuccessImpl>
    implements _$$LoginSuccessImplCopyWith<$Res> {
  __$$LoginSuccessImplCopyWithImpl(
    _$LoginSuccessImpl _value,
    $Res Function(_$LoginSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? user = null, Object? selectedRole = freezed}) {
    return _then(
      _$LoginSuccessImpl(
        null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as LoginResponseModel,
        selectedRole: freezed == selectedRole
            ? _value.selectedRole
            : selectedRole // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoginSuccessImpl implements LoginSuccess {
  const _$LoginSuccessImpl(this.user, {this.selectedRole});

  @override
  final LoginResponseModel user;
  @override
  final String? selectedRole;

  @override
  String toString() {
    return 'LoginState.success(user: $user, selectedRole: $selectedRole)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginSuccessImpl &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.selectedRole, selectedRole) ||
                other.selectedRole == selectedRole));
  }

  @override
  int get hashCode => Object.hash(runtimeType, user, selectedRole);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginSuccessImplCopyWith<_$LoginSuccessImpl> get copyWith =>
      __$$LoginSuccessImplCopyWithImpl<_$LoginSuccessImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return success(user, selectedRole);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return success?.call(user, selectedRole);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(user, selectedRole);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class LoginSuccess implements LoginState {
  const factory LoginSuccess(
    final LoginResponseModel user, {
    final String? selectedRole,
  }) = _$LoginSuccessImpl;

  LoginResponseModel get user;
  String? get selectedRole;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginSuccessImplCopyWith<_$LoginSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginErrorImplCopyWith<$Res> {
  factory _$$LoginErrorImplCopyWith(
    _$LoginErrorImpl value,
    $Res Function(_$LoginErrorImpl) then,
  ) = __$$LoginErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$LoginErrorImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginErrorImpl>
    implements _$$LoginErrorImplCopyWith<$Res> {
  __$$LoginErrorImplCopyWithImpl(
    _$LoginErrorImpl _value,
    $Res Function(_$LoginErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$LoginErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginErrorImpl implements LoginError {
  const _$LoginErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'LoginState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginErrorImplCopyWith<_$LoginErrorImpl> get copyWith =>
      __$$LoginErrorImplCopyWithImpl<_$LoginErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
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
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class LoginError implements LoginState {
  const factory LoginError(final String messageKey) = _$LoginErrorImpl;

  String get messageKey;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginErrorImplCopyWith<_$LoginErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginDeviceTransferRequiredImplCopyWith<$Res> {
  factory _$$LoginDeviceTransferRequiredImplCopyWith(
    _$LoginDeviceTransferRequiredImpl value,
    $Res Function(_$LoginDeviceTransferRequiredImpl) then,
  ) = __$$LoginDeviceTransferRequiredImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoginDeviceTransferRequiredImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginDeviceTransferRequiredImpl>
    implements _$$LoginDeviceTransferRequiredImplCopyWith<$Res> {
  __$$LoginDeviceTransferRequiredImplCopyWithImpl(
    _$LoginDeviceTransferRequiredImpl _value,
    $Res Function(_$LoginDeviceTransferRequiredImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoginDeviceTransferRequiredImpl implements LoginDeviceTransferRequired {
  const _$LoginDeviceTransferRequiredImpl();

  @override
  String toString() {
    return 'LoginState.deviceTransferRequired()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginDeviceTransferRequiredImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return deviceTransferRequired();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return deviceTransferRequired?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
    required TResult orElse(),
  }) {
    if (deviceTransferRequired != null) {
      return deviceTransferRequired();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return deviceTransferRequired(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return deviceTransferRequired?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (deviceTransferRequired != null) {
      return deviceTransferRequired(this);
    }
    return orElse();
  }
}

abstract class LoginDeviceTransferRequired implements LoginState {
  const factory LoginDeviceTransferRequired() =
      _$LoginDeviceTransferRequiredImpl;
}

/// @nodoc
abstract class _$$LoginAccountLockedImplCopyWith<$Res> {
  factory _$$LoginAccountLockedImplCopyWith(
    _$LoginAccountLockedImpl value,
    $Res Function(_$LoginAccountLockedImpl) then,
  ) = __$$LoginAccountLockedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int lockoutMinutes, String messageKey});
}

/// @nodoc
class __$$LoginAccountLockedImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginAccountLockedImpl>
    implements _$$LoginAccountLockedImplCopyWith<$Res> {
  __$$LoginAccountLockedImplCopyWithImpl(
    _$LoginAccountLockedImpl _value,
    $Res Function(_$LoginAccountLockedImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? lockoutMinutes = null, Object? messageKey = null}) {
    return _then(
      _$LoginAccountLockedImpl(
        lockoutMinutes: null == lockoutMinutes
            ? _value.lockoutMinutes
            : lockoutMinutes // ignore: cast_nullable_to_non_nullable
                  as int,
        messageKey: null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$LoginAccountLockedImpl implements LoginAccountLocked {
  const _$LoginAccountLockedImpl({
    this.lockoutMinutes = 15,
    this.messageKey = 'errors.accountLocked',
  });

  @override
  @JsonKey()
  final int lockoutMinutes;
  @override
  @JsonKey()
  final String messageKey;

  @override
  String toString() {
    return 'LoginState.accountLocked(lockoutMinutes: $lockoutMinutes, messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginAccountLockedImpl &&
            (identical(other.lockoutMinutes, lockoutMinutes) ||
                other.lockoutMinutes == lockoutMinutes) &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockoutMinutes, messageKey);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginAccountLockedImplCopyWith<_$LoginAccountLockedImpl> get copyWith =>
      __$$LoginAccountLockedImplCopyWithImpl<_$LoginAccountLockedImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return accountLocked(lockoutMinutes, messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return accountLocked?.call(lockoutMinutes, messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
    required TResult orElse(),
  }) {
    if (accountLocked != null) {
      return accountLocked(lockoutMinutes, messageKey);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return accountLocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return accountLocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (accountLocked != null) {
      return accountLocked(this);
    }
    return orElse();
  }
}

abstract class LoginAccountLocked implements LoginState {
  const factory LoginAccountLocked({
    final int lockoutMinutes,
    final String messageKey,
  }) = _$LoginAccountLockedImpl;

  int get lockoutMinutes;
  String get messageKey;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginAccountLockedImplCopyWith<_$LoginAccountLockedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$LoginOutsideZoneImplCopyWith<$Res> {
  factory _$$LoginOutsideZoneImplCopyWith(
    _$LoginOutsideZoneImpl value,
    $Res Function(_$LoginOutsideZoneImpl) then,
  ) = __$$LoginOutsideZoneImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey, String? siteName, String? rawMessage});
}

/// @nodoc
class __$$LoginOutsideZoneImplCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res, _$LoginOutsideZoneImpl>
    implements _$$LoginOutsideZoneImplCopyWith<$Res> {
  __$$LoginOutsideZoneImplCopyWithImpl(
    _$LoginOutsideZoneImpl _value,
    $Res Function(_$LoginOutsideZoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messageKey = null,
    Object? siteName = freezed,
    Object? rawMessage = freezed,
  }) {
    return _then(
      _$LoginOutsideZoneImpl(
        messageKey: null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
        siteName: freezed == siteName
            ? _value.siteName
            : siteName // ignore: cast_nullable_to_non_nullable
                  as String?,
        rawMessage: freezed == rawMessage
            ? _value.rawMessage
            : rawMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$LoginOutsideZoneImpl implements LoginOutsideZone {
  const _$LoginOutsideZoneImpl({
    this.messageKey = 'auth.login.outsideZoneMessage',
    this.siteName,
    this.rawMessage,
  });

  @override
  @JsonKey()
  final String messageKey;
  @override
  final String? siteName;
  @override
  final String? rawMessage;

  @override
  String toString() {
    return 'LoginState.outsideZone(messageKey: $messageKey, siteName: $siteName, rawMessage: $rawMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoginOutsideZoneImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey) &&
            (identical(other.siteName, siteName) ||
                other.siteName == siteName) &&
            (identical(other.rawMessage, rawMessage) ||
                other.rawMessage == rawMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, messageKey, siteName, rawMessage);

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoginOutsideZoneImplCopyWith<_$LoginOutsideZoneImpl> get copyWith =>
      __$$LoginOutsideZoneImplCopyWithImpl<_$LoginOutsideZoneImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(LoginResponseModel user, String? selectedRole)
    success,
    required TResult Function(String messageKey) error,
    required TResult Function() deviceTransferRequired,
    required TResult Function(int lockoutMinutes, String messageKey)
    accountLocked,
    required TResult Function(
      String messageKey,
      String? siteName,
      String? rawMessage,
    )
    outsideZone,
  }) {
    return outsideZone(messageKey, siteName, rawMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(LoginResponseModel user, String? selectedRole)? success,
    TResult? Function(String messageKey)? error,
    TResult? Function()? deviceTransferRequired,
    TResult? Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult? Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
  }) {
    return outsideZone?.call(messageKey, siteName, rawMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(LoginResponseModel user, String? selectedRole)? success,
    TResult Function(String messageKey)? error,
    TResult Function()? deviceTransferRequired,
    TResult Function(int lockoutMinutes, String messageKey)? accountLocked,
    TResult Function(String messageKey, String? siteName, String? rawMessage)?
    outsideZone,
    required TResult orElse(),
  }) {
    if (outsideZone != null) {
      return outsideZone(messageKey, siteName, rawMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoginInitial value) initial,
    required TResult Function(LoginLoading value) loading,
    required TResult Function(LoginSuccess value) success,
    required TResult Function(LoginError value) error,
    required TResult Function(LoginDeviceTransferRequired value)
    deviceTransferRequired,
    required TResult Function(LoginAccountLocked value) accountLocked,
    required TResult Function(LoginOutsideZone value) outsideZone,
  }) {
    return outsideZone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoginInitial value)? initial,
    TResult? Function(LoginLoading value)? loading,
    TResult? Function(LoginSuccess value)? success,
    TResult? Function(LoginError value)? error,
    TResult? Function(LoginDeviceTransferRequired value)?
    deviceTransferRequired,
    TResult? Function(LoginAccountLocked value)? accountLocked,
    TResult? Function(LoginOutsideZone value)? outsideZone,
  }) {
    return outsideZone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoginInitial value)? initial,
    TResult Function(LoginLoading value)? loading,
    TResult Function(LoginSuccess value)? success,
    TResult Function(LoginError value)? error,
    TResult Function(LoginDeviceTransferRequired value)? deviceTransferRequired,
    TResult Function(LoginAccountLocked value)? accountLocked,
    TResult Function(LoginOutsideZone value)? outsideZone,
    required TResult orElse(),
  }) {
    if (outsideZone != null) {
      return outsideZone(this);
    }
    return orElse();
  }
}

abstract class LoginOutsideZone implements LoginState {
  const factory LoginOutsideZone({
    final String messageKey,
    final String? siteName,
    final String? rawMessage,
  }) = _$LoginOutsideZoneImpl;

  String get messageKey;
  String? get siteName;
  String? get rawMessage;

  /// Create a copy of LoginState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoginOutsideZoneImplCopyWith<_$LoginOutsideZoneImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
