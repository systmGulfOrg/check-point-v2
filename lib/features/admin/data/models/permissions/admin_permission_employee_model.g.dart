// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_permission_employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminPermissionEmployeeModelImpl _$$AdminPermissionEmployeeModelImplFromJson(
  Map<String, dynamic> json,
) => _$AdminPermissionEmployeeModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String?,
  employeeCode: json['employeeCode'] as String?,
  imageUrl: json['imageUrl'] as String?,
  user: AdminPermissionUserModel.fromJson(json['user'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AdminPermissionEmployeeModelImplToJson(
  _$AdminPermissionEmployeeModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'employeeCode': instance.employeeCode,
  'imageUrl': instance.imageUrl,
  'user': instance.user,
};
