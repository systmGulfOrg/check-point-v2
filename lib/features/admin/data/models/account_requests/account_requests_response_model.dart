import 'package:json_annotation/json_annotation.dart';

import 'package:check_point_v2/core/utils/legacy_api_response_helpers.dart';

part 'account_requests_response_model.g.dart';

@JsonSerializable(createToJson: false)
class AccountRequestsResponseModel {
  const AccountRequestsResponseModel({this.value, this.isSuccess, this.errors});

  final AccountRequestsPageModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory AccountRequestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestsResponseModelFromJson({
        ...json,
        'value': legacyPageValue(json['value']),
      });
}

@JsonSerializable(createToJson: false)
class AccountRequestsPageModel {
  const AccountRequestsPageModel({this.items, this.data, this.totalCount});

  final List<AccountRequestModel>? items;
  final List<AccountRequestModel>? data;
  final int? totalCount;

  List<AccountRequestModel> get list => items ?? data ?? const [];

  factory AccountRequestsPageModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestsPageModelFromJson(json);
}

@JsonSerializable(createToJson: false)
class AccountRequestModel {
  const AccountRequestModel({
    this.id,
    this.name,
    this.mobileId,
    this.phone,
    this.deviceToken,
    this.imageUrl,
    this.photoPath,
    this.status,
    this.rejectReason,
    this.reviewedBy,
    this.reviewedAt,
    this.createdDate,
    this.createdEmployeeId,
  });

  final int? id;
  final String? name;
  final String? mobileId;
  final String? phone;
  final String? deviceToken;
  final String? imageUrl;
  final String? photoPath;
  final String? status;
  final String? rejectReason;
  final String? reviewedBy;
  final DateTime? reviewedAt;
  @JsonKey(readValue: _readCreatedDate)
  final DateTime? createdDate;
  final String? createdEmployeeId;

  static Object? _readCreatedDate(Map<dynamic, dynamic> json, String key) {
    return json['createdDate'] ?? json['createdAt'] ?? json['created_at'];
  }

  String? get photo => (imageUrl != null && imageUrl!.isNotEmpty)
      ? imageUrl
      : (photoPath != null && photoPath!.isNotEmpty)
      ? photoPath
      : null;

  bool get isPending => status == null || status == 'Pending';
  bool get isApproved => status == 'Approved';
  bool get isRejected => status == 'Rejected';

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);
}
