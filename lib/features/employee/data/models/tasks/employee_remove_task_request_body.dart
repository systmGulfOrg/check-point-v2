import 'package:json_annotation/json_annotation.dart';

part 'employee_remove_task_request_body.g.dart';

@JsonSerializable()
class EmployeeRemoveTaskRequestBody {
  const EmployeeRemoveTaskRequestBody({
    required this.taskId,
    required this.employeeId,
  });

  final int taskId;
  final String employeeId;

  factory EmployeeRemoveTaskRequestBody.fromJson(Map<String, dynamic> json) =>
      _$EmployeeRemoveTaskRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeRemoveTaskRequestBodyToJson(this);
}
