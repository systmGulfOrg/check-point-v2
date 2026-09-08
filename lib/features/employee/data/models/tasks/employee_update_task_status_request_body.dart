import 'package:json_annotation/json_annotation.dart';

part 'employee_update_task_status_request_body.g.dart';

@JsonSerializable()
class EmployeeUpdateTaskStatusRequestBody {
  const EmployeeUpdateTaskStatusRequestBody({
    required this.id,
    required this.status,
  });

  final int id;
  final String status;

  factory EmployeeUpdateTaskStatusRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$EmployeeUpdateTaskStatusRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$EmployeeUpdateTaskStatusRequestBodyToJson(this);
}
