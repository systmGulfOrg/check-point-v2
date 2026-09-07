import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import 'admin_overview_row_widget.dart';

class AdminOverviewCardWidget extends StatelessWidget {
  const AdminOverviewCardWidget({
    required this.employeesOnDuty,
    required this.totalStaff,
    required this.lateArrivals,
    required this.absences,
    required this.pendingLeaveRequests,
    required this.dateText,
    this.isLoading = false,
    super.key,
  });

  final int employeesOnDuty;
  final int totalStaff;
  final int lateArrivals;
  final int absences;
  final int pendingLeaveRequests;
  final String dateText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(18.r),
          border: Border.all(color: AppColors.border),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.trending_up_rounded,
                        color: AppColors.brandPrimary,
                        size: 20.r,
                      ),
                      vSpace(8),
                      Text(
                        'admin.dashboard.todaysOverview'.tr(context: context),
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    dateText,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.border, height: 1),
            AdminOverviewRowWidget(
              titleKey: 'admin.dashboard.employeesOnDuty',
              value: '$employeesOnDuty / $totalStaff',
              valueColor: AppColors.success,
            ),
            const Divider(color: AppColors.border, height: 1),
            AdminOverviewRowWidget(
              titleKey: 'admin.dashboard.lateArrivals',
              value: '$lateArrivals',
              valueColor: AppColors.warningOrange,
            ),
            const Divider(color: AppColors.border, height: 1),
            AdminOverviewRowWidget(
              titleKey: 'admin.dashboard.absences',
              value: '$absences',
              valueColor: AppColors.error,
            ),
            const Divider(color: AppColors.border, height: 1),
            AdminOverviewRowWidget(
              titleKey: 'admin.dashboard.pendingLeaveRequests',
              value: '$pendingLeaveRequests',
              valueColor: AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
