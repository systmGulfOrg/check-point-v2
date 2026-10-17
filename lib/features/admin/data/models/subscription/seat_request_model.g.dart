// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatRequestModel _$SeatRequestModelFromJson(Map<String, dynamic> json) =>
    SeatRequestModel(
      id: json['id'] as String?,
      requestedByName: json['requestedByName'] as String?,
      currentLimit: (json['currentLimit'] as num?)?.toInt(),
      requestedLimit: (json['requestedLimit'] as num?)?.toInt(),
      approvedLimit: (json['approvedLimit'] as num?)?.toInt(),
      reason: json['reason'] as String?,
      status: json['status'] as String?,
      reviewNote: json['reviewNote'] as String?,
      reviewedAt: json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$SeatRequestModelToJson(SeatRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'requestedByName': instance.requestedByName,
      'currentLimit': instance.currentLimit,
      'requestedLimit': instance.requestedLimit,
      'approvedLimit': instance.approvedLimit,
      'reason': instance.reason,
      'status': instance.status,
      'reviewNote': instance.reviewNote,
      'reviewedAt': instance.reviewedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
    };

SeatRequestResultModel _$SeatRequestResultModelFromJson(
  Map<String, dynamic> json,
) => SeatRequestResultModel(
  value: json['value'] == null
      ? null
      : SeatRequestModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SeatRequestResultModelToJson(
  SeatRequestResultModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'errors': instance.errors,
};

CreateSeatRequestBody _$CreateSeatRequestBodyFromJson(
  Map<String, dynamic> json,
) => CreateSeatRequestBody(
  requestedLimit: (json['requestedLimit'] as num).toInt(),
  reason: json['reason'] as String?,
);

Map<String, dynamic> _$CreateSeatRequestBodyToJson(
  CreateSeatRequestBody instance,
) => <String, dynamic>{
  'requestedLimit': instance.requestedLimit,
  'reason': instance.reason,
};
