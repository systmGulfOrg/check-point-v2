// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsBalancesModelImpl _$$PointsBalancesModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsBalancesModelImpl(
  greenConfirmed: (json['greenConfirmed'] as num?)?.toInt() ?? 0,
  greenPending: (json['greenPending'] as num?)?.toInt() ?? 0,
  red: (json['red'] as num?)?.toInt() ?? 0,
  black: (json['black'] as num?)?.toInt() ?? 0,
  expiringSoonGreen: (json['expiringSoonGreen'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PointsBalancesModelImplToJson(
  _$PointsBalancesModelImpl instance,
) => <String, dynamic>{
  'greenConfirmed': instance.greenConfirmed,
  'greenPending': instance.greenPending,
  'red': instance.red,
  'black': instance.black,
  'expiringSoonGreen': instance.expiringSoonGreen,
};

_$PointsLevelModelImpl _$$PointsLevelModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsLevelModelImpl(
  tier: json['tier'] as String? ?? 'Bronze',
  currentPoints: (json['currentPoints'] as num?)?.toInt() ?? 0,
  nextLevelPoints: (json['nextLevelPoints'] as num?)?.toInt() ?? 101,
  progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$PointsLevelModelImplToJson(
  _$PointsLevelModelImpl instance,
) => <String, dynamic>{
  'tier': instance.tier,
  'currentPoints': instance.currentPoints,
  'nextLevelPoints': instance.nextLevelPoints,
  'progress': instance.progress,
};

_$PointsStreakModelImpl _$$PointsStreakModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsStreakModelImpl(
  currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
  highestStreak: (json['highestStreak'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$PointsStreakModelImplToJson(
  _$PointsStreakModelImpl instance,
) => <String, dynamic>{
  'currentStreak': instance.currentStreak,
  'highestStreak': instance.highestStreak,
};

_$PointsSettingsModelImpl _$$PointsSettingsModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsSettingsModelImpl(
  redExchangeRate: (json['redExchangeRate'] as num?)?.toInt() ?? 1,
  blackExchangeCost: (json['blackExchangeCost'] as num?)?.toInt() ?? 30,
  tieredRateEnabled: json['tieredRateEnabled'] as bool? ?? false,
  graceMinutes: (json['graceMinutes'] as num?)?.toInt() ?? 10,
);

Map<String, dynamic> _$$PointsSettingsModelImplToJson(
  _$PointsSettingsModelImpl instance,
) => <String, dynamic>{
  'redExchangeRate': instance.redExchangeRate,
  'blackExchangeCost': instance.blackExchangeCost,
  'tieredRateEnabled': instance.tieredRateEnabled,
  'graceMinutes': instance.graceMinutes,
};

_$PointsSummaryModelImpl _$$PointsSummaryModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsSummaryModelImpl(
  employeeId: json['employeeId'] as String?,
  balances: json['balances'] == null
      ? const PointsBalancesModel()
      : PointsBalancesModel.fromJson(json['balances'] as Map<String, dynamic>),
  level: json['level'] == null
      ? const PointsLevelModel()
      : PointsLevelModel.fromJson(json['level'] as Map<String, dynamic>),
  streak: json['streak'] == null
      ? const PointsStreakModel()
      : PointsStreakModel.fromJson(json['streak'] as Map<String, dynamic>),
  settings: json['settings'] == null
      ? const PointsSettingsModel()
      : PointsSettingsModel.fromJson(json['settings'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PointsSummaryModelImplToJson(
  _$PointsSummaryModelImpl instance,
) => <String, dynamic>{
  'employeeId': instance.employeeId,
  'balances': instance.balances,
  'level': instance.level,
  'streak': instance.streak,
  'settings': instance.settings,
};

_$PointsSummaryResponseModelImpl _$$PointsSummaryResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsSummaryResponseModelImpl(
  value: json['value'] == null
      ? null
      : PointsSummaryModel.fromJson(json['value'] as Map<String, dynamic>),
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$PointsSummaryResponseModelImplToJson(
  _$PointsSummaryResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
