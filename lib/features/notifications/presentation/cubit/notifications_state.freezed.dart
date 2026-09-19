// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notifications_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$NotificationsState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<NotificationModel> notifications,
      int unreadCount,
    )
    success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> notifications, int unreadCount)?
    success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NotificationModel> notifications, int unreadCount)?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsSuccess value) success,
    required TResult Function(NotificationsError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsSuccess value)? success,
    TResult? Function(NotificationsError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsSuccess value)? success,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationsStateCopyWith<$Res> {
  factory $NotificationsStateCopyWith(
    NotificationsState value,
    $Res Function(NotificationsState) then,
  ) = _$NotificationsStateCopyWithImpl<$Res, NotificationsState>;
}

/// @nodoc
class _$NotificationsStateCopyWithImpl<$Res, $Val extends NotificationsState>
    implements $NotificationsStateCopyWith<$Res> {
  _$NotificationsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$NotificationsInitialImplCopyWith<$Res> {
  factory _$$NotificationsInitialImplCopyWith(
    _$NotificationsInitialImpl value,
    $Res Function(_$NotificationsInitialImpl) then,
  ) = __$$NotificationsInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsInitialImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsInitialImpl>
    implements _$$NotificationsInitialImplCopyWith<$Res> {
  __$$NotificationsInitialImplCopyWithImpl(
    _$NotificationsInitialImpl _value,
    $Res Function(_$NotificationsInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsInitialImpl implements NotificationsInitial {
  const _$NotificationsInitialImpl();

  @override
  String toString() {
    return 'NotificationsState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<NotificationModel> notifications,
      int unreadCount,
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
    TResult? Function(List<NotificationModel> notifications, int unreadCount)?
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
    TResult Function(List<NotificationModel> notifications, int unreadCount)?
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsSuccess value) success,
    required TResult Function(NotificationsError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsSuccess value)? success,
    TResult? Function(NotificationsError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsSuccess value)? success,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class NotificationsInitial implements NotificationsState {
  const factory NotificationsInitial() = _$NotificationsInitialImpl;
}

/// @nodoc
abstract class _$$NotificationsLoadingImplCopyWith<$Res> {
  factory _$$NotificationsLoadingImplCopyWith(
    _$NotificationsLoadingImpl value,
    $Res Function(_$NotificationsLoadingImpl) then,
  ) = __$$NotificationsLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NotificationsLoadingImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsLoadingImpl>
    implements _$$NotificationsLoadingImplCopyWith<$Res> {
  __$$NotificationsLoadingImplCopyWithImpl(
    _$NotificationsLoadingImpl _value,
    $Res Function(_$NotificationsLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NotificationsLoadingImpl implements NotificationsLoading {
  const _$NotificationsLoadingImpl();

  @override
  String toString() {
    return 'NotificationsState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<NotificationModel> notifications,
      int unreadCount,
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
    TResult? Function(List<NotificationModel> notifications, int unreadCount)?
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
    TResult Function(List<NotificationModel> notifications, int unreadCount)?
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsSuccess value) success,
    required TResult Function(NotificationsError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsSuccess value)? success,
    TResult? Function(NotificationsError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsSuccess value)? success,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class NotificationsLoading implements NotificationsState {
  const factory NotificationsLoading() = _$NotificationsLoadingImpl;
}

/// @nodoc
abstract class _$$NotificationsSuccessImplCopyWith<$Res> {
  factory _$$NotificationsSuccessImplCopyWith(
    _$NotificationsSuccessImpl value,
    $Res Function(_$NotificationsSuccessImpl) then,
  ) = __$$NotificationsSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<NotificationModel> notifications, int unreadCount});
}

/// @nodoc
class __$$NotificationsSuccessImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsSuccessImpl>
    implements _$$NotificationsSuccessImplCopyWith<$Res> {
  __$$NotificationsSuccessImplCopyWithImpl(
    _$NotificationsSuccessImpl _value,
    $Res Function(_$NotificationsSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notifications = null, Object? unreadCount = null}) {
    return _then(
      _$NotificationsSuccessImpl(
        null == notifications
            ? _value._notifications
            : notifications // ignore: cast_nullable_to_non_nullable
                  as List<NotificationModel>,
        null == unreadCount
            ? _value.unreadCount
            : unreadCount // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsSuccessImpl implements NotificationsSuccess {
  const _$NotificationsSuccessImpl(
    final List<NotificationModel> notifications,
    this.unreadCount,
  ) : _notifications = notifications;

  final List<NotificationModel> _notifications;
  @override
  List<NotificationModel> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  final int unreadCount;

  @override
  String toString() {
    return 'NotificationsState.success(notifications: $notifications, unreadCount: $unreadCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsSuccessImpl &&
            const DeepCollectionEquality().equals(
              other._notifications,
              _notifications,
            ) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_notifications),
    unreadCount,
  );

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsSuccessImplCopyWith<_$NotificationsSuccessImpl>
  get copyWith =>
      __$$NotificationsSuccessImplCopyWithImpl<_$NotificationsSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<NotificationModel> notifications,
      int unreadCount,
    )
    success,
    required TResult Function(String messageKey) error,
  }) {
    return success(notifications, unreadCount);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<NotificationModel> notifications, int unreadCount)?
    success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(notifications, unreadCount);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<NotificationModel> notifications, int unreadCount)?
    success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(notifications, unreadCount);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsSuccess value) success,
    required TResult Function(NotificationsError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsSuccess value)? success,
    TResult? Function(NotificationsError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsSuccess value)? success,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class NotificationsSuccess implements NotificationsState {
  const factory NotificationsSuccess(
    final List<NotificationModel> notifications,
    final int unreadCount,
  ) = _$NotificationsSuccessImpl;

  List<NotificationModel> get notifications;
  int get unreadCount;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsSuccessImplCopyWith<_$NotificationsSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NotificationsErrorImplCopyWith<$Res> {
  factory _$$NotificationsErrorImplCopyWith(
    _$NotificationsErrorImpl value,
    $Res Function(_$NotificationsErrorImpl) then,
  ) = __$$NotificationsErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$NotificationsErrorImplCopyWithImpl<$Res>
    extends _$NotificationsStateCopyWithImpl<$Res, _$NotificationsErrorImpl>
    implements _$$NotificationsErrorImplCopyWith<$Res> {
  __$$NotificationsErrorImplCopyWithImpl(
    _$NotificationsErrorImpl _value,
    $Res Function(_$NotificationsErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$NotificationsErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$NotificationsErrorImpl implements NotificationsError {
  const _$NotificationsErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'NotificationsState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationsErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationsErrorImplCopyWith<_$NotificationsErrorImpl> get copyWith =>
      __$$NotificationsErrorImplCopyWithImpl<_$NotificationsErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
      List<NotificationModel> notifications,
      int unreadCount,
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
    TResult? Function(List<NotificationModel> notifications, int unreadCount)?
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
    TResult Function(List<NotificationModel> notifications, int unreadCount)?
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
    required TResult Function(NotificationsInitial value) initial,
    required TResult Function(NotificationsLoading value) loading,
    required TResult Function(NotificationsSuccess value) success,
    required TResult Function(NotificationsError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NotificationsInitial value)? initial,
    TResult? Function(NotificationsLoading value)? loading,
    TResult? Function(NotificationsSuccess value)? success,
    TResult? Function(NotificationsError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NotificationsInitial value)? initial,
    TResult Function(NotificationsLoading value)? loading,
    TResult Function(NotificationsSuccess value)? success,
    TResult Function(NotificationsError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class NotificationsError implements NotificationsState {
  const factory NotificationsError(final String messageKey) =
      _$NotificationsErrorImpl;

  String get messageKey;

  /// Create a copy of NotificationsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationsErrorImplCopyWith<_$NotificationsErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
