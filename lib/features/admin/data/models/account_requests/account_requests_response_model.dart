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
  const AccountRequestsPageModel({
    this.items,
    this.data,
    this.totalCount,
    this.hasNext,
  });

  final List<AccountRequestModel>? items;
  final List<AccountRequestModel>? data;
  final int? totalCount;
  final bool? hasNext;

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
    this.imageThumbUrl,
  });

  /// The legacy numeric id. v2 lists send the ULID as `id` and the number as
  /// `legacyId`; the v1 approve/reject/delete routes take the number.
  @JsonKey(readValue: _readLegacyId)
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

  /// Small (256px) version for list rows; null for old inline photos.
  final String? imageThumbUrl;

  static Object? _readLegacyId(Map<dynamic, dynamic> json, String key) {
    final legacy = json['legacyId'];
    if (legacy is int) return legacy;
    final id = json['id'];
    return id is int ? id : int.tryParse('$id');
  }

  static Object? _readCreatedDate(Map<dynamic, dynamic> json, String key) {
    return json['createdDate'] ?? json['createdAt'] ?? json['created_at'];
  }

  String? get photo => (imageUrl != null && imageUrl!.isNotEmpty)
      ? imageUrl
      : (photoPath != null && photoPath!.isNotEmpty)
      ? photoPath
      : null;

  /// Thumbnail for list rows, falling back to the full photo.
  String? get thumb =>
      (imageThumbUrl != null && imageThumbUrl!.isNotEmpty) ? imageThumbUrl : photo;

  bool get isPending => status == null || status == 'Pending';
  bool get isApproved => status == 'Approved';
  bool get isRejected => status == 'Rejected';

  factory AccountRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestModelFromJson(json);
}
