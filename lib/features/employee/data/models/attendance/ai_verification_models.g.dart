// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_verification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiFaceVerifyRequestBodyImpl _$$AiFaceVerifyRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$AiFaceVerifyRequestBodyImpl(
  employeeId: json['employeeId'] as String,
  photoUrl: json['photoUrl'] as String,
);

Map<String, dynamic> _$$AiFaceVerifyRequestBodyImplToJson(
  _$AiFaceVerifyRequestBodyImpl instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'photoUrl': instance.photoUrl,
};

_$AiFaceVerifyResultModelImpl _$$AiFaceVerifyResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$AiFaceVerifyResultModelImpl(
  decision: json['decision'] as String? ?? 'REVIEW',
  matchScore: (json['matchScore'] as num?)?.toDouble() ?? 0.0,
  antiSpoofScore: (json['antiSpoofScore'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$AiFaceVerifyResultModelImplToJson(
  _$AiFaceVerifyResultModelImpl instance,
) => <String, dynamic>{
  'decision': instance.decision,
  'matchScore': instance.matchScore,
  'antiSpoofScore': instance.antiSpoofScore,
};

_$AiFaceVerifyResponseModelImpl _$$AiFaceVerifyResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AiFaceVerifyResponseModelImpl(
  isSuccess: json['isSuccess'] as bool? ?? false,
  value: json['value'] == null
      ? null
      : AiFaceVerifyResultModel.fromJson(json['value'] as Map<String, dynamic>),
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$$AiFaceVerifyResponseModelImplToJson(
  _$AiFaceVerifyResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'value': instance.value,
  'errorMessage': instance.errorMessage,
};

_$AiGpsRiskRequestBodyImpl _$$AiGpsRiskRequestBodyImplFromJson(
  Map<String, dynamic> json,
) => _$AiGpsRiskRequestBodyImpl(
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  accuracyM: (json['accuracyM'] as num).toDouble(),
  isMockLocation: json['isMockLocation'] as bool? ?? false,
);

Map<String, dynamic> _$$AiGpsRiskRequestBodyImplToJson(
  _$AiGpsRiskRequestBodyImpl instance,
) => <String, dynamic>{
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'accuracyM': instance.accuracyM,
  'isMockLocation': instance.isMockLocation,
};

_$AiGpsRiskResultModelImpl _$$AiGpsRiskResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$AiGpsRiskResultModelImpl(
  riskLevel: json['riskLevel'] as String? ?? 'LOW',
  riskScore: (json['riskScore'] as num?)?.toDouble() ?? 0.0,
  isMockDetected: json['isMockDetected'] as bool? ?? false,
);

Map<String, dynamic> _$$AiGpsRiskResultModelImplToJson(
  _$AiGpsRiskResultModelImpl instance,
) => <String, dynamic>{
  'riskLevel': instance.riskLevel,
  'riskScore': instance.riskScore,
  'isMockDetected': instance.isMockDetected,
};

_$AiGpsRiskResponseModelImpl _$$AiGpsRiskResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AiGpsRiskResponseModelImpl(
  isSuccess: json['isSuccess'] as bool? ?? false,
  value: json['value'] == null
      ? null
      : AiGpsRiskResultModel.fromJson(json['value'] as Map<String, dynamic>),
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$$AiGpsRiskResponseModelImplToJson(
  _$AiGpsRiskResponseModelImpl instance,
) => <String, dynamic>{
  'isSuccess': instance.isSuccess,
  'value': instance.value,
  'errorMessage': instance.errorMessage,
};

_$AttendanceClockResultModelImpl _$$AttendanceClockResultModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttendanceClockResultModelImpl(
  attendanceId: json['attendanceId'] as String?,
  clockInTime: json['clockInTime'] as String?,
  clockOutTime: json['clockOutTime'] as String?,
  isLate: json['isLate'] as bool? ?? false,
  lateMinutes: (json['lateMinutes'] as num?)?.toInt() ?? 0,
  earnedPoints: (json['earnedPoints'] as num?)?.toInt() ?? 0,
  pointType: json['pointType'] as String?,
  isInsideGeofence: json['isInsideGeofence'] as bool? ?? true,
);

Map<String, dynamic> _$$AttendanceClockResultModelImplToJson(
  _$AttendanceClockResultModelImpl instance,
) => <String, dynamic>{
  'attendanceId': instance.attendanceId,
  'clockInTime': instance.clockInTime,
  'clockOutTime': instance.clockOutTime,
  'isLate': instance.isLate,
  'lateMinutes': instance.lateMinutes,
  'earnedPoints': instance.earnedPoints,
  'pointType': instance.pointType,
  'isInsideGeofence': instance.isInsideGeofence,
};
