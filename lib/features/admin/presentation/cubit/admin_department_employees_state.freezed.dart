// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_department_employees_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$AdminDepartmentEmployeesState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> employees) success,
    required TResult Function(String messageKey) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> employees)? success,
    TResult? Function(String messageKey)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> employees)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminDepartmentEmployeesInitial value) initial,
    required TResult Function(AdminDepartmentEmployeesLoading value) loading,
    required TResult Function(AdminDepartmentEmployeesSuccess value) success,
    required TResult Function(AdminDepartmentEmployeesError value) error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult? Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult? Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult? Function(AdminDepartmentEmployeesError value)? error,
  }) => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult Function(AdminDepartmentEmployeesError value)? error,
    required TResult orElse(),
  }) => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDepartmentEmployeesStateCopyWith<$Res> {
  factory $AdminDepartmentEmployeesStateCopyWith(
    AdminDepartmentEmployeesState value,
    $Res Function(AdminDepartmentEmployeesState) then,
  ) =
      _$AdminDepartmentEmployeesStateCopyWithImpl<
        $Res,
        AdminDepartmentEmployeesState
      >;
}

/// @nodoc
class _$AdminDepartmentEmployeesStateCopyWithImpl<
  $Res,
  $Val extends AdminDepartmentEmployeesState
