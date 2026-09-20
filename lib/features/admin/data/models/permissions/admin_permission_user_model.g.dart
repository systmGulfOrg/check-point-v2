// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_permission_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminPermissionUserModelImpl _$$AdminPermissionUserModelImplFromJson(
  Map<String, dynamic> json,
) => _$AdminPermissionUserModelImpl(
  id: json['id'] as String,
  role: json['role'] as String?,
  roles:
      (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isActive: json['isActive'] as bool? ?? true,
  lastLoginAt: json['lastLoginAt'] == null
      ? null
      : DateTime.parse(json['lastLoginAt'] as String),
  customPermissions:
      (json['customPermissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  permissions:
      (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$$AdminPermissionUserModelImplToJson(
  _$AdminPermissionUserModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'role': instance.role,
  'roles': instance.roles,
  'isActive': instance.isActive,
  'lastLoginAt': instance.lastLoginAt?.toIso8601String(),
  'customPermissions': instance.customPermissions,
  'permissions': instance.permissions,
};
