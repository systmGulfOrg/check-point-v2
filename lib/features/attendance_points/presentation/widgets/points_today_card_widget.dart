import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_summary_model.dart';

class PointsTodayCardWidget extends StatelessWidget {
  const PointsTodayCardWidget({
    required this.summary,
    required this.onTap,
    super.key,
  });

  final PointsSummaryModel summary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final balances = summary.balances;
    final level = summary.level;
    final streak = summary.streak;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
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
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.stars_rounded,
                        color: AppColors.brandPrimary,
                        size: 20.r,
                      ),
                    ),
                    wSpace(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'points.title'.tr(context: context),
                          style: AppTextStyles.font16Bold,
                        ),
                        Text(
                          '${level.tier} • ${level.currentPoints} pts',
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.warningOrange.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department_rounded,
                          color: AppColors.warningOrange,
                          size: 16.r,
                        ),
                        wSpace(4),
                        Text(
                          '${streak.currentStreak}d',
                          style: AppTextStyles.font12Bold.copyWith(
                            color: AppColors.warningOrange,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            hSpace(12),
            Row(
              children: [
                Expanded(
                  child: _BalanceChip(
                    label: 'points.greenConfirmed'.tr(context: context),
                    value: '+${balances.greenConfirmed}',
                    color: AppColors.success,
                    icon: Icons.add_circle_outline_rounded,
                  ),
                ),
                wSpace(8),
                Expanded(
                  child: _BalanceChip(
                    label: 'points.red'.tr(context: context),
                    value: '-${balances.red}',
                    color: AppColors.error,
                    icon: Icons.remove_circle_outline_rounded,
                  ),
                ),
                if (balances.black > 0) ...[
                  wSpace(8),
                  Expanded(
                    child: _BalanceChip(
                      label: 'points.black'.tr(context: context),
                      value: '-${balances.black}',
                      color: Colors.black87,
                      icon: Icons.warning_amber_rounded,
                    ),
                  ),
                ],
              ],
            ),
            if (balances.greenPending > 0) ...[
              hSpace(10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.info.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 14.r, color: AppColors.info),
                    wSpace(6),
                    Expanded(
                      child: Text(
                        'points.todayEarlyReward'.tr(
                          context: context,
                          args: [balances.greenPending.toString()],
                        ),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _BalanceChip extends StatelessWidget {
  const _BalanceChip({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  final String label;
  final String value;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: color),
          wSpace(6),
          Expanded(
            child: Text(
              value,
              style: AppTextStyles.font14Bold.copyWith(color: color),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
