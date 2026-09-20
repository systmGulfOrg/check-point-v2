// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) =>
    EmployeeModel(
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
      customPermissions: (json['customPermissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      position: json['position'] as String?,
      departmentName: json['departmentName'] as String?,
      departmentId: (json['departmentId'] as num?)?.toInt(),
      branchName: json['branchName'] as String?,
      branchId: (json['branchId'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String?,
      mobileId: json['mobileId'] as String?,
      deviceTokens: (json['deviceTokens'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      employeeCode: json['employeeCode'] as String?,
      canAddAttendance: json['canAddAttendance'] as bool?,
      canAddPlan: json['canAddPlan'] as bool?,
      shiftName: json['shiftName'] as String?,
      shiftId: (json['shiftId'] as num?)?.toInt(),
      workSystem: json['workSystem'] as String?,
      remoteWorkPolicyId: json['remoteWorkPolicyId'] as String?,
      workPolicy: json['workPolicy'] == null
          ? null
          : EmployeeWorkPolicyModel.fromJson(
              json['workPolicy'] as Map<String, dynamic>,
            ),
      todayWorkMode: json['todayWorkMode'] as String?,
      todayWorkDay: json['todayWorkDay'] as String?,
      todayIsWorkingDay: json['todayIsWorkingDay'] as bool?,
      todayWorkStart: json['todayWorkStart'] as String?,
      todayWorkEnd: json['todayWorkEnd'] as String?,
      todayAllowedDelayTime: (json['todayAllowedDelayTime'] as num?)?.toInt(),
      clockInTime: legacyApiValueToString(json['clockInTime']),
      clockOutTime: legacyApiValueToString(json['clockOutTime']),
      area: json['area'] as String?,
      leaveBalance: (json['leaveBalance'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userName': instance.userName,
      'name': instance.name,
      'role': instance.role,
      'roles': instance.roles,
      'permissions': instance.permissions,
      'customPermissions': instance.customPermissions,
      'position': instance.position,
      'departmentName': instance.departmentName,
      'departmentId': instance.departmentId,
      'branchName': instance.branchName,
      'branchId': instance.branchId,
      'imageUrl': instance.imageUrl,
      'mobileId': instance.mobileId,
      'deviceTokens': instance.deviceTokens,
      'phone': instance.phone,
      'email': instance.email,
      'employeeCode': instance.employeeCode,
      'canAddAttendance': instance.canAddAttendance,
      'canAddPlan': instance.canAddPlan,
      'shiftName': instance.shiftName,
      'shiftId': instance.shiftId,
      'workSystem': instance.workSystem,
      'remoteWorkPolicyId': instance.remoteWorkPolicyId,
      'workPolicy': instance.workPolicy,
      'todayWorkMode': instance.todayWorkMode,
      'todayWorkDay': instance.todayWorkDay,
      'todayIsWorkingDay': instance.todayIsWorkingDay,
      'todayWorkStart': instance.todayWorkStart,
      'todayWorkEnd': instance.todayWorkEnd,
      'todayAllowedDelayTime': instance.todayAllowedDelayTime,
      'clockInTime': instance.clockInTime,
      'clockOutTime': instance.clockOutTime,
      'area': instance.area,
      'leaveBalance': instance.leaveBalance,
    };
