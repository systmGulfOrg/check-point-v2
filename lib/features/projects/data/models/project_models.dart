import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_models.freezed.dart';
part 'project_models.g.dart';

Object? _readDepartmentName(Map json, String key) =>
    json['departmentName'] ??
    (json['department'] is Map ? json['department']['name'] : null);

Object? _readManagerName(Map json, String key) =>
    json['managerName'] ??
    (json['manager'] is Map ? json['manager']['name'] : null);

Object? _readAssignees(Map json, String key) =>
    json['assignees'] ?? json['assigneeIds'];

@freezed
class ProjectStatusModel with _$ProjectStatusModel {
  const factory ProjectStatusModel({
    required String id,
    required String name,
    String? colorHex,
    int? positionOrder,
    bool? isDoneState,
  }) = _ProjectStatusModel;

  factory ProjectStatusModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectStatusModelFromJson(json);
}

@freezed
class ProjectModel with _$ProjectModel {
  const factory ProjectModel({
    required String id,
    required String name,
    String? code,
    String? description,
    String? startDate,
    String? endDate,
    String? departmentId,
    // ignore: invalid_annotation_target
    @JsonKey(readValue: _readDepartmentName) String? departmentName,
    String? managerId,
    // ignore: invalid_annotation_target
    @JsonKey(readValue: _readManagerName) String? managerName,
    @Default(<ProjectStatusModel>[]) List<ProjectStatusModel> statuses,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
}

@freezed
class TaskAssigneeModel with _$TaskAssigneeModel {
  const factory TaskAssigneeModel({
    String? taskId,
    String? employeeId,
    String? assignedAt,
    String? employeeName,
    String? employeeImageUrl,
  }) = _TaskAssigneeModel;

  factory TaskAssigneeModel.fromJson(Map<String, dynamic> json) {
    final emp = json['employee'] is Map ? json['employee'] as Map : null;
    return TaskAssigneeModel(
      taskId: json['taskId']?.toString(),
      employeeId: (json['employeeId'] ?? emp?['id'] ?? json['id'])?.toString(),
      assignedAt: json['assignedAt']?.toString(),
      employeeName: (emp?['name'] ?? json['name'] ?? json['userName'])
          ?.toString(),
      employeeImageUrl: (emp?['imageUrl'] ?? json['imageUrl'])?.toString(),
    );
  }
}

@freezed
class ProjectTaskModel with _$ProjectTaskModel {
  const factory ProjectTaskModel({
    required String id,
    required String title,
    String? projectId,
    String? statusId,
    String? description,
    String? priority,
    @Default(<String>[]) List<String> tags,
    String? startDate,
    String? dueDate,
    int? estimatedMinutes,
    int? actualMinutes,
    // ignore: invalid_annotation_target
    @JsonKey(
      readValue: _readAssignees,
      fromJson: _assigneesFromJson,
      toJson: _assigneesToJson,
    )
    @Default(<TaskAssigneeModel>[])
    List<TaskAssigneeModel> assignees,
    @Default(<TaskAttachmentModel>[]) List<TaskAttachmentModel> attachments,
  }) = _ProjectTaskModel;

  const ProjectTaskModel._();

  List<String> get assigneeIds => assignees
      .map((a) => a.employeeId ?? '')
      .where((id) => id.isNotEmpty)
      .toList();

  factory ProjectTaskModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectTaskModelFromJson(json);
}

@freezed
class TaskAttachmentModel with _$TaskAttachmentModel {
  const factory TaskAttachmentModel({
    required String id,
    String? fileName,
    String? fileUrl,
    int? fileSize,
    String? mimeType,
    String? createdAt,
  }) = _TaskAttachmentModel;

  factory TaskAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$TaskAttachmentModelFromJson(json);
}

@freezed
class TaskAuditModel with _$TaskAuditModel {
  const factory TaskAuditModel({
    required String id,
    String? action,
    String? actorName,
    String? createdAt,
  }) = _TaskAuditModel;

  factory TaskAuditModel.fromJson(Map<String, dynamic> json) =>
      _$TaskAuditModelFromJson(json);
}

List<TaskAssigneeModel> _assigneesFromJson(Object? value) {
  if (value is! List) return const [];
  return value
      .map((item) {
        if (item is Map) {
          return TaskAssigneeModel.fromJson(Map<String, dynamic>.from(item));
        } else if (item is String && item.isNotEmpty) {
          return TaskAssigneeModel(employeeId: item, employeeName: item);
        }
        return const TaskAssigneeModel();
      })
      .where(
        (a) =>
            (a.employeeId?.isNotEmpty == true ||
            a.employeeName?.isNotEmpty == true),
      )
      .toList();
}

List<Map<String, dynamic>> _assigneesToJson(
  List<TaskAssigneeModel> assignees,
) => assignees
    .map(
      (a) => {
        'taskId': a.taskId,
        'employeeId': a.employeeId,
        'assignedAt': a.assignedAt,
        'employee': {
          'id': a.employeeId,
          'name': a.employeeName,
          'imageUrl': a.employeeImageUrl,
        },
      },
    )
    .toList();
