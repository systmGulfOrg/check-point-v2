import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_badge_model.freezed.dart';
part 'points_badge_model.g.dart';

@freezed
class PointsBadgeItemModel with _$PointsBadgeItemModel {
  const factory PointsBadgeItemModel({
    required String key,
    required String title,
    required String titleAr,
    required String description,
    required String descriptionAr,
    required String icon,
    @Default(false) bool isUnlocked,
    String? unlockedAt,
    @Default(0) int currentProgress,
    @Default(0) int targetProgress,
    @Default(0.0) double progressPercentage,
  }) = _PointsBadgeItemModel;

  factory PointsBadgeItemModel.fromJson(Map<String, dynamic> json) =>
      _$PointsBadgeItemModelFromJson(json);
}

@freezed
class PointsBadgesResponseModel with _$PointsBadgesResponseModel {
  const factory PointsBadgesResponseModel({
    @Default(<PointsBadgeItemModel>[]) List<PointsBadgeItemModel> value,
    bool? isSuccess,
    String? successMessage,
    List<String>? errors,
  }) = _PointsBadgesResponseModel;

  factory PointsBadgesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PointsBadgesResponseModelFromJson(json);
}
