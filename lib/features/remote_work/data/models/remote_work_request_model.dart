import 'package:json_annotation/json_annotation.dart';

part 'remote_work_request_model.g.dart';

@JsonSerializable(createToJson: false)
class RemoteWorkRequestModel {
  const RemoteWorkRequestModel({
    required this.id,
    required this.employeeId,
    required this.requestDate,
    required this.status,
    this.reason,
    this.employeeName,
    this.employeeCode,
    this.policyId,
    this.policyName,
    this.reviewNote,
  });

  final String id;
  final String employeeId;
  final String requestDate;
  final String status;
  final String? reason;
  @JsonKey(name: 'employee')
  final String? employeeName;
  final String? employeeCode;
  final String? policyId;
  @JsonKey(name: 'policy')
  final String? policyName;
  final String? reviewNote;

  factory RemoteWorkRequestModel.fromJson(Map<String, dynamic> json) {
    final employee = json['employee'];
    final policy = json['policy'];
    return RemoteWorkRequestModel(
      id: json['id'] as String? ?? '',
      employeeId: json['employeeId'] as String? ?? '',
      requestDate: json['requestDate'] as String? ?? '',
      status: json['status'] as String? ?? 'Pending',
      reason: json['reason'] as String?,
      employeeName: employee is Map<String, dynamic>
          ? employee['name'] as String?
          : null,
      employeeCode: employee is Map<String, dynamic>
          ? employee['employeeCode'] as String?
          : null,
      policyId: policy is Map<String, dynamic>
          ? policy['id'] as String?
          : json['policyId'] as String?,
      policyName: policy is Map<String, dynamic>
          ? policy['name'] as String?
          : null,
      reviewNote: json['reviewNote'] as String?,
    );
  }
}
