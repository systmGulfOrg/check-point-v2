// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_permission_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AdminPermissionUserModel _$AdminPermissionUserModelFromJson(
  Map<String, dynamic> json,
) {
  return _AdminPermissionUserModel.fromJson(json);
}

/// @nodoc
mixin _$AdminPermissionUserModel {
  String get id => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;
  List<String> get roles => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  DateTime? get lastLoginAt => throw _privateConstructorUsedError;
  List<String> get customPermissions => throw _privateConstructorUsedError;
  List<String> get permissions => throw _privateConstructorUsedError;

  /// Serializes this AdminPermissionUserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminPermissionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminPermissionUserModelCopyWith<AdminPermissionUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminPermissionUserModelCopyWith<$Res> {
  factory $AdminPermissionUserModelCopyWith(
    AdminPermissionUserModel value,
    $Res Function(AdminPermissionUserModel) then,
  ) = _$AdminPermissionUserModelCopyWithImpl<$Res, AdminPermissionUserModel>;
  @useResult
  $Res call({
    String id,
    String? role,
    List<String> roles,
    bool isActive,
    DateTime? lastLoginAt,
    List<String> customPermissions,
    List<String> permissions,
  });
}

/// @nodoc
class _$AdminPermissionUserModelCopyWithImpl<
  $Res,
  $Val extends AdminPermissionUserModel
>
    implements $AdminPermissionUserModelCopyWith<$Res> {
  _$AdminPermissionUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminPermissionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = freezed,
    Object? roles = null,
    Object? isActive = null,
    Object? lastLoginAt = freezed,
    Object? customPermissions = null,
    Object? permissions = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            role: freezed == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String?,
            roles: null == roles
                ? _value.roles
                : roles // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            lastLoginAt: freezed == lastLoginAt
                ? _value.lastLoginAt
                : lastLoginAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            customPermissions: null == customPermissions
                ? _value.customPermissions
                : customPermissions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            permissions: null == permissions
                ? _value.permissions
                : permissions // ignore: cast_nullable_to_non_nullable
                      as List<String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminPermissionUserModelImplCopyWith<$Res>
    implements $AdminPermissionUserModelCopyWith<$Res> {
  factory _$$AdminPermissionUserModelImplCopyWith(
    _$AdminPermissionUserModelImpl value,
    $Res Function(_$AdminPermissionUserModelImpl) then,
  ) = __$$AdminPermissionUserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? role,
    List<String> roles,
    bool isActive,
    DateTime? lastLoginAt,
    List<String> customPermissions,
    List<String> permissions,
  });
}

/// @nodoc
class __$$AdminPermissionUserModelImplCopyWithImpl<$Res>
    extends
        _$AdminPermissionUserModelCopyWithImpl<
          $Res,
          _$AdminPermissionUserModelImpl
        >
    implements _$$AdminPermissionUserModelImplCopyWith<$Res> {
  __$$AdminPermissionUserModelImplCopyWithImpl(
    _$AdminPermissionUserModelImpl _value,
    $Res Function(_$AdminPermissionUserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminPermissionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? role = freezed,
    Object? roles = null,
    Object? isActive = null,
    Object? lastLoginAt = freezed,
    Object? customPermissions = null,
    Object? permissions = null,
  }) {
    return _then(
      _$AdminPermissionUserModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        role: freezed == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String?,
        roles: null == roles
            ? _value._roles
            : roles // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        lastLoginAt: freezed == lastLoginAt
            ? _value.lastLoginAt
            : lastLoginAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        customPermissions: null == customPermissions
            ? _value._customPermissions
            : customPermissions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        permissions: null == permissions
            ? _value._permissions
            : permissions // ignore: cast_nullable_to_non_nullable
                  as List<String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminPermissionUserModelImpl extends _AdminPermissionUserModel {
  const _$AdminPermissionUserModelImpl({
    required this.id,
    this.role,
    final List<String> roles = const [],
    this.isActive = true,
    this.lastLoginAt,
    final List<String> customPermissions = const [],
    final List<String> permissions = const [],
  }) : _roles = roles,
       _customPermissions = customPermissions,
       _permissions = permissions,
       super._();

  factory _$AdminPermissionUserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminPermissionUserModelImplFromJson(json);

  @override
  final String id;
  @override
  final String? role;
  final List<String> _roles;
  @override
  @JsonKey()
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  @JsonKey()
  final bool isActive;
  @override
  final DateTime? lastLoginAt;
  final List<String> _customPermissions;
  @override
  @JsonKey()
  List<String> get customPermissions {
    if (_customPermissions is EqualUnmodifiableListView)
      return _customPermissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customPermissions);
  }

  final List<String> _permissions;
  @override
  @JsonKey()
  List<String> get permissions {
    if (_permissions is EqualUnmodifiableListView) return _permissions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_permissions);
  }

  @override
  String toString() {
    return 'AdminPermissionUserModel(id: $id, role: $role, roles: $roles, isActive: $isActive, lastLoginAt: $lastLoginAt, customPermissions: $customPermissions, permissions: $permissions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminPermissionUserModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.lastLoginAt, lastLoginAt) ||
                other.lastLoginAt == lastLoginAt) &&
            const DeepCollectionEquality().equals(
              other._customPermissions,
              _customPermissions,
            ) &&
            const DeepCollectionEquality().equals(
              other._permissions,
              _permissions,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    role,
    const DeepCollectionEquality().hash(_roles),
    isActive,
    lastLoginAt,
    const DeepCollectionEquality().hash(_customPermissions),
    const DeepCollectionEquality().hash(_permissions),
  );

  /// Create a copy of AdminPermissionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminPermissionUserModelImplCopyWith<_$AdminPermissionUserModelImpl>
  get copyWith =>
      __$$AdminPermissionUserModelImplCopyWithImpl<
        _$AdminPermissionUserModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminPermissionUserModelImplToJson(this);
  }
}

abstract class _AdminPermissionUserModel extends AdminPermissionUserModel {
  const factory _AdminPermissionUserModel({
    required final String id,
    final String? role,
    final List<String> roles,
    final bool isActive,
    final DateTime? lastLoginAt,
    final List<String> customPermissions,
    final List<String> permissions,
  }) = _$AdminPermissionUserModelImpl;
  const _AdminPermissionUserModel._() : super._();

  factory _AdminPermissionUserModel.fromJson(Map<String, dynamic> json) =
      _$AdminPermissionUserModelImpl.fromJson;

  @override
  String get id;
  @override
  String? get role;
  @override
  List<String> get roles;
  @override
  bool get isActive;
  @override
  DateTime? get lastLoginAt;
  @override
  List<String> get customPermissions;
  @override
  List<String> get permissions;

  /// Create a copy of AdminPermissionUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminPermissionUserModelImplCopyWith<_$AdminPermissionUserModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
