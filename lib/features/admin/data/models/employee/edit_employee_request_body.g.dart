// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_employee_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditEmployeeRequestBody _$EditEmployeeRequestBodyFromJson(
  Map<String, dynamic> json,
) => EditEmployeeRequestBody(
  name: json['name'] as String?,
  userName: json['username'] as String?,
  password: json['password'] as String?,
  position: json['position'] as String?,
  mobileId: json['mobileId'] as String?,
  role: json['role'] as String?,
  roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
  departmentId: (json['departmentId'] as num?)?.toInt(),
  branchId: (json['branchId'] as num?)?.toInt(),
  shiftId: (json['shiftId'] as num?)?.toInt(),
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  employeeCode: json['employeeCode'] as String?,
  canAddAttendance: json['canAddAttendance'] as bool?,
  canAddPlan: json['canAddPlan'] as bool?,
  deviceToken: (json['deviceToken'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  leaveBalance: (json['leaveBalance'] as num?)?.toInt(),
  workSystem: json['workSystem'] as String?,
  remoteWorkPolicyId: json['remoteWorkPolicyId'] as String?,
);

Map<String, dynamic> _$EditEmployeeRequestBodyToJson(
  EditEmployeeRequestBody instance,
) => <String, dynamic>{
  if (instance.name case final value?) 'name': value,
  if (instance.userName case final value?) 'username': value,
  if (instance.password case final value?) 'password': value,
  if (instance.position case final value?) 'position': value,
  if (instance.mobileId case final value?) 'mobileId': value,
  if (instance.role case final value?) 'role': value,
  if (instance.roles case final value?) 'roles': value,
  if (instance.departmentId case final value?) 'departmentId': value,
  if (instance.branchId case final value?) 'branchId': value,
  if (instance.shiftId case final value?) 'shiftId': value,
  if (instance.phone case final value?) 'phone': value,
  if (instance.email case final value?) 'email': value,
  if (instance.employeeCode case final value?) 'employeeCode': value,
  if (instance.canAddAttendance case final value?) 'canAddAttendance': value,
  if (instance.canAddPlan case final value?) 'canAddPlan': value,
  if (instance.deviceToken case final value?) 'deviceToken': value,
  if (instance.leaveBalance case final value?) 'leaveBalance': value,
  if (instance.workSystem case final value?) 'workSystem': value,
  if (instance.remoteWorkPolicyId case final value?)
    'remoteWorkPolicyId': value,
};
