import 'package:json_annotation/json_annotation.dart';

part 'admin_task_model.g.dart';

@JsonSerializable()
class AdminTaskModel {
  const AdminTaskModel({
    this.id,
    this.title,
    this.description,
    this.status,
    this.dueDate,
    this.priorityStatus,
    this.isOverdue,
    this.completedAt,
    this.assignedEmployeeId,
    this.assignedEmployeeName,
  });

  final int? id;
  final String? title;
  final String? description;
  final String? status;
  final String? dueDate;
  final String? priorityStatus;
  final bool? isOverdue;
  final String? completedAt;
  final String? assignedEmployeeId;
  final String? assignedEmployeeName;

  factory AdminTaskModel.fromJson(Map<String, dynamic> json) =>
      _$AdminTaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdminTaskModelToJson(this);
}

@JsonSerializable()
class TasksResponseModel {
  const TasksResponseModel({this.value, this.isSuccess, this.successMessage});

  final TasksPageModel? value;
  final bool? isSuccess;
  final String? successMessage;

  factory TasksResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TasksResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksResponseModelToJson(this);
}

@JsonSerializable()
class TasksListResponseModel {
  const TasksListResponseModel({
    this.value,
    this.isSuccess,
    this.successMessage,
  });

  final List<AdminTaskModel>? value;
  final bool? isSuccess;
  final String? successMessage;

  factory TasksListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TasksListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksListResponseModelToJson(this);
}

@JsonSerializable()
class TasksPageModel {
  const TasksPageModel({this.items, this.data, this.totalCount});

  final List<AdminTaskModel>? items;
  final List<AdminTaskModel>? data;
  final int? totalCount;

  List<AdminTaskModel> get list => items ?? data ?? const [];

  factory TasksPageModel.fromJson(Map<String, dynamic> json) =>
      _$TasksPageModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksPageModelToJson(this);
}

@JsonSerializable()
class AddTaskRequestBody {
  const AddTaskRequestBody({
    required this.title,
    required this.description,
    this.assignedEmployeeId,
    this.dueDate,
    this.priorityStatus,
    this.status,
    this.departmentId,
  });

  final String title;
  final String description;
  final String? assignedEmployeeId;
  final String? dueDate;
  final String? priorityStatus;
  final String? status;
  final int? departmentId;

  factory AddTaskRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddTaskRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddTaskRequestBodyToJson(this);
}

@JsonSerializable()
class AssignTaskRequestBody {
  const AssignTaskRequestBody({required this.taskId, required this.employeeId});

  final int taskId;
  final String employeeId;

  factory AssignTaskRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AssignTaskRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AssignTaskRequestBodyToJson(this);
}
