// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_employee_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddEmployeeRequestBody _$AddEmployeeRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddEmployeeRequestBody(
  name: json['name'] as String,
  username: json['username'] as String,
  password: json['password'] as String,
  position: json['position'] as String,
  mobileId: json['mobileId'] as String,
  role: json['role'] as String,
  departmentId: (json['departmentId'] as num?)?.toInt(),
  branchId: (json['branchId'] as num?)?.toInt(),
  siteId: json['siteId'] as String?,
  shiftId: (json['shiftId'] as num?)?.toInt(),
  attendanceLocationType: json['attendanceLocationType'] as String?,
  branchIds: (json['branchIds'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  siteIds: (json['siteIds'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
  deviceToken: (json['deviceToken'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  nationalId: json['nationalId'] as String?,
  employeeCode: json['employeeCode'] as String?,
  canAddAttendance: json['canAddAttendance'] as bool?,
  canAddPlan: json['canAddPlan'] as bool?,
  leaveBalance: (json['leaveBalance'] as num?)?.toInt(),
  workSystem: json['workSystem'] as String?,
  remoteWorkPolicyId: json['remoteWorkPolicyId'] as String?,
  directManagerId: json['directManagerId'] as String?,
  managerId: json['managerId'] as String?,
);

Map<String, dynamic> _$AddEmployeeRequestBodyToJson(
  AddEmployeeRequestBody instance,
) => <String, dynamic>{
  'name': instance.name,
  'username': instance.username,
  'password': instance.password,
  'position': instance.position,
  'mobileId': instance.mobileId,
  'role': instance.role,
  'roles': instance.roles,
  'departmentId': instance.departmentId,
  'branchId': instance.branchId,
  'siteId': instance.siteId,
  'shiftId': instance.shiftId,
  'attendanceLocationType': instance.attendanceLocationType,
  'branchIds': instance.branchIds,
  'siteIds': instance.siteIds,
  'deviceToken': instance.deviceToken,
  'phone': instance.phone,
  'email': instance.email,
  'nationalId': instance.nationalId,
  'employeeCode': instance.employeeCode,
  'canAddAttendance': instance.canAddAttendance,
  'canAddPlan': instance.canAddPlan,
  'leaveBalance': instance.leaveBalance,
  'workSystem': instance.workSystem,
  'remoteWorkPolicyId': instance.remoteWorkPolicyId,
  'directManagerId': instance.directManagerId,
  'managerId': instance.managerId,
};
