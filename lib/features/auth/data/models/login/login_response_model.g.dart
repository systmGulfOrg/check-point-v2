// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      id: json['id'] as String?,
      employeeId: json['employeeId'] as String?,
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
      branchId: (json['branchId'] as num?)?.toInt(),
      branchName: json['branchName'] as String?,
      imageUrl: json['imageUrl'] as String?,
      tenantStatus: json['tenantStatus'] as String?,
      trialEndsAt: json['trialEndsAt'] == null
          ? null
          : DateTime.parse(json['trialEndsAt'] as String),
      seatLimit: (json['seatLimit'] as num?)?.toInt(),
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
      'branchId': instance.branchId,
      'branchName': instance.branchName,
      'imageUrl': instance.imageUrl,
      'tenantStatus': instance.tenantStatus,
      'trialEndsAt': instance.trialEndsAt?.toIso8601String(),
      'seatLimit': instance.seatLimit,
    };
