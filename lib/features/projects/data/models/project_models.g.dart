// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProjectStatusModelImpl _$$ProjectStatusModelImplFromJson(
  Map<String, dynamic> json,
) => _$ProjectStatusModelImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  colorHex: json['colorHex'] as String?,
  positionOrder: (json['positionOrder'] as num?)?.toInt(),
  isDoneState: json['isDoneState'] as bool?,
);

Map<String, dynamic> _$$ProjectStatusModelImplToJson(
  _$ProjectStatusModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'colorHex': instance.colorHex,
  'positionOrder': instance.positionOrder,
  'isDoneState': instance.isDoneState,
};

_$ProjectModelImpl _$$ProjectModelImplFromJson(Map<String, dynamic> json) =>
    _$ProjectModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      code: json['code'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      departmentId: json['departmentId'] as String?,
      departmentName: json['departmentName'] as String?,
      statuses:
          (json['statuses'] as List<dynamic>?)
              ?.map(
                (e) => ProjectStatusModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ProjectStatusModel>[],
    );

Map<String, dynamic> _$$ProjectModelImplToJson(_$ProjectModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'departmentId': instance.departmentId,
      'departmentName': instance.departmentName,
      'statuses': instance.statuses,
    };

_$ProjectTaskModelImpl _$$ProjectTaskModelImplFromJson(
  Map<String, dynamic> json,
) => _$ProjectTaskModelImpl(
  id: json['id'] as String,
  title: json['title'] as String,
  projectId: json['projectId'] as String?,
  statusId: json['statusId'] as String?,
  description: json['description'] as String?,
  priority: json['priority'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  startDate: json['startDate'] as String?,
  dueDate: json['dueDate'] as String?,
  estimatedMinutes: (json['estimatedMinutes'] as num?)?.toInt(),
  actualMinutes: (json['actualMinutes'] as num?)?.toInt(),
  assigneeIds: json['assigneeIds'] == null
      ? const <String>[]
      : _assigneeIdsFromJson(json['assigneeIds']),
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => TaskAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <TaskAttachmentModel>[],
);

Map<String, dynamic> _$$ProjectTaskModelImplToJson(
  _$ProjectTaskModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'projectId': instance.projectId,
  'statusId': instance.statusId,
  'description': instance.description,
  'priority': instance.priority,
  'tags': instance.tags,
  'startDate': instance.startDate,
  'dueDate': instance.dueDate,
  'estimatedMinutes': instance.estimatedMinutes,
  'actualMinutes': instance.actualMinutes,
  'assigneeIds': instance.assigneeIds,
  'attachments': instance.attachments,
};

_$TaskAttachmentModelImpl _$$TaskAttachmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$TaskAttachmentModelImpl(
  id: json['id'] as String,
  fileName: json['fileName'] as String?,
  fileUrl: json['fileUrl'] as String?,
  fileSize: (json['fileSize'] as num?)?.toInt(),
  mimeType: json['mimeType'] as String?,
  createdAt: json['createdAt'] as String?,
);

Map<String, dynamic> _$$TaskAttachmentModelImplToJson(
  _$TaskAttachmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'fileName': instance.fileName,
  'fileUrl': instance.fileUrl,
  'fileSize': instance.fileSize,
  'mimeType': instance.mimeType,
  'createdAt': instance.createdAt,
};

_$TaskAuditModelImpl _$$TaskAuditModelImplFromJson(Map<String, dynamic> json) =>
    _$TaskAuditModelImpl(
      id: json['id'] as String,
      action: json['action'] as String?,
      actorName: json['actorName'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$$TaskAuditModelImplToJson(
  _$TaskAuditModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'action': instance.action,
  'actorName': instance.actorName,
  'createdAt': instance.createdAt,
};
