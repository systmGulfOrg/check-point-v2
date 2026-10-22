import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_badge_model.dart';

class PointsBadgeCardWidget extends StatelessWidget {
  const PointsBadgeCardWidget({
    required this.badge,
    required this.isArabic,
    super.key,
  });

  final PointsBadgeItemModel badge;
  final bool isArabic;

  @override
  Widget build(BuildContext context) {
    final isUnlocked = badge.isUnlocked;
    final title = isArabic ? badge.displayTitleAr : badge.displayTitleEn;
    final description = isArabic ? badge.displayDescAr : badge.displayDescEn;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isUnlocked
              ? AppColors.warningOrange.withValues(alpha: 0.5)
              : AppColors.border.withValues(alpha: 0.6),
          width: isUnlocked ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isUnlocked
                ? AppColors.warningOrange.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 68.r,
            height: 68.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: isUnlocked
                  ? AppColors.brandGradient
                  : LinearGradient(
                      colors: [
                        AppColors.border.withValues(alpha: 0.45),
                        AppColors.pageBackground,
                      ],
                      begin: AlignmentDirectional.topStart,
                      end: AlignmentDirectional.bottomEnd,
                    ),
              boxShadow: isUnlocked
                  ? [
                      BoxShadow(
                        color: AppColors.brandPrimary.withValues(alpha: 0.25),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
              border: Border.all(
                color: isUnlocked
                    ? AppColors.white.withValues(alpha: 0.8)
                    : AppColors.border,
                width: 2,
              ),
            ),
            child: Icon(
              _getBadgeIcon(badge.icon),
              size: 34.r,
              color: isUnlocked ? AppColors.white : AppColors.textSecondary,
            ),
          ),
          hSpace(10),

          Text(
            title,
            style: AppTextStyles.font14Bold.copyWith(
              color: isUnlocked
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(4),

          Text(
            description,
            style: AppTextStyles.font10Medium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(10),

          if (isUnlocked) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'points.unlockedAt'.tr(
                  context: context,
                  args: [badge.unlockedAt ?? ''],
                ),
                style: AppTextStyles.font10Medium.copyWith(
                  color: AppColors.success,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ] else ...[
            LinearProgressIndicator(
              value: badge.effectiveProgress.clamp(0.0, 1.0),
              backgroundColor: AppColors.border,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.brandPrimary,
              ),
              minHeight: 5.h,
              borderRadius: BorderRadius.circular(3.r),
            ),
            hSpace(4),
            Text(
              badge.threshold != null
                  ? 'points.progress'.tr(
                      context: context,
                      args: [
                        '${(badge.effectiveProgress * badge.threshold!).round()}',
                        '${badge.threshold}',
                      ],
                    )
                  : '${(badge.effectiveProgress * 100).round()}%',
              style: AppTextStyles.font10Medium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getBadgeIcon(String? iconKey) {
    final key = (iconKey ?? badge.key).toLowerCase();
    return switch (key) {
      'falcon' || 'flight' => Icons.flight_takeoff_rounded,
      'shield' || 'disciplined' => Icons.verified_rounded,
      'life_ring' || 'rescuer' => Icons.healing_rounded,
      'star' || 'committed' => Icons.military_tech_rounded,
      _ => Icons.workspace_premium_rounded,
    };
  }
}
