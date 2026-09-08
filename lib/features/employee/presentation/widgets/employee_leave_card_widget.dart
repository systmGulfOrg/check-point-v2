import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'employee_leave_data.dart';

class EmployeeLeaveCardWidget extends StatelessWidget {
  const EmployeeLeaveCardWidget({required this.leave, super.key});

  final EmployeeLeaveData leave;

  @override
  Widget build(BuildContext context) {
    final (statusBg, statusText) = switch (leave.status) {
      'Approved' => (AppColors.softGreenBackground, AppColors.success),
      'Rejected' => (const Color(0xFFFEE2E2), AppColors.error),
      _ => (AppColors.softYellowBackground, AppColors.warningOrange),
    };

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leave.leaveType, style: AppTextStyles.font16Bold),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusBg,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: statusText,
                        shape: BoxShape.circle,
                      ),
                    ),
                    wSpace(6),
                    Text(
                      leave.status,
                      style: AppTextStyles.font12Medium.copyWith(
                        color: statusText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(8),
          Text(
            leave.dateRange,
            style: AppTextStyles.font13Regular.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (leave.reason != null) ...[
            hSpace(4),
            Text(
              leave.reason!,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          hSpace(8),
          Text(
            leave.appliedDate,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.placeholder,
            ),
          ),
        ],
      ),
    );
  }
}
