import 'package:json_annotation/json_annotation.dart';

import 'package:check_point_v2/core/utils/legacy_api_json_converters.dart';
import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'admin_leave_request_model.g.dart';

Object? _readLeaveType(Map json, String key) {
  return json['leaveRequestType'] ?? json['leaveTypeName'] ?? json['leaveType'];
}

@JsonSerializable()
class AdminLeaveRequestModel {
  const AdminLeaveRequestModel({
    this.ulid,
    this.id,
    this.employeeId,
    this.employeeName,
    this.leaveType,
    this.startDate,
    this.endDate,
    this.reason,
    this.attachmentUrl,
    this.status,
    this.directManagerId,
    this.directManagerName,
    this.hasDirectManager,
    this.rejectionReason,
    this.timeline,
    this.managerId,
    this.managerName,
    this.managerActionAt,
    this.managerRejectionReason,
    this.hrId,
    this.hrName,
    this.hrActionAt,
    this.hrRejectionReason,
  });

  final String? ulid;
  final int? id;
  final String? employeeId;
  final String? employeeName;
  @JsonKey(readValue: _readLeaveType)
  final String? leaveType;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? startDate;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? endDate;
  final String? reason;
  final String? attachmentUrl;
  final String? status;
  final String? directManagerId;
  final String? directManagerName;
  final bool? hasDirectManager;
  final String? rejectionReason;
  final List<dynamic>? timeline;
  final String? managerId;
  final String? managerName;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? managerActionAt;
  final String? managerRejectionReason;
  final String? hrId;
  final String? hrName;
  @JsonKey(fromJson: legacyApiValueToString)
  final String? hrActionAt;
  final String? hrRejectionReason;

  factory AdminLeaveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AdminLeaveRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminLeaveRequestModelToJson(this);
}

@JsonSerializable()
class LeaveRequestsResponseModel {
  const LeaveRequestsResponseModel({
    this.value,
    this.isSuccess,
    this.successMessage,
  });

  final LeaveRequestsPageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory LeaveRequestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestsResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });

  Map<String, dynamic> toJson() => _$LeaveRequestsResponseModelToJson(this);
}

@JsonSerializable()
class LeaveRequestsPageModel {
  const LeaveRequestsPageModel({this.items, this.data, this.totalCount});

  final List<AdminLeaveRequestModel>? items;
  final List<AdminLeaveRequestModel>? data;
  final int? totalCount;

  List<AdminLeaveRequestModel> get list => items ?? data ?? const [];

  factory LeaveRequestsPageModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveRequestsPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveRequestsPageModelToJson(this);
}

extension AdminLeaveRequestStatusX on AdminLeaveRequestModel {
  bool coversDate(DateTime date) {
    if (status?.toLowerCase() != 'approved') return false;
    final start = _parseLegacyDate(startDate);
    final end = _parseLegacyDate(endDate);
    if (start == null || end == null) return false;
    final day = DateTime(date.year, date.month, date.day);
    return !day.isBefore(start) && !day.isAfter(end);
  }
}

DateTime? _parseLegacyDate(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;
  try {
    final parsed = DateTime.parse(raw);
    return DateTime(parsed.year, parsed.month, parsed.day);
  } catch (_) {
    return null;
  }
}

Set<String> employeeIdsOnLeave(
  List<AdminLeaveRequestModel> requests,
  DateTime date,
) {
  return {
    for (final r in requests)
      if (r.employeeId != null && r.coversDate(date)) r.employeeId!,
  };
}

@JsonSerializable()
class ChangeRequestLeaveStatus {
  const ChangeRequestLeaveStatus({
    required this.leaveRequestId,
    required this.status,
  });

  final int leaveRequestId;
  final String status;

  factory ChangeRequestLeaveStatus.fromJson(Map<String, dynamic> json) =>
      _$ChangeRequestLeaveStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ChangeRequestLeaveStatusToJson(this);
}
