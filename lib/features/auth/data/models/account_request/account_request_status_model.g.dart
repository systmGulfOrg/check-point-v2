// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_request_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequestStatusModel _$AccountRequestStatusModelFromJson(
  Map<String, dynamic> json,
) => AccountRequestStatusModel(
  status: json['status'] as String,
  name: json['name'] as String?,
  rejectReason: json['rejectReason'] as String?,
  reviewedAt: json['reviewedAt'] == null
      ? null
      : DateTime.parse(json['reviewedAt'] as String),
  createdEmployeeId: json['createdEmployeeId'] as String?,
);

Map<String, dynamic> _$AccountRequestStatusModelToJson(
  AccountRequestStatusModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'name': instance.name,
  'rejectReason': instance.rejectReason,
  'reviewedAt': instance.reviewedAt?.toIso8601String(),
  'createdEmployeeId': instance.createdEmployeeId,
};

AccountRequestStatusResponseModel _$AccountRequestStatusResponseModelFromJson(
  Map<String, dynamic> json,
) => AccountRequestStatusResponseModel(
  value: json['value'] == null
      ? null
      : AccountRequestStatusModel.fromJson(
          json['value'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$AccountRequestStatusResponseModelToJson(
  AccountRequestStatusResponseModel instance,
) => <String, dynamic>{'value': instance.value};
