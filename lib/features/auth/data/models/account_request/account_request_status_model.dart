import 'package:json_annotation/json_annotation.dart';

part 'account_request_status_model.g.dart';

@JsonSerializable()
class AccountRequestStatusModel {
  const AccountRequestStatusModel({
    required this.status,
    this.name,
    this.rejectReason,
    this.reviewedAt,
    this.createdEmployeeId,
  });

  final String status;
  final String? name;
  final String? rejectReason;
  final DateTime? reviewedAt;
  final String? createdEmployeeId;

  factory AccountRequestStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AccountRequestStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$AccountRequestStatusModelToJson(this);
}

@JsonSerializable()
class AccountRequestStatusResponseModel {
  const AccountRequestStatusResponseModel({this.value});

  final AccountRequestStatusModel? value;

  factory AccountRequestStatusResponseModel.fromJson(
    Map<String, dynamic> json,
  ) => _$AccountRequestStatusResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AccountRequestStatusResponseModelToJson(this);
}
