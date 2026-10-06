// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    AuthUserModel(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      role: json['role'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      employeeId: json['employeeId'] as String?,
      branchId: json['branchId'],
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'role': instance.role,
      'roles': instance.roles,
      'employeeId': instance.employeeId,
      'branchId': instance.branchId,
      'permissions': instance.permissions,
    };

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      id: json['id'] as String?,
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      role: json['role'] as String?,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      permissions: (json['permissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      token: json['token'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      expiresIn: json['expiresIn'],
      user: json['user'] == null
          ? null
          : AuthUserModel.fromJson(json['user'] as Map<String, dynamic>),
      branchId: json['branchId'],
      branchName: json['branchName'] as String?,
      employeeId: json['employeeId'] as String?,
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'employeeId': instance.employeeId,
      'userName': instance.userName,
      'name': instance.name,
      'role': instance.role,
      'roles': instance.roles,
      'permissions': instance.permissions,
      'token': instance.token,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'expiresIn': instance.expiresIn,
      'user': instance.user,
      'branchId': instance.branchId,
      'branchName': instance.branchName,
    };
