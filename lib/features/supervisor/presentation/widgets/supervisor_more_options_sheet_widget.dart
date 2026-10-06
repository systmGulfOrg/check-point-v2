import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'supervisor_more_option_widget.dart';

class SupervisorMoreOptionsSheetWidget extends StatelessWidget {
  const SupervisorMoreOptionsSheetWidget({
    required this.onLeavesTap,
    required this.onPlansTap,
    required this.onNotificationsTap,
    required this.onCorrectionsTap,
    required this.onProfileTap,
    required this.onRemoteWorkTap,
    required this.onMyAttendanceTap,
    super.key,
  });

  final VoidCallback onLeavesTap;
  final VoidCallback onPlansTap;
  final VoidCallback onNotificationsTap;
  final VoidCallback onCorrectionsTap;
  final VoidCallback onProfileTap;
  final VoidCallback onRemoteWorkTap;
  final VoidCallback onMyAttendanceTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'supervisor.more.title'.tr(context: context),
                  style: AppTextStyles.font18Bold,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            hSpace(16),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              mainAxisSpacing: 12.h,
              crossAxisSpacing: 12.w,
              childAspectRatio: 1.2,
              children: [
                SupervisorMoreOptionWidget(
                  icon: Icons.fingerprint_rounded,
                  labelKey: 'supervisor.nav.myAttendance',
                  backgroundColor: AppColors.softBrandBackground,
                  iconColor: AppColors.brandPrimary,
                  onTap: () {
                    Navigator.pop(context);
                    onMyAttendanceTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.calendar_month_outlined,
                  labelKey: 'supervisor.more.leaves',
                  backgroundColor: AppColors.softGreenBackground,
                  iconColor: AppColors.success,
                  onTap: () {
                    Navigator.pop(context);
                    onLeavesTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.fact_check_outlined,
                  labelKey: 'supervisor.more.corrections',
                  backgroundColor: AppColors.softYellowBackground,
                  iconColor: AppColors.warning,
                  onTap: () {
                    Navigator.pop(context);
                    onCorrectionsTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.map_outlined,
                  labelKey: 'supervisor.more.plans',
                  backgroundColor: AppColors.softBlueBackground,
                  iconColor: AppColors.info,
                  onTap: () {
                    Navigator.pop(context);
                    onPlansTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.notifications_none_rounded,
                  labelKey: 'supervisor.more.notifications',
                  backgroundColor: AppColors.softBrandBackground,
                  iconColor: AppColors.brandPrimary,
                  onTap: () {
                    Navigator.pop(context);
                    onNotificationsTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.home_work_outlined,
                  labelKey: 'remoteWork.title',
                  backgroundColor: AppColors.softBlueBackground,
                  iconColor: AppColors.info,
                  onTap: () {
                    Navigator.pop(context);
                    onRemoteWorkTap();
                  },
                ),
                SupervisorMoreOptionWidget(
                  icon: Icons.person_outline_rounded,
                  labelKey: 'supervisor.more.profile',
                  backgroundColor: AppColors.pageBackground,
                  iconColor: AppColors.textSecondary,
                  onTap: () {
                    Navigator.pop(context);
                    onProfileTap();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
