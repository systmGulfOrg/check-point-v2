// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_branches_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminBranchesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BranchModel> branches) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BranchModel> branches)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BranchModel> branches)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminBranchesInitial value) initial,
    required TResult Function(AdminBranchesLoading value) loading,
    required TResult Function(AdminBranchesSuccess value) success,
    required TResult Function(AdminBranchesError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminBranchesInitial value)? initial,
    TResult? Function(AdminBranchesLoading value)? loading,
    TResult? Function(AdminBranchesSuccess value)? success,
    TResult? Function(AdminBranchesError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminBranchesInitial value)? initial,
    TResult Function(AdminBranchesLoading value)? loading,
    TResult Function(AdminBranchesSuccess value)? success,
    TResult Function(AdminBranchesError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminBranchesStateCopyWith<$Res> {
  factory $AdminBranchesStateCopyWith(
    AdminBranchesState value,
    $Res Function(AdminBranchesState) then,
  ) = _$AdminBranchesStateCopyWithImpl<$Res, AdminBranchesState>;
}

/// @nodoc
class _$AdminBranchesStateCopyWithImpl<$Res, $Val extends AdminBranchesState>
    implements $AdminBranchesStateCopyWith<$Res> {
  _$AdminBranchesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminBranchesInitialImplCopyWith<$Res> {
  factory _$$AdminBranchesInitialImplCopyWith(
    _$AdminBranchesInitialImpl value,
    $Res Function(_$AdminBranchesInitialImpl) then,
  ) = __$$AdminBranchesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminBranchesInitialImplCopyWithImpl<$Res>
    extends _$AdminBranchesStateCopyWithImpl<$Res, _$AdminBranchesInitialImpl>
    implements _$$AdminBranchesInitialImplCopyWith<$Res> {
  __$$AdminBranchesInitialImplCopyWithImpl(
    _$AdminBranchesInitialImpl _value,
    $Res Function(_$AdminBranchesInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminBranchesInitialImpl implements AdminBranchesInitial {
  const _$AdminBranchesInitialImpl();

  @override
  String toString() {
    return 'AdminBranchesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminBranchesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BranchModel> branches) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BranchModel> branches)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BranchModel> branches)? success,
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
    required TResult Function(AdminBranchesInitial value) initial,
    required TResult Function(AdminBranchesLoading value) loading,
    required TResult Function(AdminBranchesSuccess value) success,
    required TResult Function(AdminBranchesError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminBranchesInitial value)? initial,
    TResult? Function(AdminBranchesLoading value)? loading,
    TResult? Function(AdminBranchesSuccess value)? success,
    TResult? Function(AdminBranchesError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminBranchesInitial value)? initial,
    TResult Function(AdminBranchesLoading value)? loading,
    TResult Function(AdminBranchesSuccess value)? success,
    TResult Function(AdminBranchesError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AdminBranchesInitial implements AdminBranchesState {
  const factory AdminBranchesInitial() = _$AdminBranchesInitialImpl;
}

/// @nodoc
abstract class _$$AdminBranchesLoadingImplCopyWith<$Res> {
  factory _$$AdminBranchesLoadingImplCopyWith(
    _$AdminBranchesLoadingImpl value,
    $Res Function(_$AdminBranchesLoadingImpl) then,
  ) = __$$AdminBranchesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminBranchesLoadingImplCopyWithImpl<$Res>
    extends _$AdminBranchesStateCopyWithImpl<$Res, _$AdminBranchesLoadingImpl>
    implements _$$AdminBranchesLoadingImplCopyWith<$Res> {
  __$$AdminBranchesLoadingImplCopyWithImpl(
    _$AdminBranchesLoadingImpl _value,
    $Res Function(_$AdminBranchesLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminBranchesLoadingImpl implements AdminBranchesLoading {
  const _$AdminBranchesLoadingImpl();

  @override
  String toString() {
    return 'AdminBranchesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminBranchesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BranchModel> branches) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BranchModel> branches)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BranchModel> branches)? success,
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
    required TResult Function(AdminBranchesInitial value) initial,
    required TResult Function(AdminBranchesLoading value) loading,
    required TResult Function(AdminBranchesSuccess value) success,
    required TResult Function(AdminBranchesError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminBranchesInitial value)? initial,
    TResult? Function(AdminBranchesLoading value)? loading,
    TResult? Function(AdminBranchesSuccess value)? success,
    TResult? Function(AdminBranchesError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminBranchesInitial value)? initial,
    TResult Function(AdminBranchesLoading value)? loading,
    TResult Function(AdminBranchesSuccess value)? success,
    TResult Function(AdminBranchesError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AdminBranchesLoading implements AdminBranchesState {
  const factory AdminBranchesLoading() = _$AdminBranchesLoadingImpl;
}

/// @nodoc
abstract class _$$AdminBranchesSuccessImplCopyWith<$Res> {
  factory _$$AdminBranchesSuccessImplCopyWith(
    _$AdminBranchesSuccessImpl value,
    $Res Function(_$AdminBranchesSuccessImpl) then,
  ) = __$$AdminBranchesSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<BranchModel> branches});
}

/// @nodoc
class __$$AdminBranchesSuccessImplCopyWithImpl<$Res>
    extends _$AdminBranchesStateCopyWithImpl<$Res, _$AdminBranchesSuccessImpl>
    implements _$$AdminBranchesSuccessImplCopyWith<$Res> {
  __$$AdminBranchesSuccessImplCopyWithImpl(
    _$AdminBranchesSuccessImpl _value,
    $Res Function(_$AdminBranchesSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? branches = null}) {
    return _then(
      _$AdminBranchesSuccessImpl(
        null == branches
            ? _value._branches
            : branches // ignore: cast_nullable_to_non_nullable
                  as List<BranchModel>,
      ),
    );
  }
}

/// @nodoc

class _$AdminBranchesSuccessImpl implements AdminBranchesSuccess {
  const _$AdminBranchesSuccessImpl(final List<BranchModel> branches)
    : _branches = branches;

  final List<BranchModel> _branches;
  @override
  List<BranchModel> get branches {
    if (_branches is EqualUnmodifiableListView) return _branches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_branches);
  }

  @override
  String toString() {
    return 'AdminBranchesState.success(branches: $branches)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminBranchesSuccessImpl &&
            const DeepCollectionEquality().equals(other._branches, _branches));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_branches));

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminBranchesSuccessImplCopyWith<_$AdminBranchesSuccessImpl>
  get copyWith =>
      __$$AdminBranchesSuccessImplCopyWithImpl<_$AdminBranchesSuccessImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BranchModel> branches) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(branches);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BranchModel> branches)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(branches);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BranchModel> branches)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(branches);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminBranchesInitial value) initial,
    required TResult Function(AdminBranchesLoading value) loading,
    required TResult Function(AdminBranchesSuccess value) success,
    required TResult Function(AdminBranchesError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminBranchesInitial value)? initial,
    TResult? Function(AdminBranchesLoading value)? loading,
    TResult? Function(AdminBranchesSuccess value)? success,
    TResult? Function(AdminBranchesError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminBranchesInitial value)? initial,
    TResult Function(AdminBranchesLoading value)? loading,
    TResult Function(AdminBranchesSuccess value)? success,
    TResult Function(AdminBranchesError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AdminBranchesSuccess implements AdminBranchesState {
  const factory AdminBranchesSuccess(final List<BranchModel> branches) =
      _$AdminBranchesSuccessImpl;

  List<BranchModel> get branches;

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminBranchesSuccessImplCopyWith<_$AdminBranchesSuccessImpl>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminBranchesErrorImplCopyWith<$Res> {
  factory _$$AdminBranchesErrorImplCopyWith(
    _$AdminBranchesErrorImpl value,
    $Res Function(_$AdminBranchesErrorImpl) then,
  ) = __$$AdminBranchesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AdminBranchesErrorImplCopyWithImpl<$Res>
    extends _$AdminBranchesStateCopyWithImpl<$Res, _$AdminBranchesErrorImpl>
    implements _$$AdminBranchesErrorImplCopyWith<$Res> {
  __$$AdminBranchesErrorImplCopyWithImpl(
    _$AdminBranchesErrorImpl _value,
    $Res Function(_$AdminBranchesErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AdminBranchesErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminBranchesErrorImpl implements AdminBranchesError {
  const _$AdminBranchesErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AdminBranchesState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminBranchesErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminBranchesErrorImplCopyWith<_$AdminBranchesErrorImpl> get copyWith =>
      __$$AdminBranchesErrorImplCopyWithImpl<_$AdminBranchesErrorImpl>(
        this,
        _$identity,
      );

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<BranchModel> branches) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<BranchModel> branches)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<BranchModel> branches)? success,
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
    required TResult Function(AdminBranchesInitial value) initial,
    required TResult Function(AdminBranchesLoading value) loading,
    required TResult Function(AdminBranchesSuccess value) success,
    required TResult Function(AdminBranchesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminBranchesInitial value)? initial,
    TResult? Function(AdminBranchesLoading value)? loading,
    TResult? Function(AdminBranchesSuccess value)? success,
    TResult? Function(AdminBranchesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminBranchesInitial value)? initial,
    TResult Function(AdminBranchesLoading value)? loading,
    TResult Function(AdminBranchesSuccess value)? success,
    TResult Function(AdminBranchesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AdminBranchesError implements AdminBranchesState {
  const factory AdminBranchesError(final String messageKey) =
      _$AdminBranchesErrorImpl;

  String get messageKey;

  /// Create a copy of AdminBranchesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminBranchesErrorImplCopyWith<_$AdminBranchesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
