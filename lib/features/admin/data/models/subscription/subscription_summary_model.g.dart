// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubscriptionPlanModel _$SubscriptionPlanModelFromJson(
  Map<String, dynamic> json,
) => SubscriptionPlanModel(
  code: json['code'] as String?,
  name: json['name'] as String?,
);

Map<String, dynamic> _$SubscriptionPlanModelToJson(
  SubscriptionPlanModel instance,
) => <String, dynamic>{'code': instance.code, 'name': instance.name};

SubscriptionUsageModel _$SubscriptionUsageModelFromJson(
  Map<String, dynamic> json,
) => SubscriptionUsageModel(
  employees: (json['employees'] as num?)?.toInt(),
  loginAccounts: (json['loginAccounts'] as num?)?.toInt(),
);

Map<String, dynamic> _$SubscriptionUsageModelToJson(
  SubscriptionUsageModel instance,
) => <String, dynamic>{
  'employees': instance.employees,
  'loginAccounts': instance.loginAccounts,
};

SubscriptionSummaryModel _$SubscriptionSummaryModelFromJson(
  Map<String, dynamic> json,
) => SubscriptionSummaryModel(
  companyName: json['companyName'] as String?,
  tenantStatus: json['tenantStatus'] as String?,
  isTrial: json['isTrial'] as bool?,
  trialEndsAt: json['trialEndsAt'] == null
      ? null
      : DateTime.parse(json['trialEndsAt'] as String),
  plan: json['plan'] == null
      ? null
      : SubscriptionPlanModel.fromJson(json['plan'] as Map<String, dynamic>),
  subscriptionStatus: json['subscriptionStatus'] as String?,
  seatLimit: (json['seatLimit'] as num?)?.toInt(),
  loginAccountLimit: (json['loginAccountLimit'] as num?)?.toInt(),
  usage: json['usage'] == null
      ? null
      : SubscriptionUsageModel.fromJson(json['usage'] as Map<String, dynamic>),
  pendingRequest: json['pendingRequest'] == null
      ? null
      : SeatRequestModel.fromJson(
          json['pendingRequest'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$SubscriptionSummaryModelToJson(
  SubscriptionSummaryModel instance,
) => <String, dynamic>{
  'companyName': instance.companyName,
  'tenantStatus': instance.tenantStatus,
  'isTrial': instance.isTrial,
  'trialEndsAt': instance.trialEndsAt?.toIso8601String(),
  'plan': instance.plan,
  'subscriptionStatus': instance.subscriptionStatus,
  'seatLimit': instance.seatLimit,
  'loginAccountLimit': instance.loginAccountLimit,
  'usage': instance.usage,
  'pendingRequest': instance.pendingRequest,
};

SubscriptionSummaryResultModel _$SubscriptionSummaryResultModelFromJson(
  Map<String, dynamic> json,
) => SubscriptionSummaryResultModel(
  value: json['value'] == null
      ? null
      : SubscriptionSummaryModel.fromJson(
          json['value'] as Map<String, dynamic>,
        ),
  isSuccess: json['isSuccess'] as bool?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$SubscriptionSummaryResultModelToJson(
  SubscriptionSummaryResultModel instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'errors': instance.errors,
};
