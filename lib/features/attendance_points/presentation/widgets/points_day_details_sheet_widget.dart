import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/points_history_model.dart';

class PointsDayDetailsSheetWidget extends StatelessWidget {
  const PointsDayDetailsSheetWidget({
    required this.recordDate,
    required this.dayPoints,
    super.key,
  });

  final String recordDate;
  final List<PointsHistoryItemModel> dayPoints;

  static void show(
    BuildContext context, {
    required String recordDate,
    required List<PointsHistoryItemModel> dayPoints,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => PointsDayDetailsSheetWidget(
        recordDate: recordDate,
        dayPoints: dayPoints,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          hSpace(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'points.detailsSheetTitle'.tr(context: context),
                style: AppTextStyles.font18Bold,
              ),
              Text(
                recordDate,
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          hSpace(16),
          if (dayPoints.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'No point events recorded for this date.',
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ),
            )
          else
            ...dayPoints.map((pt) {
              final isGreen = pt.pointType == 'GREEN';
              final isRed = pt.pointType == 'RED';
              final color = isGreen
                  ? AppColors.success
                  : (isRed ? AppColors.error : Colors.black87);
              final sign = isGreen ? '+' : '-';
              final snapshot = pt.computationSnapshot ?? {};
              final coveredMinutes = snapshot['coveredMinutes'] ?? 0;
              final uncoveredMinutes = snapshot['uncoveredMinutes'] ?? 0;

              return Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: color.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pt.reason,
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '$sign${pt.points}',
                          style: AppTextStyles.font16Bold.copyWith(
                            color: color,
                          ),
                        ),
                      ],
                    ),
                    hSpace(6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            pt.status,
                            style: AppTextStyles.font11Bold.copyWith(
                              color: color,
                            ),
                          ),
                        ),
                        wSpace(8),
                        if (pt.cancelReason != null) ...[
                          Text(
                            pt.cancelReason!,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (coveredMinutes > 0 || uncoveredMinutes > 0) ...[
                      hSpace(8),
                      Text(
                        'points.coveredTime'.tr(
                          context: context,
                          args: [coveredMinutes.toString()],
                        ),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                      Text(
                        'points.uncoveredTime'.tr(
                          context: context,
                          args: [uncoveredMinutes.toString()],
                        ),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }),
          hSpace(12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.brandPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
              child: Text(
                'core.actions.ok'.tr(context: context),
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
