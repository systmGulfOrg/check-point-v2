import 'package:json_annotation/json_annotation.dart';

part 'overtime_request_model.g.dart';

@JsonSerializable(createToJson: false)
class OvertimeRequestModel {
  const OvertimeRequestModel({
    required this.id,
    required this.employeeId,
    required this.requestDate,
    required this.startTime,
    required this.endTime,
    required this.durationMinutes,
    required this.status,
    this.reason,
    this.employeeName,
    this.employeeCode,
    this.reviewNote,
  });

  final String id;
  final String employeeId;
  final String requestDate;
  final String startTime;
  final String endTime;
  final int durationMinutes;
  final String status;
  final String? reason;
  @JsonKey(name: 'employee')
  final String? employeeName;
  final String? employeeCode;
  final String? reviewNote;

  factory OvertimeRequestModel.fromJson(Map<String, dynamic> json) {
    final employee = json['employee'];
    return OvertimeRequestModel(
      id: json['id'] as String? ?? '',
      employeeId: json['employeeId'] as String? ?? '',
      requestDate: json['requestDate'] as String? ?? '',
      startTime: json['startTime'] as String? ?? '',
      endTime: json['endTime'] as String? ?? '',
      durationMinutes: json['durationMinutes'] as int? ?? 0,
      status: json['status'] as String? ?? 'Pending',
      reason: json['reason'] as String?,
      employeeName: employee is Map<String, dynamic>
          ? employee['name'] as String?
          : null,
      employeeCode: employee is Map<String, dynamic>
          ? employee['employeeCode'] as String?
          : null,
      reviewNote: json['reviewNote'] as String?,
    );
  }
}
