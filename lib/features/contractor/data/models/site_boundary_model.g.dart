// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_boundary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SiteBoundaryModelImpl _$$SiteBoundaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$SiteBoundaryModelImpl(
  siteId: json['siteId'] as String,
  siteName: json['siteName'] as String,
  boundaryType: json['boundaryType'] as String? ?? 'circle',
  centerLat: (json['centerLat'] as num?)?.toDouble(),
  centerLng: (json['centerLng'] as num?)?.toDouble(),
  radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 150.0,
  boundaryCoordinates:
      (json['boundaryCoordinates'] as List<dynamic>?)
          ?.map((e) => LatLngPointModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  projectId: json['projectId'] as String?,
  projectName: json['projectName'] as String?,
  status: json['status'] as String? ?? 'active',
  workerCount: (json['workerCount'] as num?)?.toInt() ?? 0,
  assignmentCount: (json['assignmentCount'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$SiteBoundaryModelImplToJson(
  _$SiteBoundaryModelImpl instance,
) => <String, dynamic>{
  'siteId': instance.siteId,
  'siteName': instance.siteName,
  'boundaryType': instance.boundaryType,
  'centerLat': instance.centerLat,
  'centerLng': instance.centerLng,
  'radiusMeters': instance.radiusMeters,
  'boundaryCoordinates': instance.boundaryCoordinates,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
  'status': instance.status,
  'workerCount': instance.workerCount,
  'assignmentCount': instance.assignmentCount,
};
