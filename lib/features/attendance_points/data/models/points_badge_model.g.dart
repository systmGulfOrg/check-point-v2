// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'points_badge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PointsBadgeItemModelImpl _$$PointsBadgeItemModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsBadgeItemModelImpl(
  key: json['key'] as String,
  title: json['title'] as String,
  titleAr: json['titleAr'] as String,
  description: json['description'] as String,
  descriptionAr: json['descriptionAr'] as String,
  icon: json['icon'] as String,
  isUnlocked: json['isUnlocked'] as bool? ?? false,
  unlockedAt: json['unlockedAt'] as String?,
  currentProgress: (json['currentProgress'] as num?)?.toInt() ?? 0,
  targetProgress: (json['targetProgress'] as num?)?.toInt() ?? 0,
  progressPercentage: (json['progressPercentage'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$$PointsBadgeItemModelImplToJson(
  _$PointsBadgeItemModelImpl instance,
) => <String, dynamic>{
  'key': instance.key,
  'title': instance.title,
  'titleAr': instance.titleAr,
  'description': instance.description,
  'descriptionAr': instance.descriptionAr,
  'icon': instance.icon,
  'isUnlocked': instance.isUnlocked,
  'unlockedAt': instance.unlockedAt,
  'currentProgress': instance.currentProgress,
  'targetProgress': instance.targetProgress,
  'progressPercentage': instance.progressPercentage,
};

_$PointsBadgesResponseModelImpl _$$PointsBadgesResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$PointsBadgesResponseModelImpl(
  value:
      (json['value'] as List<dynamic>?)
          ?.map((e) => PointsBadgeItemModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const <PointsBadgeItemModel>[],
  isSuccess: json['isSuccess'] as bool?,
  successMessage: json['successMessage'] as String?,
  errors: (json['errors'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$$PointsBadgesResponseModelImplToJson(
  _$PointsBadgesResponseModelImpl instance,
) => <String, dynamic>{
  'value': instance.value,
  'isSuccess': instance.isSuccess,
  'successMessage': instance.successMessage,
  'errors': instance.errors,
};
