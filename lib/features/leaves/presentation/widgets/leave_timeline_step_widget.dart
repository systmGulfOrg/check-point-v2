import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';

enum LeaveStepStatus {
  completed,
  inProgress,
  rejected,
  waiting,
}

class LeaveTimelineStepWidget extends StatelessWidget {
  const LeaveTimelineStepWidget({
    super.key,
    required this.title,
    this.actor,
    this.date,
    this.reason,
    required this.status,
    this.isLast = false,
  });

  final String title;
  final String? actor;
  final String? date;
  final String? reason;
  final LeaveStepStatus status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final (dotColor, lineColor, textColor) = switch (status) {
      LeaveStepStatus.completed => (
        AppColors.success,
        AppColors.success,
        AppColors.textPrimary,
      ),
      LeaveStepStatus.inProgress => (
        AppColors.warningOrange,
        AppColors.border,
        AppColors.textPrimary,
      ),
      LeaveStepStatus.rejected => (
        AppColors.error,
        AppColors.error,
        AppColors.error,
      ),
      LeaveStepStatus.waiting => (
        AppColors.placeholder,
        AppColors.border,
        AppColors.textSecondary,
      ),
    };

    final icon = switch (status) {
      LeaveStepStatus.completed => Icons.check,
      LeaveStepStatus.inProgress => Icons.hourglass_top_rounded,
      LeaveStepStatus.rejected => Icons.close,
      LeaveStepStatus.waiting => Icons.circle,
    };

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 24.w,
            child: Column(
              children: [
                Container(
                  width: 20.r,
                  height: 20.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: status == LeaveStepStatus.waiting
                        ? AppColors.white
                        : dotColor,
                    border: Border.all(
                      color: dotColor,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: status == LeaveStepStatus.waiting
                        ? SizedBox(
                            width: 6.r,
                            height: 6.r,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: dotColor,
                              ),
                            ),
                          )
                        : Icon(
                            icon,
                            size: 11.r,
                            color: AppColors.white,
                          ),
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2.w,
                      color: lineColor,
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: textColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (date != null && date!.isNotEmpty)
                        Text(
                          date!,
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                    ],
                  ),
                  if (actor != null && actor!.isNotEmpty) ...[
                    SizedBox(height: 3.h),
                    Text(
                      actor!,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: status == LeaveStepStatus.rejected
                            ? AppColors.error
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (reason != null && reason!.isNotEmpty) ...[
                    SizedBox(height: 6.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softRedBackground,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        reason!,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
