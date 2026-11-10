import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/pending_attendance_reason_badge_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/pending_attendance_time_chip_widget.dart';

class PendingAttendanceVerificationCardWidget extends StatelessWidget {
  const PendingAttendanceVerificationCardWidget({
    super.key,
    required this.item,
    required this.onApprove,
    required this.onReject,
  });

  final PendingAttendanceItem item;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.1),
                child: Text(
                  item.employeeName.isNotEmpty
                      ? item.employeeName[0].toUpperCase()
                      : '?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.brandPrimary,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.employeeName, style: AppTextStyles.font16Bold),
                    if (item.employeeCode != null)
                      Text(
                        item.employeeCode!,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              if (item.attendanceDate != null)
                Text(
                  AppDateFormatter.formatYearMonthDay(item.attendanceDate!),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              if (item.clockInTime != null)
                Expanded(
                  child: PendingAttendanceTimeChipWidget(
                    label: 'دخول',
                    time: AppDateFormatter.formatTime(item.clockInTime!),
                    icon: Icons.login_rounded,
                  ),
                ),
              if (item.clockOutTime != null) ...[
                SizedBox(width: 8.w),
                Expanded(
                  child: PendingAttendanceTimeChipWidget(
                    label: 'خروج',
                    time: AppDateFormatter.formatTime(item.clockOutTime!),
                    icon: Icons.logout_rounded,
                  ),
                ),
              ],
            ],
          ),
          if (item.verificationReasons.isNotEmpty) ...[
            SizedBox(height: 10.h),
            Wrap(
              spacing: 6.w,
              runSpacing: 6.h,
              children: item.verificationReasons
                  .map((r) => PendingAttendanceReasonBadgeWidget(reason: r))
                  .toList(),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: const BorderSide(color: AppColors.error),
                ),
                onPressed: onReject,
                icon: const Icon(Icons.close_rounded, size: 16),
                label: Text('offline.reject'.tr()),
              ),
              SizedBox(width: 8.w),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                ),
                onPressed: onApprove,
                icon: const Icon(Icons.check_rounded, size: 16),
                label: Text('offline.approve'.tr()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
