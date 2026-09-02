import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_attendance_filter_widget.dart';
import '../widgets/supervisor_attendance_list_widget.dart';
import '../widgets/supervisor_leave_requests_list_widget.dart';

class SupervisorAttendanceScreen extends StatefulWidget {
  const SupervisorAttendanceScreen({super.key});

  @override
  State<SupervisorAttendanceScreen> createState() =>
      _SupervisorAttendanceScreenState();
}

class _SupervisorAttendanceScreenState
    extends State<SupervisorAttendanceScreen> {
  int selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'supervisor.nav.attendance'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Image.asset(AppAssets.logo, height: 32.h, fit: BoxFit.contain),
              ],
            ),
            hSpace(20),
            SupervisorAttendanceFilterWidget(
              selectedIndex: selectedTab,
              onTabSelected: (index) => setState(() => selectedTab = index),
            ),
            if (selectedTab == 0) ...[
              hSpace(16),
              Text(
                'supervisor.attendance.today'.tr(
                  context: context,
                  args: [DateFormat('yyyy-MM-dd').format(DateTime.now())],
                ),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(12),
              const SupervisorAttendanceListWidget(),
            ] else ...[
              hSpace(16),
              const SupervisorLeaveRequestsListWidget(),
            ],
          ],
        ),
      ),
    );
  }
}
