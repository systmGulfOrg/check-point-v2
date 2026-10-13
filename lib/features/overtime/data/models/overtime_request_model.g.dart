// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overtime_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OvertimeRequestModel _$OvertimeRequestModelFromJson(
  Map<String, dynamic> json,
) => OvertimeRequestModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  requestDate: json['requestDate'] as String,
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  durationMinutes: (json['durationMinutes'] as num).toInt(),
  status: json['status'] as String,
  reason: json['reason'] as String?,
  employeeName: json['employee'] as String?,
  employeeCode: json['employeeCode'] as String?,
  reviewNote: json['reviewNote'] as String?,
);
