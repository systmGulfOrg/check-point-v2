import 'package:json_annotation/json_annotation.dart';

part 'employee_remove_plan_request_body.g.dart';

@JsonSerializable()
class EmployeeRemovePlanRequestBody {
  const EmployeeRemovePlanRequestBody({
    required this.customerPlanId,
    required this.employeeId,
  });

  final int customerPlanId;
  final String employeeId;

  factory EmployeeRemovePlanRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRemovePlanRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeRemovePlanRequestBodyToJson(this);
}
