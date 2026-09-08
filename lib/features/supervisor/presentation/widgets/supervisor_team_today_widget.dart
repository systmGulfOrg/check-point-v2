import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'supervisor_team_today_row_widget.dart';

class SupervisorTeamTodayWidget extends StatelessWidget {
  const SupervisorTeamTodayWidget({
    required this.attendance,
    super.key,
    this.onViewAll,
  });

  final List<AdminAttendanceModel> attendance;
  final VoidCallback? onViewAll;

  @override
  Widget build(BuildContext context) {
    final displayList = attendance.take(4).toList();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
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
                Text(
                  'supervisor.dashboard.teamToday'.tr(context: context),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                if (onViewAll != null)
                  InkWell(
                    onTap: onViewAll,
                    child: Text(
                      'supervisor.dashboard.viewAll'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (displayList.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Text(
                  'supervisor.attendance.empty'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            for (int i = 0; i < displayList.length; i++) ...[
              const Divider(color: AppColors.border, height: 1),
              SupervisorTeamTodayRowWidget(record: displayList[i]),
            ],
        ],
      ),
    );
  }
}