>
    implements $AdminDepartmentEmployeesStateCopyWith<$Res> {
  _$AdminDepartmentEmployeesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$AdminDepartmentEmployeesInitialImplCopyWith<$Res> {
  factory _$$AdminDepartmentEmployeesInitialImplCopyWith(
    _$AdminDepartmentEmployeesInitialImpl value,
    $Res Function(_$AdminDepartmentEmployeesInitialImpl) then,
  ) = __$$AdminDepartmentEmployeesInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminDepartmentEmployeesInitialImplCopyWithImpl<$Res>
    extends
        _$AdminDepartmentEmployeesStateCopyWithImpl<
          $Res,
          _$AdminDepartmentEmployeesInitialImpl
        >
    implements _$$AdminDepartmentEmployeesInitialImplCopyWith<$Res> {
  __$$AdminDepartmentEmployeesInitialImplCopyWithImpl(
    _$AdminDepartmentEmployeesInitialImpl _value,
    $Res Function(_$AdminDepartmentEmployeesInitialImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminDepartmentEmployeesInitialImpl
    implements AdminDepartmentEmployeesInitial {
  const _$AdminDepartmentEmployeesInitialImpl();

  @override
  String toString() {
    return 'AdminDepartmentEmployeesState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDepartmentEmployeesInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> employees) success,
    required TResult Function(String messageKey) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> employees)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> employees)? success,
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
    required TResult Function(AdminDepartmentEmployeesInitial value) initial,
    required TResult Function(AdminDepartmentEmployeesLoading value) loading,
    required TResult Function(AdminDepartmentEmployeesSuccess value) success,
    required TResult Function(AdminDepartmentEmployeesError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult? Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult? Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult? Function(AdminDepartmentEmployeesError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult Function(AdminDepartmentEmployeesError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AdminDepartmentEmployeesInitial
    implements AdminDepartmentEmployeesState {
  const factory AdminDepartmentEmployeesInitial() =
      _$AdminDepartmentEmployeesInitialImpl;
}

/// @nodoc
abstract class _$$AdminDepartmentEmployeesLoadingImplCopyWith<$Res> {
  factory _$$AdminDepartmentEmployeesLoadingImplCopyWith(
    _$AdminDepartmentEmployeesLoadingImpl value,
    $Res Function(_$AdminDepartmentEmployeesLoadingImpl) then,
  ) = __$$AdminDepartmentEmployeesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AdminDepartmentEmployeesLoadingImplCopyWithImpl<$Res>
    extends
        _$AdminDepartmentEmployeesStateCopyWithImpl<
          $Res,
          _$AdminDepartmentEmployeesLoadingImpl
        >
    implements _$$AdminDepartmentEmployeesLoadingImplCopyWith<$Res> {
  __$$AdminDepartmentEmployeesLoadingImplCopyWithImpl(
    _$AdminDepartmentEmployeesLoadingImpl _value,
    $Res Function(_$AdminDepartmentEmployeesLoadingImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AdminDepartmentEmployeesLoadingImpl
    implements AdminDepartmentEmployeesLoading {
  const _$AdminDepartmentEmployeesLoadingImpl();

  @override
  String toString() {
    return 'AdminDepartmentEmployeesState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDepartmentEmployeesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> employees) success,
    required TResult Function(String messageKey) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> employees)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> employees)? success,
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
    required TResult Function(AdminDepartmentEmployeesInitial value) initial,
    required TResult Function(AdminDepartmentEmployeesLoading value) loading,
    required TResult Function(AdminDepartmentEmployeesSuccess value) success,
    required TResult Function(AdminDepartmentEmployeesError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult? Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult? Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult? Function(AdminDepartmentEmployeesError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult Function(AdminDepartmentEmployeesError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AdminDepartmentEmployeesLoading
    implements AdminDepartmentEmployeesState {
  const factory AdminDepartmentEmployeesLoading() =
      _$AdminDepartmentEmployeesLoadingImpl;
}

/// @nodoc
abstract class _$$AdminDepartmentEmployeesSuccessImplCopyWith<$Res> {
  factory _$$AdminDepartmentEmployeesSuccessImplCopyWith(
    _$AdminDepartmentEmployeesSuccessImpl value,
    $Res Function(_$AdminDepartmentEmployeesSuccessImpl) then,
  ) = __$$AdminDepartmentEmployeesSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<EmployeeModel> employees});
}

/// @nodoc
class __$$AdminDepartmentEmployeesSuccessImplCopyWithImpl<$Res>
    extends
        _$AdminDepartmentEmployeesStateCopyWithImpl<
          $Res,
          _$AdminDepartmentEmployeesSuccessImpl
        >
    implements _$$AdminDepartmentEmployeesSuccessImplCopyWith<$Res> {
  __$$AdminDepartmentEmployeesSuccessImplCopyWithImpl(
    _$AdminDepartmentEmployeesSuccessImpl _value,
    $Res Function(_$AdminDepartmentEmployeesSuccessImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? employees = null}) {
    return _then(
      _$AdminDepartmentEmployeesSuccessImpl(
        null == employees
            ? _value._employees
            : employees // ignore: cast_nullable_to_non_nullable
                  as List<EmployeeModel>,
      ),
    );
  }
}

/// @nodoc

class _$AdminDepartmentEmployeesSuccessImpl
    implements AdminDepartmentEmployeesSuccess {
  const _$AdminDepartmentEmployeesSuccessImpl(
    final List<EmployeeModel> employees,
  ) : _employees = employees;

  final List<EmployeeModel> _employees;
  @override
  List<EmployeeModel> get employees {
    if (_employees is EqualUnmodifiableListView) return _employees;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_employees);
  }

  @override
  String toString() {
    return 'AdminDepartmentEmployeesState.success(employees: $employees)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDepartmentEmployeesSuccessImpl &&
            const DeepCollectionEquality().equals(
              other._employees,
              _employees,
            ));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_employees));

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDepartmentEmployeesSuccessImplCopyWith<
    _$AdminDepartmentEmployeesSuccessImpl
  >
  get copyWith =>
      __$$AdminDepartmentEmployeesSuccessImplCopyWithImpl<
        _$AdminDepartmentEmployeesSuccessImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> employees) success,
    required TResult Function(String messageKey) error,
  }) {
    return success(employees);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> employees)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return success?.call(employees);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> employees)? success,
    TResult Function(String messageKey)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(employees);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AdminDepartmentEmployeesInitial value) initial,
    required TResult Function(AdminDepartmentEmployeesLoading value) loading,
    required TResult Function(AdminDepartmentEmployeesSuccess value) success,
    required TResult Function(AdminDepartmentEmployeesError value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult? Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult? Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult? Function(AdminDepartmentEmployeesError value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult Function(AdminDepartmentEmployeesError value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class AdminDepartmentEmployeesSuccess
    implements AdminDepartmentEmployeesState {
  const factory AdminDepartmentEmployeesSuccess(
    final List<EmployeeModel> employees,
  ) = _$AdminDepartmentEmployeesSuccessImpl;

  List<EmployeeModel> get employees;

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDepartmentEmployeesSuccessImplCopyWith<
    _$AdminDepartmentEmployeesSuccessImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AdminDepartmentEmployeesErrorImplCopyWith<$Res> {
  factory _$$AdminDepartmentEmployeesErrorImplCopyWith(
    _$AdminDepartmentEmployeesErrorImpl value,
    $Res Function(_$AdminDepartmentEmployeesErrorImpl) then,
  ) = __$$AdminDepartmentEmployeesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String messageKey});
}

/// @nodoc
class __$$AdminDepartmentEmployeesErrorImplCopyWithImpl<$Res>
    extends
        _$AdminDepartmentEmployeesStateCopyWithImpl<
          $Res,
          _$AdminDepartmentEmployeesErrorImpl
        >
    implements _$$AdminDepartmentEmployeesErrorImplCopyWith<$Res> {
  __$$AdminDepartmentEmployeesErrorImplCopyWithImpl(
    _$AdminDepartmentEmployeesErrorImpl _value,
    $Res Function(_$AdminDepartmentEmployeesErrorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? messageKey = null}) {
    return _then(
      _$AdminDepartmentEmployeesErrorImpl(
        null == messageKey
            ? _value.messageKey
            : messageKey // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc

class _$AdminDepartmentEmployeesErrorImpl
    implements AdminDepartmentEmployeesError {
  const _$AdminDepartmentEmployeesErrorImpl(this.messageKey);

  @override
  final String messageKey;

  @override
  String toString() {
    return 'AdminDepartmentEmployeesState.error(messageKey: $messageKey)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDepartmentEmployeesErrorImpl &&
            (identical(other.messageKey, messageKey) ||
                other.messageKey == messageKey));
  }

  @override
  int get hashCode => Object.hash(runtimeType, messageKey);

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDepartmentEmployeesErrorImplCopyWith<
    _$AdminDepartmentEmployeesErrorImpl
  >
  get copyWith =>
      __$$AdminDepartmentEmployeesErrorImplCopyWithImpl<
        _$AdminDepartmentEmployeesErrorImpl
      >(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<EmployeeModel> employees) success,
    required TResult Function(String messageKey) error,
  }) {
    return error(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<EmployeeModel> employees)? success,
    TResult? Function(String messageKey)? error,
  }) {
    return error?.call(messageKey);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<EmployeeModel> employees)? success,
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
    required TResult Function(AdminDepartmentEmployeesInitial value) initial,
    required TResult Function(AdminDepartmentEmployeesLoading value) loading,
    required TResult Function(AdminDepartmentEmployeesSuccess value) success,
    required TResult Function(AdminDepartmentEmployeesError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult? Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult? Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult? Function(AdminDepartmentEmployeesError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AdminDepartmentEmployeesInitial value)? initial,
    TResult Function(AdminDepartmentEmployeesLoading value)? loading,
    TResult Function(AdminDepartmentEmployeesSuccess value)? success,
    TResult Function(AdminDepartmentEmployeesError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AdminDepartmentEmployeesError
    implements AdminDepartmentEmployeesState {
  const factory AdminDepartmentEmployeesError(final String messageKey) =
      _$AdminDepartmentEmployeesErrorImpl;

  String get messageKey;

  /// Create a copy of AdminDepartmentEmployeesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDepartmentEmployeesErrorImplCopyWith<
    _$AdminDepartmentEmployeesErrorImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
