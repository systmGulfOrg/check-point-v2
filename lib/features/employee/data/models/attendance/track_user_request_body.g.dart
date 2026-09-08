// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_user_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackUserRequestBody _$TrackUserRequestBodyFromJson(
  Map<String, dynamic> json,
) => TrackUserRequestBody(
  employeeId: json['employeeId'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  recordedAt: json['recordedAt'] as String?,
);

Map<String, dynamic> _$TrackUserRequestBodyToJson(
  TrackUserRequestBody instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'recordedAt': instance.recordedAt,
};
