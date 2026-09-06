// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'police_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PoliceModel _$PoliceModelFromJson(Map<String, dynamic> json) => PoliceModel(
  id: (json['id'] as num?)?.toInt(),
  shiftId: (json['shiftId'] as num?)?.toInt(),
  policyName: json['policyName'] as String?,
  workDays: (json['workDays'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  startTime: json['startTime'] as String?,
  endTime: json['endTime'] as String?,
  clockInTime: json['clockInTime'] as String?,
  clockOutTime: json['clockOutTime'] as String?,
  area: json['area'] as String?,
  month: (json['month'] as num?)?.toInt(),
  year: (json['year'] as num?)?.toInt(),
  shift: json['shift'] == null
      ? null
      : ShiftModel.fromJson(json['shift'] as Map<String, dynamic>),
  employees: (json['employees'] as List<dynamic>?)
      ?.map((e) => EmployeeModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  allowedDelayTime: (json['allowedDelayTime'] as num?)?.toInt(),
  allowedEarlyLeaveTime: (json['allowedEarlyLeaveTime'] as num?)?.toInt(),
);

Map<String, dynamic> _$PoliceModelToJson(PoliceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shiftId': instance.shiftId,
      'policyName': instance.policyName,
      'workDays': instance.workDays,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'clockInTime': instance.clockInTime,
      'clockOutTime': instance.clockOutTime,
      'area': instance.area,
      'month': instance.month,
      'year': instance.year,
      'shift': instance.shift,
      'employees': instance.employees,
      'allowedDelayTime': instance.allowedDelayTime,
      'allowedEarlyLeaveTime': instance.allowedEarlyLeaveTime,
    };

PoliceResponseModel _$PoliceResponseModelFromJson(Map<String, dynamic> json) =>
    PoliceResponseModel(
      value: json['value'] == null
          ? null
          : PolicePageModel.fromJson(json['value'] as Map<String, dynamic>),
      isSuccess: json['isSuccess'] as bool?,
      successMessage: json['successMessage'] as String?,
    );

Map<String, dynamic> _$PoliceResponseModelToJson(
  PoliceResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

PolicePageModel _$PolicePageModelFromJson(Map<String, dynamic> json) =>
    PolicePageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => PoliceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PoliceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PolicePageModelToJson(PolicePageModel instance) =>
    <String, dynamic>{
      'items': instance.items,
      'data': instance.data,
      'totalCount': instance.totalCount,
    };

AddPoliceRequestBody _$AddPoliceRequestBodyFromJson(
  Map<String, dynamic> json,
) => AddPoliceRequestBody(
  shiftId: (json['shiftId'] as num).toInt(),
  policyName: json['policyName'] as String,
  workDays: (json['workDays'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  allowedDelayTime: (json['allowedDelayTime'] as num).toInt(),
  allowedEarlyLeaveTime: (json['allowedEarlyLeaveTime'] as num).toInt(),
);

Map<String, dynamic> _$AddPoliceRequestBodyToJson(
  AddPoliceRequestBody instance,
) => <String, dynamic>{
  'shiftId': instance.shiftId,
  'policyName': instance.policyName,
  'workDays': instance.workDays,
  'startTime': instance.startTime,
  'endTime': instance.endTime,
  'allowedDelayTime': instance.allowedDelayTime,
  'allowedEarlyLeaveTime': instance.allowedEarlyLeaveTime,
};

AssignPoliceRequestBody _$AssignPoliceRequestBodyFromJson(
  Map<String, dynamic> json,
) => AssignPoliceRequestBody(
  policyId: (json['policyId'] as num).toInt(),
  employeeIds: (json['employeeIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$AssignPoliceRequestBodyToJson(
  AssignPoliceRequestBody instance,
) => <String, dynamic>{
  'policyId': instance.policyId,
  'employeeIds': instance.employeeIds,
};

RemoveAssignPolicyRequestBody _$RemoveAssignPolicyRequestBodyFromJson(
  Map<String, dynamic> json,
) => RemoveAssignPolicyRequestBody(employeeId: json['employeeId'] as String);

Map<String, dynamic> _$RemoveAssignPolicyRequestBodyToJson(
  RemoveAssignPolicyRequestBody instance,
) => <String, dynamic>{'employeeId': instance.employeeId};
