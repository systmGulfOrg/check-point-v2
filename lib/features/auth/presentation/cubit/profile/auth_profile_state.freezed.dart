// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AuthProfileState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String name,
      String userId,
      String role,
      String username,
    )
    success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String name, String userId, String role, String username)?
    success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String name, String userId, String role, String username)?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthProfileInitial value) initial,
    required TResult Function(AuthProfileLoading value) loading,
    required TResult Function(AuthProfileSuccess value) success,
    required TResult Function(AuthProfileError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthProfileInitial value)? initial,
    TResult? Function(AuthProfileLoading value)? loading,
    TResult? Function(AuthProfileSuccess value)? success,
    TResult? Function(AuthProfileError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthProfileInitial value)? initial,
    TResult Function(AuthProfileLoading value)? loading,
    TResult Function(AuthProfileSuccess value)? success,
    TResult Function(AuthProfileError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthProfileStateCopyWith<$Res> {
  factory $AuthProfileStateCopyWith(
    AuthProfileState value,
    $Res Function(AuthProfileState) then,
  ) = _$AuthProfileStateCopyWithImpl<$Res, AuthProfileState>;
}

/// @nodoc
class _$AuthProfileStateCopyWithImpl<$Res, $Val extends AuthProfileState>
    implements $AuthProfileStateCopyWith<$Res> {
  _$AuthProfileStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AuthProfileInitialImplCopyWith<$Res> {
  factory _$$AuthProfileInitialImplCopyWith(
    _$AuthProfileInitialImpl value,
    $Res Function(_$AuthProfileInitialImpl) then,
  ) = __$$AuthProfileInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthProfileInitialImplCopyWithImpl<$Res>
    extends _$AuthProfileStateCopyWithImpl<$Res, _$AuthProfileInitialImpl>
    implements _$$AuthProfileInitialImplCopyWith<$Res> {
  __$$AuthProfileInitialImplCopyWithImpl(
    _$AuthProfileInitialImpl _value,
    $Res Function(_$AuthProfileInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthProfileInitialImpl implements AuthProfileInitial {
  const _$AuthProfileInitialImpl();

  @override
  String toString() {
    return 'AuthProfileState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthProfileInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String name,
      String userId,
      String role,
      String username,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String name, String userId, String role, String username)?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String name, String userId, String role, String username)?
    success,
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
    required TResult Function(AuthProfileInitial value) initial,
    required TResult Function(AuthProfileLoading value) loading,
    required TResult Function(AuthProfileSuccess value) success,
    required TResult Function(AuthProfileError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthProfileInitial value)? initial,
    TResult? Function(AuthProfileLoading value)? loading,
    TResult? Function(AuthProfileSuccess value)? success,
    TResult? Function(AuthProfileError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthProfileInitial value)? initial,
    TResult Function(AuthProfileLoading value)? loading,
    TResult Function(AuthProfileSuccess value)? success,
    TResult Function(AuthProfileError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthProfileInitial implements AuthProfileState {
  const factory AuthProfileInitial() = _$AuthProfileInitialImpl;
}

/// @nodoc
abstract class _$$AuthProfileLoadingImplCopyWith<$Res> {
  factory _$$AuthProfileLoadingImplCopyWith(
    _$AuthProfileLoadingImpl value,
    $Res Function(_$AuthProfileLoadingImpl) then,
  ) = __$$AuthProfileLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AuthProfileLoadingImplCopyWithImpl<$Res>
    extends _$AuthProfileStateCopyWithImpl<$Res, _$AuthProfileLoadingImpl>
    implements _$$AuthProfileLoadingImplCopyWith<$Res> {
  __$$AuthProfileLoadingImplCopyWithImpl(
    _$AuthProfileLoadingImpl _value,
    $Res Function(_$AuthProfileLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AuthProfileLoadingImpl implements AuthProfileLoading {
  const _$AuthProfileLoadingImpl();

  @override
  String toString() {
    return 'AuthProfileState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AuthProfileLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String name,
      String userId,
      String role,
      String username,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String name, String userId, String role, String username)?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String name, String userId, String role, String username)?
    success,
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
    required TResult Function(AuthProfileInitial value) initial,
    required TResult Function(AuthProfileLoading value) loading,
    required TResult Function(AuthProfileSuccess value) success,
    required TResult Function(AuthProfileError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthProfileInitial value)? initial,
    TResult? Function(AuthProfileLoading value)? loading,
    TResult? Function(AuthProfileSuccess value)? success,
    TResult? Function(AuthProfileError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthProfileInitial value)? initial,
    TResult Function(AuthProfileLoading value)? loading,
    TResult Function(AuthProfileSuccess value)? success,
    TResult Function(AuthProfileError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AuthProfileLoading implements AuthProfileState {
  const factory AuthProfileLoading() = _$AuthProfileLoadingImpl;
}

/// @nodoc
abstract class _$$AuthProfileSuccessImplCopyWith<$Res> {
  factory _$$AuthProfileSuccessImplCopyWith(
    _$AuthProfileSuccessImpl value,
    $Res Function(_$AuthProfileSuccessImpl) then,
  ) = __$$AuthProfileSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String name, String userId, String role, String username});
}

/// @nodoc
class __$$AuthProfileSuccessImplCopyWithImpl<$Res>
    extends _$AuthProfileStateCopyWithImpl<$Res, _$AuthProfileSuccessImpl>
    implements _$$AuthProfileSuccessImplCopyWith<$Res> {
  __$$AuthProfileSuccessImplCopyWithImpl(
    _$AuthProfileSuccessImpl _value,
    $Res Function(_$AuthProfileSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? userId = null,
    Object? role = null,
    Object? username = null,
  }) {
    return _then(
      _$AuthProfileSuccessImpl(
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthProfileSuccessImpl implements AuthProfileSuccess {
  const _$AuthProfileSuccessImpl({
    required this.name,
    required this.userId,
    required this.role,
    required this.username,
  });

  @override
  final String name;
  @override
  final String userId;
  @override
  final String role;
  @override
  final String username;

  @override
  String toString() {
    return 'AuthProfileState.success(name: $name, userId: $userId, role: $role, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthProfileSuccessImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.username, username) ||
                other.username == username));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, userId, role, username);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthProfileSuccessImplCopyWith<_$AuthProfileSuccessImpl> get copyWith =>
      __$$AuthProfileSuccessImplCopyWithImpl<_$AuthProfileSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String name,
      String userId,
      String role,
      String username,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return success(name, userId, role, username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String name, String userId, String role, String username)?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(name, userId, role, username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String name, String userId, String role, String username)?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(name, userId, role, username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AuthProfileInitial value) initial,
    required TResult Function(AuthProfileLoading value) loading,
    required TResult Function(AuthProfileSuccess value) success,
    required TResult Function(AuthProfileError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthProfileInitial value)? initial,
    TResult? Function(AuthProfileLoading value)? loading,
    TResult? Function(AuthProfileSuccess value)? success,
    TResult? Function(AuthProfileError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthProfileInitial value)? initial,
    TResult Function(AuthProfileLoading value)? loading,
    TResult Function(AuthProfileSuccess value)? success,
    TResult Function(AuthProfileError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AuthProfileSuccess implements AuthProfileState {
  const factory AuthProfileSuccess({
    required final String name,
    required final String userId,
    required final String role,
    required final String username,
  }) = _$AuthProfileSuccessImpl;

  String get name;
  String get userId;
  String get role;
  String get username;

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthProfileSuccessImplCopyWith<_$AuthProfileSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AuthProfileErrorImplCopyWith<$Res> {
  factory _$$AuthProfileErrorImplCopyWith(
    _$AuthProfileErrorImpl value,
    $Res Function(_$AuthProfileErrorImpl) then,
  ) = __$$AuthProfileErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AuthProfileErrorImplCopyWithImpl<$Res>
    extends _$AuthProfileStateCopyWithImpl<$Res, _$AuthProfileErrorImpl>
    implements _$$AuthProfileErrorImplCopyWith<$Res> {
  __$$AuthProfileErrorImplCopyWithImpl(
    _$AuthProfileErrorImpl _value,
    $Res Function(_$AuthProfileErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AuthProfileErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AuthProfileErrorImpl implements AuthProfileError {
  const _$AuthProfileErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AuthProfileState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthProfileErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthProfileErrorImplCopyWith<_$AuthProfileErrorImpl> get copyWith =>
      __$$AuthProfileErrorImplCopyWithImpl<_$AuthProfileErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      String name,
      String userId,
      String role,
      String username,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(String name, String userId, String role, String username)?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String name, String userId, String role, String username)?
    success,
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
    required TResult Function(AuthProfileInitial value) initial,
    required TResult Function(AuthProfileLoading value) loading,
    required TResult Function(AuthProfileSuccess value) success,
    required TResult Function(AuthProfileError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AuthProfileInitial value)? initial,
    TResult? Function(AuthProfileLoading value)? loading,
    TResult? Function(AuthProfileSuccess value)? success,
    TResult? Function(AuthProfileError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AuthProfileInitial value)? initial,
    TResult Function(AuthProfileLoading value)? loading,
    TResult Function(AuthProfileSuccess value)? success,
    TResult Function(AuthProfileError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthProfileError implements AuthProfileState {
  const factory AuthProfileError(final String messageKey) =
      _$AuthProfileErrorImpl;

  String get messageKey;

  /// Create a copy of AuthProfileState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuthProfileErrorImplCopyWith<_$AuthProfileErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
