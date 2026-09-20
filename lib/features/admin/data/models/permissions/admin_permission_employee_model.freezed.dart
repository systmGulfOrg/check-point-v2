// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_permission_employee_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminPermissionEmployeeModel _$AdminPermissionEmployeeModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPermissionEmployeeModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPermissionEmployeeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get employeeCode => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  AdminPermissionUserModel get user => throw _privateConstructorUsedError;

  /// Serializes this AdminPermissionEmployeeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPermissionEmployeeModelCopyWith<AdminPermissionEmployeeModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPermissionEmployeeModelCopyWith<$Res> {
  factory $AdminPermissionEmployeeModelCopyWith(
    AdminPermissionEmployeeModel value,
    $Res Function(AdminPermissionEmployeeModel) then,
  ) =
      _$AdminPermissionEmployeeModelCopyWithImpl<
        $Res,
        AdminPermissionEmployeeModel
      >;
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    String? employeeCode,
    String? imageUrl,
    AdminPermissionUserModel user,
  });

  $AdminPermissionUserModelCopyWith<$Res> get user;
}

/// @nodoc
class _$AdminPermissionEmployeeModelCopyWithImpl<
  $Res,
  $Val extends AdminPermissionEmployeeModel
>
    implements $AdminPermissionEmployeeModelCopyWith<$Res> {
  _$AdminPermissionEmployeeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? employeeCode = freezed,
    Object? imageUrl = freezed,
    Object? user = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            employeeCode: freezed == employeeCode
                ? _value.employeeCode
                : employeeCode // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            user: null == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as AdminPermissionUserModel,
          )
          as $Val,
    );
  }

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminPermissionUserModelCopyWith<$Res> get user {
    return $AdminPermissionUserModelCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminPermissionEmployeeModelImplCopyWith<$Res>
    implements $AdminPermissionEmployeeModelCopyWith<$Res> {
  factory _$$AdminPermissionEmployeeModelImplCopyWith(
    _$AdminPermissionEmployeeModelImpl value,
    $Res Function(_$AdminPermissionEmployeeModelImpl) then,
  ) = __$$AdminPermissionEmployeeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String? email,
    String? employeeCode,
    String? imageUrl,
    AdminPermissionUserModel user,
  });

  @override
  $AdminPermissionUserModelCopyWith<$Res> get user;
}

/// @nodoc
class __$$AdminPermissionEmployeeModelImplCopyWithImpl<$Res>
    extends
        _$AdminPermissionEmployeeModelCopyWithImpl<
          $Res,
          _$AdminPermissionEmployeeModelImpl
        >
    implements _$$AdminPermissionEmployeeModelImplCopyWith<$Res> {
  __$$AdminPermissionEmployeeModelImplCopyWithImpl(
    _$AdminPermissionEmployeeModelImpl _value,
    $Res Function(_$AdminPermissionEmployeeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = freezed,
    Object? employeeCode = freezed,
    Object? imageUrl = freezed,
    Object? user = null,
  }) {
    return _then(
      _$AdminPermissionEmployeeModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        employeeCode: freezed == employeeCode
            ? _value.employeeCode
            : employeeCode // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        user: null == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as AdminPermissionUserModel,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPermissionEmployeeModelImpl extends _AdminPermissionEmployeeModel {
  const _$AdminPermissionEmployeeModelImpl({
    required this.id,
    required this.name,
    this.email,
    this.employeeCode,
    this.imageUrl,
    required this.user,
  }) : super._();

  factory _$AdminPermissionEmployeeModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AdminPermissionEmployeeModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String? email;
  @override
  final String? employeeCode;
  @override
  final String? imageUrl;
  @override
  final AdminPermissionUserModel user;

  @override
  String toString() {
    return 'AdminPermissionEmployeeModel(id: $id, name: $name, email: $email, employeeCode: $employeeCode, imageUrl: $imageUrl, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPermissionEmployeeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.employeeCode, employeeCode) ||
                other.employeeCode == employeeCode) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, employeeCode, imageUrl, user);

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPermissionEmployeeModelImplCopyWith<
    _$AdminPermissionEmployeeModelImpl
  >
  get copyWith =>
      __$$AdminPermissionEmployeeModelImplCopyWithImpl<
        _$AdminPermissionEmployeeModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPermissionEmployeeModelImplToJson(this);
  }
}

abstract class _AdminPermissionEmployeeModel
    extends AdminPermissionEmployeeModel {
  const factory _AdminPermissionEmployeeModel({
    required final String id,
    required final String name,
    final String? email,
    final String? employeeCode,
    final String? imageUrl,
    required final AdminPermissionUserModel user,
  }) = _$AdminPermissionEmployeeModelImpl;
  const _AdminPermissionEmployeeModel._() : super._();

  factory _AdminPermissionEmployeeModel.fromJson(Map<String, dynamic> json) =
      _$AdminPermissionEmployeeModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String? get email;
  @override
  String? get employeeCode;
  @override
  String? get imageUrl;
  @override
  AdminPermissionUserModel get user;

  /// Create a copy of AdminPermissionEmployeeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPermissionEmployeeModelImplCopyWith<
    _$AdminPermissionEmployeeModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
