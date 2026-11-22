// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_check_in_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeCheckInRequestBody _$EmployeeCheckInRequestBodyFromJson(
  Map<String, dynamic> json,
) => EmployeeCheckInRequestBody(
  employeeIdd: json['employeeId'] as String,
  customerId: json['customerId'] as String?,
  area: json['area'] as String?,
  location: json['location'] as String?,
  coordinates: (json['coordinates'] as List<dynamic>?)
      ?.map((e) => AttendanceCoordinate.fromJson(e as Map<String, dynamic>))
      .toList(),
  employeeImage: json['employeeImage'] as String?,
  mockLocationDetected: json['mockLocationDetected'] as bool?,
  deviceUuid: json['deviceUuid'] as String?,
  capturedWallClock: json['capturedWallClock'] as String?,
  integrityVerdict: json['integrityVerdict'] as String?,
);

Map<String, dynamic> _$EmployeeCheckInRequestBodyToJson(
  EmployeeCheckInRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeIdd,
  'customerId': instance.customerId,
  'area': instance.area,
  'location': instance.location,
  'coordinates': instance.coordinates,
  'employeeImage': instance.employeeImage,
  'mockLocationDetected': instance.mockLocationDetected,
  'deviceUuid': instance.deviceUuid,
  'capturedWallClock': instance.capturedWallClock,
  'integrityVerdict': instance.integrityVerdict,
};

AttendanceCoordinate _$AttendanceCoordinateFromJson(
  Map<String, dynamic> json,
) => AttendanceCoordinate(
  latitude: (json['latitude'] as num?)?.toDouble(),
  longitude: (json['longitude'] as num?)?.toDouble(),
  accuracyM: (json['accuracyM'] as num?)?.toDouble(),
  provider: json['provider'] as String?,
  satellitesCount: (json['satellitesCount'] as num?)?.toInt(),
  speed: (json['speed'] as num?)?.toDouble(),
  altitude: (json['altitude'] as num?)?.toDouble(),
  isMock: json['isMock'] as bool?,
  wifiFingerprint: json['wifiFingerprint'],
  cellTowers: json['cellTowers'],
  elapsedRealtimeMs: (json['elapsedRealtimeMs'] as num?)?.toInt(),
  capturedWallClock: json['capturedWallClock'] as String?,
  deviceStatus: json['deviceStatus'],
  kind: json['kind'] as String?,
  capturedAt: json['capturedAt'] as String?,
);

Map<String, dynamic> _$AttendanceCoordinateToJson(
  AttendanceCoordinate instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'accuracyM': instance.accuracyM,
  'provider': instance.provider,
  'satellitesCount': instance.satellitesCount,
  'speed': instance.speed,
  'altitude': instance.altitude,
  'isMock': instance.isMock,
  'wifiFingerprint': instance.wifiFingerprint,
  'cellTowers': instance.cellTowers,
  'elapsedRealtimeMs': instance.elapsedRealtimeMs,
  'capturedWallClock': instance.capturedWallClock,
  'deviceStatus': instance.deviceStatus,
  'kind': instance.kind,
  'capturedAt': instance.capturedAt,
};
