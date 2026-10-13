import 'package:freezed_annotation/freezed_annotation.dart';

part 'points_badge_model.freezed.dart';
part 'points_badge_model.g.dart';

@freezed
class PointsBadgeItemModel with _$PointsBadgeItemModel {
  const PointsBadgeItemModel._();

  const factory PointsBadgeItemModel({
    required String key,
    String? nameEn,
    String? nameAr,
    String? title,
    String? titleAr,
    String? descriptionEn,
    String? descriptionAr,
    String? description,
    String? icon,
    int? threshold,
    @Default(false) bool isUnlocked,
    String? unlockedAt,
    double? progress,
    @Default(0) int currentProgress,
    @Default(0) int targetProgress,
    @Default(0.0) double progressPercentage,
  }) = _PointsBadgeItemModel;

  String get displayTitleEn => nameEn ?? title ?? key;
  String get displayTitleAr => nameAr ?? titleAr ?? displayTitleEn;
  String get displayDescEn => descriptionEn ?? description ?? '';
  String get displayDescAr => descriptionAr ?? displayDescEn;
  double get effectiveProgress => progress ?? progressPercentage;

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
