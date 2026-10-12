// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminAttendanceModel _$AdminAttendanceModelFromJson(
  Map<String, dynamic> json,
) => AdminAttendanceModel(
  id: (json['id'] as num?)?.toInt(),
  employeeId: json['employeeId'] as String?,
  employeeName: json['employeeName'] as String?,
  clockInTime: legacyApiValueToString(json['clockInTime']),
  clockOutTime: legacyApiValueToString(json['clockOutTime']),
  dayHours: legacyApiValueToString(json['dayHours']),
  totalHours: json['totalHours'],
  attendanceDate: legacyApiValueToString(json['attendanceDate']),
  area: json['area'] as String?,
  customerId: json['customerId'] as String?,
  customerName: json['customerName'] as String?,
  employeeImage: json['employeeImage'] as String?,
  isEarly: json['isEarly'] as bool?,
  isLate: json['isLate'] as bool?,
  status: json['status'] as String?,
  nominalHours: (json['nominalHours'] as num?)?.toDouble(),
  taskCalculatedHours: (json['taskCalculatedHours'] as num?)?.toDouble(),
  underAllocation: json['underAllocation'] as bool?,
  permitId: json['permitId'] as String?,
  checkInAddress: json['checkInAddress'] as String?,
  checkOutAddress: json['checkOutAddress'] as String?,
  checkInMockLocation: json['checkInMockLocation'] as bool?,
  checkOutMockLocation: json['checkOutMockLocation'] as bool?,
  earlyLeaveMinutes: (json['earlyLeaveMinutes'] as num?)?.toInt(),
  workedMinutes: (json['workedMinutes'] as num?)?.toInt(),
  siteId: json['siteId'] as String?,
  contractorId: json['contractorId'] as String?,
);

Map<String, dynamic> _$AdminAttendanceModelToJson(
  AdminAttendanceModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'employeeId': instance.employeeId,
  'employeeName': instance.employeeName,
  'clockInTime': instance.clockInTime,
  'clockOutTime': instance.clockOutTime,
  'dayHours': instance.dayHours,
  'totalHours': instance.totalHours,
  'attendanceDate': instance.attendanceDate,
  'area': instance.area,
  'customerId': instance.customerId,
  'customerName': instance.customerName,
  'employeeImage': instance.employeeImage,
  'isEarly': instance.isEarly,
  'isLate': instance.isLate,
  'status': instance.status,
  'nominalHours': instance.nominalHours,
  'taskCalculatedHours': instance.taskCalculatedHours,
  'underAllocation': instance.underAllocation,
  'permitId': instance.permitId,
  'checkInAddress': instance.checkInAddress,
  'checkOutAddress': instance.checkOutAddress,
  'checkInMockLocation': instance.checkInMockLocation,
  'checkOutMockLocation': instance.checkOutMockLocation,
  'earlyLeaveMinutes': instance.earlyLeaveMinutes,
  'workedMinutes': instance.workedMinutes,
  'siteId': instance.siteId,
  'contractorId': instance.contractorId,
};

AttendanceResponseModel _$AttendanceResponseModelFromJson(
  Map<String, dynamic> json,
) => AttendanceResponseModel(
  value: json['value'] == null
      ? null
      : AttendancePageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$AttendanceResponseModelToJson(
  AttendanceResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

AttendancePageModel _$AttendancePageModelFromJson(Map<String, dynamic> json) =>
    AttendancePageModel(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => AdminAttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdminAttendanceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AttendancePageModelToJson(
  AttendancePageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'data': instance.data,
  'totalCount': instance.totalCount,
};
