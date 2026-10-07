// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_requests_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountRequestsResponseModel _$AccountRequestsResponseModelFromJson(
  Map<String, dynamic> json,
) => AccountRequestsResponseModel(
  value: json['value'] == null
      ? null
      : AccountRequestsPageModel.fromJson(
          json['value'] as Map<String, dynamic>,
        ),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

AccountRequestsPageModel _$AccountRequestsPageModelFromJson(
  Map<String, dynamic> json,
) => AccountRequestsPageModel(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => AccountRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => AccountRequestModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalCount: (json['totalCount'] as num?)?.toInt(),
);

AccountRequestModel _$AccountRequestModelFromJson(
  Map<String, dynamic> json,
) => AccountRequestModel(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  mobileId: json['mobileId'] as String?,
  phone: json['phone'] as String?,
  deviceToken: json['deviceToken'] as String?,
  imageUrl: json['imageUrl'] as String?,
  photoPath: json['photoPath'] as String?,
  status: json['status'] as String?,
  rejectReason: json['rejectReason'] as String?,
  reviewedBy: json['reviewedBy'] as String?,
  reviewedAt: json['reviewedAt'] == null
      ? null
      : DateTime.parse(json['reviewedAt'] as String),
  createdDate: AccountRequestModel._readCreatedDate(json, 'createdDate') == null
      ? null
      : DateTime.parse(
          AccountRequestModel._readCreatedDate(json, 'createdDate') as String,
        ),
  createdEmployeeId: json['createdEmployeeId'] as String?,
);
