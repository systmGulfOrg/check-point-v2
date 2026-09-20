// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_work_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RemoteWorkRequestModel _$RemoteWorkRequestModelFromJson(
  Map<String, dynamic> json,
) => RemoteWorkRequestModel(
  id: json['id'] as String,
  employeeId: json['employeeId'] as String,
  requestDate: json['requestDate'] as String,
  status: json['status'] as String,
  reason: json['reason'] as String?,
  employeeName: json['employee'] as String?,
  employeeCode: json['employeeCode'] as String?,
  policyId: json['policyId'] as String?,
  policyName: json['policy'] as String?,
  reviewNote: json['reviewNote'] as String?,
);
