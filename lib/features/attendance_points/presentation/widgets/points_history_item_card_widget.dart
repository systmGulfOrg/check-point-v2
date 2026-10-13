import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';

class PointsHistoryItemCardWidget extends StatelessWidget {
  const PointsHistoryItemCardWidget({
    required this.item,
    super.key,
  });

  final PointsHistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    final isGreen = item.pointType.toUpperCase() == 'GREEN';
    final isRed = item.pointType.toUpperCase() == 'RED';
    final isCancelled = item.status.toUpperCase() == 'CANCELLED';
    final isPending = item.status.toUpperCase() == 'PENDING';

    final Color badgeColor = isCancelled
        ? AppColors.textSecondary
        : isGreen
            ? AppColors.success
            : isRed
                ? AppColors.error
                : AppColors.textPrimary;

    final String sign = isGreen ? '+' : '-';

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCancelled
              ? AppColors.border
              : badgeColor.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Point type & amount
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '$sign${item.points}',
                      style: AppTextStyles.font14Bold.copyWith(
                        color: badgeColor,
                        decoration:
                            isCancelled ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ),
                  wSpace(10),
                  Text(
                    item.reason,
                    style: AppTextStyles.font14Bold.copyWith(
                      decoration:
                          isCancelled ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
              // Status Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: isPending
                      ? AppColors.warningOrange.withValues(alpha: 0.1)
                      : isCancelled
                          ? AppColors.error.withValues(alpha: 0.1)
                          : AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  item.status,
                  style: AppTextStyles.font10Medium.copyWith(
                    color: isPending
                        ? AppColors.warningOrange
                        : isCancelled
                            ? AppColors.error
                            : AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          hSpace(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.attendanceDate,
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              if (item.cancelReason != null)
                Flexible(
                  child: Text(
                    item.cancelReason!,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.error,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
