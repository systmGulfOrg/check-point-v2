// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'support_ticket_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SupportTicketState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupportTicketIdle value) idle,
    required TResult Function(SupportTicketLoading value) loading,
    required TResult Function(SupportTicketSuccess value) success,
    required TResult Function(SupportTicketFailure value) failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupportTicketIdle value)? idle,
    TResult? Function(SupportTicketLoading value)? loading,
    TResult? Function(SupportTicketSuccess value)? success,
    TResult? Function(SupportTicketFailure value)? failure,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupportTicketIdle value)? idle,
    TResult Function(SupportTicketLoading value)? loading,
    TResult Function(SupportTicketSuccess value)? success,
    TResult Function(SupportTicketFailure value)? failure,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupportTicketStateCopyWith<$Res> {
  factory $SupportTicketStateCopyWith(
    SupportTicketState value,
    $Res Function(SupportTicketState) then,
  ) = _$SupportTicketStateCopyWithImpl<$Res, SupportTicketState>;
}

/// @nodoc
class _$SupportTicketStateCopyWithImpl<$Res, $Val extends SupportTicketState>
    implements $SupportTicketStateCopyWith<$Res> {
  _$SupportTicketStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SupportTicketIdleImplCopyWith<$Res> {
  factory _$$SupportTicketIdleImplCopyWith(
    _$SupportTicketIdleImpl value,
    $Res Function(_$SupportTicketIdleImpl) then,
  ) = __$$SupportTicketIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupportTicketIdleImplCopyWithImpl<$Res>
    extends _$SupportTicketStateCopyWithImpl<$Res, _$SupportTicketIdleImpl>
    implements _$$SupportTicketIdleImplCopyWith<$Res> {
  __$$SupportTicketIdleImplCopyWithImpl(
    _$SupportTicketIdleImpl _value,
    $Res Function(_$SupportTicketIdleImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupportTicketIdleImpl implements SupportTicketIdle {
  const _$SupportTicketIdleImpl();

  @override
  String toString() {
    return 'SupportTicketState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SupportTicketIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupportTicketIdle value) idle,
    required TResult Function(SupportTicketLoading value) loading,
    required TResult Function(SupportTicketSuccess value) success,
    required TResult Function(SupportTicketFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupportTicketIdle value)? idle,
    TResult? Function(SupportTicketLoading value)? loading,
    TResult? Function(SupportTicketSuccess value)? success,
    TResult? Function(SupportTicketFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupportTicketIdle value)? idle,
    TResult Function(SupportTicketLoading value)? loading,
    TResult Function(SupportTicketSuccess value)? success,
    TResult Function(SupportTicketFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class SupportTicketIdle implements SupportTicketState {
  const factory SupportTicketIdle() = _$SupportTicketIdleImpl;
}

/// @nodoc
abstract class _$$SupportTicketLoadingImplCopyWith<$Res> {
  factory _$$SupportTicketLoadingImplCopyWith(
    _$SupportTicketLoadingImpl value,
    $Res Function(_$SupportTicketLoadingImpl) then,
  ) = __$$SupportTicketLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupportTicketLoadingImplCopyWithImpl<$Res>
    extends _$SupportTicketStateCopyWithImpl<$Res, _$SupportTicketLoadingImpl>
    implements _$$SupportTicketLoadingImplCopyWith<$Res> {
  __$$SupportTicketLoadingImplCopyWithImpl(
    _$SupportTicketLoadingImpl _value,
    $Res Function(_$SupportTicketLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupportTicketLoadingImpl implements SupportTicketLoading {
  const _$SupportTicketLoadingImpl();

  @override
  String toString() {
    return 'SupportTicketState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportTicketLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) failure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? failure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? failure,
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
    required TResult Function(SupportTicketIdle value) idle,
    required TResult Function(SupportTicketLoading value) loading,
    required TResult Function(SupportTicketSuccess value) success,
    required TResult Function(SupportTicketFailure value) failure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupportTicketIdle value)? idle,
    TResult? Function(SupportTicketLoading value)? loading,
    TResult? Function(SupportTicketSuccess value)? success,
    TResult? Function(SupportTicketFailure value)? failure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupportTicketIdle value)? idle,
    TResult Function(SupportTicketLoading value)? loading,
    TResult Function(SupportTicketSuccess value)? success,
    TResult Function(SupportTicketFailure value)? failure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SupportTicketLoading implements SupportTicketState {
  const factory SupportTicketLoading() = _$SupportTicketLoadingImpl;
}

/// @nodoc
abstract class _$$SupportTicketSuccessImplCopyWith<$Res> {
  factory _$$SupportTicketSuccessImplCopyWith(
    _$SupportTicketSuccessImpl value,
    $Res Function(_$SupportTicketSuccessImpl) then,
  ) = __$$SupportTicketSuccessImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupportTicketSuccessImplCopyWithImpl<$Res>
    extends _$SupportTicketStateCopyWithImpl<$Res, _$SupportTicketSuccessImpl>
    implements _$$SupportTicketSuccessImplCopyWith<$Res> {
  __$$SupportTicketSuccessImplCopyWithImpl(
    _$SupportTicketSuccessImpl _value,
    $Res Function(_$SupportTicketSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupportTicketSuccessImpl implements SupportTicketSuccess {
  const _$SupportTicketSuccessImpl();

  @override
  String toString() {
    return 'SupportTicketState.success()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportTicketSuccessImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) failure,
  }) {
    return success();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? failure,
  }) {
    return success?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? failure,
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
    required TResult Function(SupportTicketIdle value) idle,
    required TResult Function(SupportTicketLoading value) loading,
    required TResult Function(SupportTicketSuccess value) success,
    required TResult Function(SupportTicketFailure value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupportTicketIdle value)? idle,
    TResult? Function(SupportTicketLoading value)? loading,
    TResult? Function(SupportTicketSuccess value)? success,
    TResult? Function(SupportTicketFailure value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupportTicketIdle value)? idle,
    TResult Function(SupportTicketLoading value)? loading,
    TResult Function(SupportTicketSuccess value)? success,
    TResult Function(SupportTicketFailure value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SupportTicketSuccess implements SupportTicketState {
  const factory SupportTicketSuccess() = _$SupportTicketSuccessImpl;
}

/// @nodoc
abstract class _$$SupportTicketFailureImplCopyWith<$Res> {
  factory _$$SupportTicketFailureImplCopyWith(
    _$SupportTicketFailureImpl value,
    $Res Function(_$SupportTicketFailureImpl) then,
  ) = __$$SupportTicketFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SupportTicketFailureImplCopyWithImpl<$Res>
    extends _$SupportTicketStateCopyWithImpl<$Res, _$SupportTicketFailureImpl>
    implements _$$SupportTicketFailureImplCopyWith<$Res> {
  __$$SupportTicketFailureImplCopyWithImpl(
    _$SupportTicketFailureImpl _value,
    $Res Function(_$SupportTicketFailureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null}) {
    return _then(
      _$SupportTicketFailureImpl(
        null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SupportTicketFailureImpl implements SupportTicketFailure {
  const _$SupportTicketFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SupportTicketState.failure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupportTicketFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupportTicketFailureImplCopyWith<_$SupportTicketFailureImpl>
  get copyWith =>
      __$$SupportTicketFailureImplCopyWithImpl<_$SupportTicketFailureImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function() success,
    required TResult Function(String message) failure,
  }) {
    return failure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? loading,
    TResult? Function()? success,
    TResult? Function(String message)? failure,
  }) {
    return failure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function()? success,
    TResult Function(String message)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupportTicketIdle value) idle,
    required TResult Function(SupportTicketLoading value) loading,
    required TResult Function(SupportTicketSuccess value) success,
    required TResult Function(SupportTicketFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupportTicketIdle value)? idle,
    TResult? Function(SupportTicketLoading value)? loading,
    TResult? Function(SupportTicketSuccess value)? success,
    TResult? Function(SupportTicketFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupportTicketIdle value)? idle,
    TResult Function(SupportTicketLoading value)? loading,
    TResult Function(SupportTicketSuccess value)? success,
    TResult Function(SupportTicketFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class SupportTicketFailure implements SupportTicketState {
  const factory SupportTicketFailure(final String message) =
      _$SupportTicketFailureImpl;

  String get message;

  /// Create a copy of SupportTicketState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupportTicketFailureImplCopyWith<_$SupportTicketFailureImpl>
  get copyWith => throw _privateConstructorUsedError;
}
