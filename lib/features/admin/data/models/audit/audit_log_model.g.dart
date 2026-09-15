// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audit_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuditLogModelImpl _$$AuditLogModelImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogModelImpl(
      id: json['id'] as String,
      actorId: json['actorId'] as String?,
      actorName: json['actorName'] as String?,
      action: json['action'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      before: json['before'] as Map<String, dynamic>?,
      after: json['after'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AuditLogModelImplToJson(_$AuditLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'actorId': instance.actorId,
      'actorName': instance.actorName,
      'action': instance.action,
      'createdAt': instance.createdAt.toIso8601String(),
      'before': instance.before,
      'after': instance.after,
    };

_$AuditLogsResponseModelImpl _$$AuditLogsResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AuditLogsResponseModelImpl(
  isSuccess: json['isSuccess'] as bool,
  status: (json['status'] as num).toInt(),
  value: AuditLogsResponseValue.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$AuditLogsResponseModelImplToJson(
  _$AuditLogsResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'status': instance.status,
  'value': instance.value,
};

_$AuditLogsResponseValueImpl _$$AuditLogsResponseValueImplFromJson(
  Map<String, dynamic> json,
) => _$AuditLogsResponseValueImpl(
  items: (json['items'] as List<dynamic>)
      .map((e) => AuditLogModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
);

Map<String, dynamic> _$$AuditLogsResponseValueImplToJson(
  _$AuditLogsResponseValueImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'totalCount': instance.totalCount,
};
