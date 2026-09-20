import 'package:freezed_annotation/freezed_annotation.dart';

part 'project_models.freezed.dart';
part 'project_models.g.dart';

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
    String? departmentName,
    @Default(<ProjectStatusModel>[]) List<ProjectStatusModel> statuses,
  }) = _ProjectModel;

  factory ProjectModel.fromJson(Map<String, dynamic> json) =>
      _$ProjectModelFromJson(json);
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
    // ignore: invalid_annotation_target, Freezed forwards this converter to the generated field.
    @JsonKey(fromJson: _assigneeIdsFromJson)
    @Default(<String>[])
    List<String> assigneeIds,
    @Default(<TaskAttachmentModel>[]) List<TaskAttachmentModel> attachments,
  }) = _ProjectTaskModel;

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

List<String> _assigneeIdsFromJson(Object? value) => value is List
    ? value
          .map(
            (item) => item is String
                ? item
                : item is Map
                ? '${item['employeeId'] ?? item['id'] ?? ''}'
                : '',
          )
          .where((item) => item.isNotEmpty)
          .toList()
    : const [];
