// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'samco_customization_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SamcoCustomizationModelImpl _$$SamcoCustomizationModelImplFromJson(
  Map<String, dynamic> json,
) => _$SamcoCustomizationModelImpl(
  workerLabel: json['workerLabel'] as String? ?? 'Worker',
  workersLabel: json['workersLabel'] as String? ?? 'Workers',
  siteLabel: json['siteLabel'] as String? ?? 'Site',
  sitesLabel: json['sitesLabel'] as String? ?? 'Sites',
  contractorLabel: json['contractorLabel'] as String? ?? 'Contractor',
  contractorsLabel: json['contractorsLabel'] as String? ?? 'Contractors',
  projectLabel: json['projectLabel'] as String? ?? 'Project',
  projectsLabel: json['projectsLabel'] as String? ?? 'Projects',
  enablePolygonGeofence: json['enablePolygonGeofence'] as bool? ?? true,
  enableDeviceBinding: json['enableDeviceBinding'] as bool? ?? true,
);

Map<String, dynamic> _$$SamcoCustomizationModelImplToJson(
  _$SamcoCustomizationModelImpl instance,
) => <String, dynamic>{
  'workerLabel': instance.workerLabel,
  'workersLabel': instance.workersLabel,
  'siteLabel': instance.siteLabel,
  'sitesLabel': instance.sitesLabel,
  'contractorLabel': instance.contractorLabel,
  'contractorsLabel': instance.contractorsLabel,
  'projectLabel': instance.projectLabel,
  'projectsLabel': instance.projectsLabel,
  'enablePolygonGeofence': instance.enablePolygonGeofence,
  'enableDeviceBinding': instance.enableDeviceBinding,
};
