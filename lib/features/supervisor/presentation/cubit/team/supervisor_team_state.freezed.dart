// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'supervisor_team_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SupervisorTeamState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> members) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> members)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> members)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupervisorTeamInitial value) initial,
    required TResult Function(SupervisorTeamLoading value) loading,
    required TResult Function(SupervisorTeamSuccess value) success,
    required TResult Function(SupervisorTeamError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorTeamInitial value)? initial,
    TResult? Function(SupervisorTeamLoading value)? loading,
    TResult? Function(SupervisorTeamSuccess value)? success,
    TResult? Function(SupervisorTeamError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorTeamInitial value)? initial,
    TResult Function(SupervisorTeamLoading value)? loading,
    TResult Function(SupervisorTeamSuccess value)? success,
    TResult Function(SupervisorTeamError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SupervisorTeamStateCopyWith<$Res> {
  factory $SupervisorTeamStateCopyWith(
    SupervisorTeamState value,
    $Res Function(SupervisorTeamState) then,
  ) = _$SupervisorTeamStateCopyWithImpl<$Res, SupervisorTeamState>;
}

/// @nodoc
class _$SupervisorTeamStateCopyWithImpl<$Res, $Val extends SupervisorTeamState>
    implements $SupervisorTeamStateCopyWith<$Res> {
  _$SupervisorTeamStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SupervisorTeamInitialImplCopyWith<$Res> {
  factory _$$SupervisorTeamInitialImplCopyWith(
    _$SupervisorTeamInitialImpl value,
    $Res Function(_$SupervisorTeamInitialImpl) then,
  ) = __$$SupervisorTeamInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupervisorTeamInitialImplCopyWithImpl<$Res>
    extends _$SupervisorTeamStateCopyWithImpl<$Res, _$SupervisorTeamInitialImpl>
    implements _$$SupervisorTeamInitialImplCopyWith<$Res> {
  __$$SupervisorTeamInitialImplCopyWithImpl(
    _$SupervisorTeamInitialImpl _value,
    $Res Function(_$SupervisorTeamInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupervisorTeamInitialImpl implements SupervisorTeamInitial {
  const _$SupervisorTeamInitialImpl();

  @override
  String toString() {
    return 'SupervisorTeamState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorTeamInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> members) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> members)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> members)? success,
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
    required TResult Function(SupervisorTeamInitial value) initial,
    required TResult Function(SupervisorTeamLoading value) loading,
    required TResult Function(SupervisorTeamSuccess value) success,
    required TResult Function(SupervisorTeamError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorTeamInitial value)? initial,
    TResult? Function(SupervisorTeamLoading value)? loading,
    TResult? Function(SupervisorTeamSuccess value)? success,
    TResult? Function(SupervisorTeamError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorTeamInitial value)? initial,
    TResult Function(SupervisorTeamLoading value)? loading,
    TResult Function(SupervisorTeamSuccess value)? success,
    TResult Function(SupervisorTeamError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SupervisorTeamInitial implements SupervisorTeamState {
  const factory SupervisorTeamInitial() = _$SupervisorTeamInitialImpl;
}

/// @nodoc
abstract class _$$SupervisorTeamLoadingImplCopyWith<$Res> {
  factory _$$SupervisorTeamLoadingImplCopyWith(
    _$SupervisorTeamLoadingImpl value,
    $Res Function(_$SupervisorTeamLoadingImpl) then,
  ) = __$$SupervisorTeamLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SupervisorTeamLoadingImplCopyWithImpl<$Res>
    extends _$SupervisorTeamStateCopyWithImpl<$Res, _$SupervisorTeamLoadingImpl>
    implements _$$SupervisorTeamLoadingImplCopyWith<$Res> {
  __$$SupervisorTeamLoadingImplCopyWithImpl(
    _$SupervisorTeamLoadingImpl _value,
    $Res Function(_$SupervisorTeamLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SupervisorTeamLoadingImpl implements SupervisorTeamLoading {
  const _$SupervisorTeamLoadingImpl();

  @override
  String toString() {
    return 'SupervisorTeamState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorTeamLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> members) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> members)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> members)? success,
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
    required TResult Function(SupervisorTeamInitial value) initial,
    required TResult Function(SupervisorTeamLoading value) loading,
    required TResult Function(SupervisorTeamSuccess value) success,
    required TResult Function(SupervisorTeamError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorTeamInitial value)? initial,
    TResult? Function(SupervisorTeamLoading value)? loading,
    TResult? Function(SupervisorTeamSuccess value)? success,
    TResult? Function(SupervisorTeamError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorTeamInitial value)? initial,
    TResult Function(SupervisorTeamLoading value)? loading,
    TResult Function(SupervisorTeamSuccess value)? success,
    TResult Function(SupervisorTeamError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SupervisorTeamLoading implements SupervisorTeamState {
  const factory SupervisorTeamLoading() = _$SupervisorTeamLoadingImpl;
}

/// @nodoc
abstract class _$$SupervisorTeamSuccessImplCopyWith<$Res> {
  factory _$$SupervisorTeamSuccessImplCopyWith(
    _$SupervisorTeamSuccessImpl value,
    $Res Function(_$SupervisorTeamSuccessImpl) then,
  ) = __$$SupervisorTeamSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<EmployeeModel> members});
}

/// @nodoc
class __$$SupervisorTeamSuccessImplCopyWithImpl<$Res>
    extends _$SupervisorTeamStateCopyWithImpl<$Res, _$SupervisorTeamSuccessImpl>
    implements _$$SupervisorTeamSuccessImplCopyWith<$Res> {
  __$$SupervisorTeamSuccessImplCopyWithImpl(
    _$SupervisorTeamSuccessImpl _value,
    $Res Function(_$SupervisorTeamSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? members = null}) {
    return _then(
      _$SupervisorTeamSuccessImpl(
        null == members
            ? _value._members
            : members // ignore: cast_nullable_to_non_nullable
                  as List<EmployeeModel>,
      ),
    );
  }
}

/// @nodoc

class _$SupervisorTeamSuccessImpl implements SupervisorTeamSuccess {
  const _$SupervisorTeamSuccessImpl(final List<EmployeeModel> members)
    : _members = members;

  final List<EmployeeModel> _members;
  @override
  List<EmployeeModel> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  String toString() {
    return 'SupervisorTeamState.success(members: $members)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorTeamSuccessImpl &&
            const DeepCollectionEquality().equals(other._members, _members));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_members));

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupervisorTeamSuccessImplCopyWith<_$SupervisorTeamSuccessImpl>
  get copyWith =>
      __$$SupervisorTeamSuccessImplCopyWithImpl<_$SupervisorTeamSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> members) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(members);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> members)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(members);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> members)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(members);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SupervisorTeamInitial value) initial,
    required TResult Function(SupervisorTeamLoading value) loading,
    required TResult Function(SupervisorTeamSuccess value) success,
    required TResult Function(SupervisorTeamError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorTeamInitial value)? initial,
    TResult? Function(SupervisorTeamLoading value)? loading,
    TResult? Function(SupervisorTeamSuccess value)? success,
    TResult? Function(SupervisorTeamError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorTeamInitial value)? initial,
    TResult Function(SupervisorTeamLoading value)? loading,
    TResult Function(SupervisorTeamSuccess value)? success,
    TResult Function(SupervisorTeamError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class SupervisorTeamSuccess implements SupervisorTeamState {
  const factory SupervisorTeamSuccess(final List<EmployeeModel> members) =
      _$SupervisorTeamSuccessImpl;

  List<EmployeeModel> get members;

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupervisorTeamSuccessImplCopyWith<_$SupervisorTeamSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SupervisorTeamErrorImplCopyWith<$Res> {
  factory _$$SupervisorTeamErrorImplCopyWith(
    _$SupervisorTeamErrorImpl value,
    $Res Function(_$SupervisorTeamErrorImpl) then,
  ) = __$$SupervisorTeamErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$SupervisorTeamErrorImplCopyWithImpl<$Res>
    extends _$SupervisorTeamStateCopyWithImpl<$Res, _$SupervisorTeamErrorImpl>
    implements _$$SupervisorTeamErrorImplCopyWith<$Res> {
  __$$SupervisorTeamErrorImplCopyWithImpl(
    _$SupervisorTeamErrorImpl _value,
    $Res Function(_$SupervisorTeamErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$SupervisorTeamErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$SupervisorTeamErrorImpl implements SupervisorTeamError {
  const _$SupervisorTeamErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'SupervisorTeamState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SupervisorTeamErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SupervisorTeamErrorImplCopyWith<_$SupervisorTeamErrorImpl> get copyWith =>
      __$$SupervisorTeamErrorImplCopyWithImpl<_$SupervisorTeamErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> members) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> members)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> members)? success,
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
    required TResult Function(SupervisorTeamInitial value) initial,
    required TResult Function(SupervisorTeamLoading value) loading,
    required TResult Function(SupervisorTeamSuccess value) success,
    required TResult Function(SupervisorTeamError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SupervisorTeamInitial value)? initial,
    TResult? Function(SupervisorTeamLoading value)? loading,
    TResult? Function(SupervisorTeamSuccess value)? success,
    TResult? Function(SupervisorTeamError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SupervisorTeamInitial value)? initial,
    TResult Function(SupervisorTeamLoading value)? loading,
    TResult Function(SupervisorTeamSuccess value)? success,
    TResult Function(SupervisorTeamError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SupervisorTeamError implements SupervisorTeamState {
  const factory SupervisorTeamError(final String messageKey) =
      _$SupervisorTeamErrorImpl;

  String get messageKey;

  /// Create a copy of SupervisorTeamState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SupervisorTeamErrorImplCopyWith<_$SupervisorTeamErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
