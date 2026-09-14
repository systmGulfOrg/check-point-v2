// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reject_account_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RejectAccountRequestBody _$RejectAccountRequestBodyFromJson(
  Map<String, dynamic> json,
) => RejectAccountRequestBody(
  rejectReason: json['rejectReason'] as String,
  status: json['status'] as String? ?? 'Rejected',
);

Map<String, dynamic> _$RejectAccountRequestBodyToJson(
  RejectAccountRequestBody instance,
) => <String, dynamic>{
  'status': instance.status,
  'rejectReason': instance.rejectReason,
};
