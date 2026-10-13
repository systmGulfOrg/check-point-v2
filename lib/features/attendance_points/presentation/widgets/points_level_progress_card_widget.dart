import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';

class PointsLevelProgressCardWidget extends StatelessWidget {
  const PointsLevelProgressCardWidget({
    required this.summary,
    super.key,
  });

  final PointsSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final level = summary.level;
    final streak = summary.streak;

    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48.r,
                    height: 48.r,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.brandPrimary.withValues(alpha: 0.2),
                          AppColors.brandPrimary.withValues(alpha: 0.05),
                        ],
                        begin: AlignmentDirectional.topStart,
                        end: AlignmentDirectional.bottomEnd,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.stars_rounded,
                      color: AppColors.brandPrimary,
                      size: 28.r,
                    ),
                  ),
                  wSpace(14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        level.tier.toUpperCase(),
                        style: AppTextStyles.font18Bold.copyWith(
                          letterSpacing: 0.8,
                        ),
                      ),
                      hSpace(2),
                      Text(
                        '${level.currentPoints} pts',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (streak.currentStreak > 0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.warningOrange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColors.warningOrange.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_fire_department_rounded,
                        size: 18.r,
                        color: AppColors.warningOrange,
                      ),
                      wSpace(4),
                      Text(
                        'points.streakDays'.tr(
                          context: context,
                          args: [streak.currentStreak.toString()],
                        ),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.warningOrange,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          hSpace(20),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: LinearProgressIndicator(
              value: level.progress.clamp(0.0, 1.0),
              minHeight: 10.h,
              backgroundColor: AppColors.border.withValues(alpha: 0.4),
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.brandPrimary,
              ),
            ),
          ),
          hSpace(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'points.nextLevel'.tr(
                  context: context,
                  args: [
                    (level.nextLevelPoints - level.currentPoints).toString(),
                  ],
                ),
                style: AppTextStyles.font11Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                '${(level.progress * 100).toInt()}%',
                style: AppTextStyles.font11Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
