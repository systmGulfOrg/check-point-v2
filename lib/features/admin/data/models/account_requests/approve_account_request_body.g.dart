// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproveAccountRequestBody _$ApproveAccountRequestBodyFromJson(
  Map<String, dynamic> json,
) => ApproveAccountRequestBody(
  userName: json['userName'] as String,
  password: json['password'] as String,
  status: json['status'] as String? ?? 'Approved',
  role: json['role'] as String?,
  roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
  departmentId: (json['departmentId'] as num?)?.toInt(),
  branchId: (json['branchId'] as num?)?.toInt(),
  shiftId: (json['shiftId'] as num?)?.toInt(),
  position: json['position'] as String?,
  employeeCode: json['employeeCode'] as String?,
  email: json['email'] as String?,
  workSystem: json['workSystem'] as String?,
  remoteWorkPolicyId: json['remoteWorkPolicyId'] as String?,
);

Map<String, dynamic> _$ApproveAccountRequestBodyToJson(
  ApproveAccountRequestBody instance,
) => <String, dynamic>{
  'status': instance.status,
  'userName': instance.userName,
  'password': instance.password,
  'role': instance.role,
  'roles': instance.roles,
  'departmentId': instance.departmentId,
  'branchId': instance.branchId,
  'shiftId': instance.shiftId,
  'position': instance.position,
  'employeeCode': instance.employeeCode,
  'email': instance.email,
  'workSystem': instance.workSystem,
  'remoteWorkPolicyId': instance.remoteWorkPolicyId,
};
