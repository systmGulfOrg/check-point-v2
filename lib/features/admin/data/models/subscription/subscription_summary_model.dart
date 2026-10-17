import 'package:json_annotation/json_annotation.dart';

import 'seat_request_model.dart';

part 'subscription_summary_model.g.dart';

@JsonSerializable()
class SubscriptionPlanModel {
  const SubscriptionPlanModel({this.code, this.name});

  final String? code;
  final String? name;

  factory SubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPlanModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionPlanModelToJson(this);
}

@JsonSerializable()
class SubscriptionUsageModel {
  const SubscriptionUsageModel({this.employees, this.loginAccounts});

  final int? employees;
  final int? loginAccounts;

  factory SubscriptionUsageModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionUsageModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionUsageModelToJson(this);
}

@JsonSerializable()
class SubscriptionSummaryModel {
  const SubscriptionSummaryModel({
    this.companyName,
    this.tenantStatus,
    this.isTrial,
    this.trialEndsAt,
    this.plan,
    this.subscriptionStatus,
    this.seatLimit,
    this.loginAccountLimit,
    this.usage,
    this.pendingRequest,
  });

  final String? companyName;
  final String? tenantStatus;
  final bool? isTrial;
  final DateTime? trialEndsAt;
  final SubscriptionPlanModel? plan;
  final String? subscriptionStatus;
  final int? seatLimit;
  final int? loginAccountLimit;
  final SubscriptionUsageModel? usage;
  final SeatRequestModel? pendingRequest;

  factory SubscriptionSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionSummaryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionSummaryModelToJson(this);
}

@JsonSerializable()
class SubscriptionSummaryResultModel {
  const SubscriptionSummaryResultModel({
    this.value,
    this.isSuccess,
    this.errors,
  });

  final SubscriptionSummaryModel? value;
  final bool? isSuccess;
  final List<String>? errors;

  factory SubscriptionSummaryResultModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionSummaryResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionSummaryResultModelToJson(this);
}
