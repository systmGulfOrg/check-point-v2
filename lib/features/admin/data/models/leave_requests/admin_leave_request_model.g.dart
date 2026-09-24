// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_leave_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdminLeaveRequestModel _$AdminLeaveRequestModelFromJson(
  Map<String, dynamic> json,
) => AdminLeaveRequestModel(
  ulid: json['ulid'] as String?,
  id: (json['id'] as num?)?.toInt(),
  employeeId: json['employeeId'] as String?,
  employeeName: json['employeeName'] as String?,
  leaveType: _readLeaveType(json, 'leaveType') as String?,
  startDate: legacyApiValueToString(json['startDate']),
  endDate: legacyApiValueToString(json['endDate']),
  reason: json['reason'] as String?,
  attachmentUrl: json['attachmentUrl'] as String?,
  status: json['status'] as String?,
  managerId: json['managerId'] as String?,
  managerName: json['managerName'] as String?,
  managerActionAt: legacyApiValueToString(json['managerActionAt']),
  managerRejectionReason: json['managerRejectionReason'] as String?,
  hrId: json['hrId'] as String?,
  hrName: json['hrName'] as String?,
  hrActionAt: legacyApiValueToString(json['hrActionAt']),
  hrRejectionReason: json['hrRejectionReason'] as String?,
);

Map<String, dynamic> _$AdminLeaveRequestModelToJson(
  AdminLeaveRequestModel instance,
) => <String, dynamic>{
  'ulid': instance.ulid,
  'id': instance.id,
  'employeeId': instance.employeeId,
  'employeeName': instance.employeeName,
  'leaveType': instance.leaveType,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'reason': instance.reason,
  'attachmentUrl': instance.attachmentUrl,
  'status': instance.status,
  'managerId': instance.managerId,
  'managerName': instance.managerName,
  'managerActionAt': instance.managerActionAt,
  'managerRejectionReason': instance.managerRejectionReason,
  'hrId': instance.hrId,
  'hrName': instance.hrName,
  'hrActionAt': instance.hrActionAt,
  'hrRejectionReason': instance.hrRejectionReason,
};

LeaveRequestsResponseModel _$LeaveRequestsResponseModelFromJson(
  Map<String, dynamic> json,
) => LeaveRequestsResponseModel(
  value: json['value'] == null
      ? null
      : LeaveRequestsPageModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
);

Map<String, dynamic> _$LeaveRequestsResponseModelToJson(
  LeaveRequestsResponseModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
};

LeaveRequestsPageModel _$LeaveRequestsPageModelFromJson(
  Map<String, dynamic> json,
) => LeaveRequestsPageModel(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => AdminLeaveRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AdminLeaveRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$LeaveRequestsPageModelToJson(
  LeaveRequestsPageModel instance,
) => <String, dynamic>{
  'items': instance.items,
  'data': instance.data,
  'totalCount': instance.totalCount,
};

ChangeRequestLeaveStatus _$ChangeRequestLeaveStatusFromJson(
  Map<String, dynamic> json,
) => ChangeRequestLeaveStatus(
  leaveRequestId: (json['leaveRequestId'] as num).toInt(),
  status: json['status'] as String,
);

Map<String, dynamic> _$ChangeRequestLeaveStatusToJson(
  ChangeRequestLeaveStatus instance,
) => <String, dynamic>{
  'leaveRequestId': instance.leaveRequestId,
  'status': instance.status,
};
