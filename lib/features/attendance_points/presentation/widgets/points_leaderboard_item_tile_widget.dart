import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_leaderboard_model.dart';

class PointsLeaderboardItemTileWidget extends StatelessWidget {
  const PointsLeaderboardItemTileWidget({
    required this.entry,
    super.key,
  });

  final PointsLeaderboardEntryModel entry;

  @override
  Widget build(BuildContext context) {
    final isMe = entry.isCurrentUser;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: isMe
            ? AppColors.brandPrimary.withValues(alpha: 0.08)
            : AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isMe
              ? AppColors.brandPrimary
              : AppColors.border.withValues(alpha: 0.6),
          width: isMe ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank
          Container(
            width: 32.r,
            height: 32.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: entry.rank <= 3
                  ? AppColors.warningOrange.withValues(alpha: 0.15)
                  : AppColors.border.withValues(alpha: 0.4),
            ),
            child: Center(
              child: Text(
                '${entry.rank}',
                style: AppTextStyles.font12Bold.copyWith(
                  color: entry.rank <= 3
                      ? AppColors.warningOrange
                      : AppColors.textPrimary,
                ),
              ),
            ),
          ),
          wSpace(12),

          // Name & department
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        entry.name,
                        style: AppTextStyles.font14Bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (isMe) ...[
                      wSpace(6),
                      Text(
                        'points.you'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ],
                ),
                if (entry.departmentName != null) ...[
                  hSpace(2),
                  Text(
                    entry.departmentName!,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Points & streak
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${entry.effectivePoints} pts',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.success,
                ),
              ),
              if (entry.currentStreak > 0) ...[
                hSpace(2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.local_fire_department_rounded,
                      size: 14.r,
                      color: AppColors.warningOrange,
                    ),
                    Text(
                      '${entry.currentStreak}',
                      style: AppTextStyles.font10Medium.copyWith(
                        color: AppColors.warningOrange,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
