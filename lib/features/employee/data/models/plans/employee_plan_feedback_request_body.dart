import 'package:json_annotation/json_annotation.dart';

part 'employee_plan_feedback_request_body.g.dart';

@JsonSerializable()
class EmployeePlanFeedbackRequestBody {
  const EmployeePlanFeedbackRequestBody({
    required this.status,
    required this.customerPlanId,
    this.imageUrl,
    this.notes,
  });

  final String status;
  final int customerPlanId;
  final String? imageUrl;
  final String? notes;

  factory EmployeePlanFeedbackRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$EmployeePlanFeedbackRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeePlanFeedbackRequestBodyToJson(this);
}
