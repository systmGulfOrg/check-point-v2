// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_verification_models.freezed.dart';
part 'ai_verification_models.g.dart';

@freezed
class AiFaceVerifyRequestBody with _$AiFaceVerifyRequestBody {
  const factory AiFaceVerifyRequestBody({
    required String employeeId,
    required String photoUrl,
  }) = _AiFaceVerifyRequestBody;

  factory AiFaceVerifyRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AiFaceVerifyRequestBodyFromJson(json);
}

@freezed
class AiFaceVerifyResultModel with _$AiFaceVerifyResultModel {
  const factory AiFaceVerifyResultModel({
    @JsonKey(name: 'decision') @Default('REVIEW') String decision, // ACCEPT, REVIEW, REJECT
    @JsonKey(name: 'matchScore') @Default(0.0) double matchScore,
    @JsonKey(name: 'antiSpoofScore') @Default(0.0) double antiSpoofScore,
  }) = _AiFaceVerifyResultModel;

  factory AiFaceVerifyResultModel.fromJson(Map<String, dynamic> json) =>
      _$AiFaceVerifyResultModelFromJson(json);
}

@freezed
class AiFaceVerifyResponseModel with _$AiFaceVerifyResponseModel {
  const factory AiFaceVerifyResponseModel({
    @JsonKey(name: 'isSuccess') @Default(false) bool isSuccess,
    @JsonKey(name: 'value') AiFaceVerifyResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  }) = _AiFaceVerifyResponseModel;

  factory AiFaceVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AiFaceVerifyResponseModelFromJson(json);
}

@freezed
class AiGpsRiskRequestBody with _$AiGpsRiskRequestBody {
  const factory AiGpsRiskRequestBody({
    required double latitude,
    required double longitude,
    required double accuracyM,
    @JsonKey(name: 'isMockLocation') @Default(false) bool isMockLocation,
  }) = _AiGpsRiskRequestBody;

  factory AiGpsRiskRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AiGpsRiskRequestBodyFromJson(json);
}

@freezed
class AiGpsRiskResultModel with _$AiGpsRiskResultModel {
  const factory AiGpsRiskResultModel({
    @JsonKey(name: 'riskLevel') @Default('LOW') String riskLevel, // LOW, MEDIUM, HIGH
    @JsonKey(name: 'riskScore') @Default(0.0) double riskScore,
    @JsonKey(name: 'isMockDetected') @Default(false) bool isMockDetected,
  }) = _AiGpsRiskResultModel;

  factory AiGpsRiskResultModel.fromJson(Map<String, dynamic> json) =>
      _$AiGpsRiskResultModelFromJson(json);
}

@freezed
class AiGpsRiskResponseModel with _$AiGpsRiskResponseModel {
  const factory AiGpsRiskResponseModel({
    @JsonKey(name: 'isSuccess') @Default(false) bool isSuccess,
    @JsonKey(name: 'value') AiGpsRiskResultModel? value,
    @JsonKey(name: 'errorMessage') String? errorMessage,
  }) = _AiGpsRiskResponseModel;

  factory AiGpsRiskResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AiGpsRiskResponseModelFromJson(json);
}

@freezed
class AttendanceClockResultModel with _$AttendanceClockResultModel {
  const factory AttendanceClockResultModel({
    @JsonKey(name: 'attendanceId') String? attendanceId,
    @JsonKey(name: 'clockInTime') String? clockInTime,
    @JsonKey(name: 'clockOutTime') String? clockOutTime,
    @JsonKey(name: 'isLate') @Default(false) bool isLate,
    @JsonKey(name: 'lateMinutes') @Default(0) int lateMinutes,
    @JsonKey(name: 'earnedPoints') @Default(0) int earnedPoints,
    @JsonKey(name: 'pointType') String? pointType,
    @JsonKey(name: 'isInsideGeofence') @Default(true) bool isInsideGeofence,
  }) = _AttendanceClockResultModel;

  factory AttendanceClockResultModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceClockResultModelFromJson(json);
}
