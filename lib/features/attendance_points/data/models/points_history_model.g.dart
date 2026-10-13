// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsHistoryItemModelImpl _$$PointsHistoryItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsHistoryItemModelImpl(
  id: json['id'] as String,
  pointType: json['pointType'] as String,
  status: json['status'] as String,
  source: json['source'] as String,
  points: (json['points'] as num?)?.toInt() ?? 0,
  attendanceDate: json['attendanceDate'] as String,
  reason: json['reason'] as String,
  cancelReason: json['cancelReason'] as String?,
  permissionId: json['permissionId'] as String?,
  attendanceId: json['attendanceId'] as String?,
  expiresAt: json['expiresAt'] as String?,
  recomputedAt: json['recomputedAt'] as String?,
  computationSnapshot: json['computationSnapshot'] as Map<String, dynamic>?,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$$PointsHistoryItemModelImplToJson(
  _$PointsHistoryItemModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'pointType': instance.pointType,
  'status': instance.status,
  'source': instance.source,
  'points': instance.points,
  'attendanceDate': instance.attendanceDate,
  'reason': instance.reason,
  'cancelReason': instance.cancelReason,
  'permissionId': instance.permissionId,
  'attendanceId': instance.attendanceId,
  'expiresAt': instance.expiresAt,
  'recomputedAt': instance.recomputedAt,
  'computationSnapshot': instance.computationSnapshot,
  'createdAt': instance.createdAt,
};

_$PointsHistoryResponseModelImpl _$$PointsHistoryResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsHistoryResponseModelImpl(
  value:
      (json['value'] as List<dynamic>?)
          ?.map(
            (e) => PointsHistoryItemModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const <PointsHistoryItemModel>[],
  total: (json['total'] as num?)?.toInt(),
  page: (json['page'] as num?)?.toInt(),
  limit: (json['limit'] as num?)?.toInt(),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$PointsHistoryResponseModelImplToJson(
  _$PointsHistoryResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'total': instance.total,
  'page': instance.page,
  'limit': instance.limit,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
