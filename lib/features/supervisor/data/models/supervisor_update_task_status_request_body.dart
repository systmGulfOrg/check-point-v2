import 'package:json_annotation/json_annotation.dart';

part 'supervisor_update_task_status_request_body.g.dart';

@JsonSerializable()
class SupervisorUpdateTaskStatusRequestBody {
  const SupervisorUpdateTaskStatusRequestBody({
    required this.id,
    required this.status,
  });

  final int id;
  final String status;

  factory SupervisorUpdateTaskStatusRequestBody.fromJson(
    Map<String, dynamic> json,
  ) => _$SupervisorUpdateTaskStatusRequestBodyFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SupervisorUpdateTaskStatusRequestBodyToJson(this);
}
