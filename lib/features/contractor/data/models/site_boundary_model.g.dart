// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'site_boundary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SiteBoundaryModelImpl _$$SiteBoundaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$SiteBoundaryModelImpl(
  siteIdUnderscore: json['site_id'] as String?,
  siteIdCamel: json['siteId'] as String?,
  siteNameUnderscore: json['site_name'] as String?,
  siteNameCamel: json['siteName'] as String?,
  boundaryType: json['boundary_type'] as String? ?? 'polygon',
  centerLat: (json['center_lat'] as num?)?.toDouble(),
  centerLng: (json['center_lng'] as num?)?.toDouble(),
  radiusMeters: (json['radius_meters'] as num?)?.toDouble() ?? 250.0,
  boundaryCoordinates:
      (json['boundary_coordinates'] as List<dynamic>?)
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
  'site_id': instance.siteIdUnderscore,
  'siteId': instance.siteIdCamel,
  'site_name': instance.siteNameUnderscore,
  'siteName': instance.siteNameCamel,
  'boundary_type': instance.boundaryType,
  'center_lat': instance.centerLat,
  'center_lng': instance.centerLng,
  'radius_meters': instance.radiusMeters,
  'boundary_coordinates': instance.boundaryCoordinates,
  'projectId': instance.projectId,
  'projectName': instance.projectName,
  'status': instance.status,
  'workerCount': instance.workerCount,
  'assignmentCount': instance.assignmentCount,
};
