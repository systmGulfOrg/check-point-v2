// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_worker_attendance_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkerCoordinateModel _$WorkerCoordinateModelFromJson(
  Map<String, dynamic> json,
) => WorkerCoordinateModel(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  accuracyM: (json['accuracyM'] as num?)?.toDouble(),
);

Map<String, dynamic> _$WorkerCoordinateModelToJson(
  WorkerCoordinateModel instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'accuracyM': instance.accuracyM,
};

RecordWorkerAttendanceRequestBody _$RecordWorkerAttendanceRequestBodyFromJson(
  Map<String, dynamic> json,
) => RecordWorkerAttendanceRequestBody(
  siteId: json['siteId'] as String,
  date: json['date'] as String,
  workerIds: (json['workerIds'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  clockIn: json['clockIn'] as String,
  clockOut: json['clockOut'] as String?,
  note: json['note'] as String?,
  coordinates:
      (json['coordinates'] as List<dynamic>?)
          ?.map(
            (e) => WorkerCoordinateModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$RecordWorkerAttendanceRequestBodyToJson(
  RecordWorkerAttendanceRequestBody instance,
) => <String, dynamic>{
  'siteId': instance.siteId,
  'date': instance.date,
  'workerIds': instance.workerIds,
  'clockIn': instance.clockIn,
  'clockOut': instance.clockOut,
  'note': instance.note,
  'coordinates': instance.coordinates,
};
