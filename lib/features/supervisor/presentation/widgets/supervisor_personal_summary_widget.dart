import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'supervisor_summary_pill_widget.dart';
import 'supervisor_summary_time_widget.dart';

class SupervisorPersonalSummaryWidget extends StatelessWidget {
  const SupervisorPersonalSummaryWidget({
    required this.policyName,
    required this.workSystem,
    required this.workMode,
    required this.workStart,
    required this.workEnd,
    required this.checkIn,
    required this.checkOut,
    required this.leaveBalance,
    super.key,
  });

  final String policyName;
  final String workSystem;
  final String workMode;
  final String workStart;
  final String workEnd;
  final String checkIn;
  final String checkOut;
  final String leaveBalance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.softBlueBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.work_history_outlined,
                  color: AppColors.info,
                  size: 20.r,
                ),
              ),
              wSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'supervisor.dashboard.personalToday'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    hSpace(3),
                    Text(
                      policyName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(12),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: [
              SupervisorSummaryPillWidget(
                icon: Icons.home_work_outlined,
                label: '$workSystem • $workMode',
                color: AppColors.info,
                background: AppColors.softBlueBackground,
              ),
              SupervisorSummaryPillWidget(
                icon: Icons.beach_access_outlined,
                label:
                    '$leaveBalance ${'employee.home.leaveBalance'.tr(context: context)}',
                color: AppColors.success,
                background: AppColors.softGreenBackground,
              ),
            ],
          ),
          hSpace(12),
          Row(
            children: [
              Expanded(
                child: SupervisorSummaryTimeWidget(
                  label: 'employee.home.checkInLabel'.tr(context: context),
                  value: checkIn,
                  color: AppColors.success,
                  background: AppColors.softGreenBackground,
                ),
              ),
              wSpace(12),
              Expanded(
                child: SupervisorSummaryTimeWidget(
                  label: 'employee.home.checkOutLabel'.tr(context: context),
                  value: checkOut,
                  color: AppColors.info,
                  background: AppColors.softBlueBackground,
                ),
              ),
            ],
          ),
          hSpace(10),
          Text(
            '${'supervisor.dashboard.workHours'.tr(context: context)}: $workStart - $workEnd',
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
