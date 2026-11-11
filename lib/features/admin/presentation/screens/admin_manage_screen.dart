import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_manage_card_widget.dart';

class AdminManageScreen extends StatelessWidget {
  const AdminManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = sl<AuthSessionStorage>();
    final hasCustomerVisits = storage.isFeatureEnabled('customer_visits');
    final hasRemoteWork = storage.isFeatureEnabled('remote_work');
    final hasOvertime = storage.isFeatureEnabled('overtime');
    final hasLeave = storage.isFeatureEnabled('leave');
    final hasPoints = storage.isFeatureEnabled('attendance_points');

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'admin.manage.title'.tr(context: context),
              style: AppTextStyles.font20Bold,
            ),
            hSpace(20),
            AdminManageCardWidget(
              icon: Icons.devices_other,
              iconColor: AppColors.info,
              iconBackgroundColor: AppColors.softBlueBackground,
              titleKey: 'admin.manage.devices',
              subtitleKey: 'admin.manage.devicesSub',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.adminPendingDevices),
            ),
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.corporate_fare_outlined,
              iconColor: AppColors.brandPrimary,
              iconBackgroundColor: AppColors.softBrandBackground,
              titleKey: 'admin.manage.departments',
              subtitleKey: 'admin.manage.departmentsSub',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.adminDepartments),
            ),
            if (hasCustomerVisits) ...[
              hSpace(10),
              AdminManageCardWidget(
                icon: Icons.home_work_outlined,
                iconColor: AppColors.info,
                iconBackgroundColor: AppColors.softBlueBackground,
                titleKey: 'admin.manage.locations',
                subtitleKey: 'admin.manage.locationsSub',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.adminLocations),
              ),
            ],
            if (hasRemoteWork) ...[
              hSpace(10),
              AdminManageCardWidget(
                icon: Icons.calendar_month_outlined,
                iconColor: AppColors.brandPrimary,
                iconBackgroundColor: AppColors.softBrandBackground,
                titleKey: 'admin.manage.remoteWork',
                subtitleKey: 'admin.manage.remoteWorkSub',
                onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
              ),
            ],
            if (hasOvertime) ...[
              hSpace(10),
              AdminManageCardWidget(
                icon: Icons.more_time_rounded,
                iconColor: AppColors.warningOrange,
                iconBackgroundColor: AppColors.softYellowBackground,
                titleKey: 'overtime.title',
                subtitleKey: 'overtime.requests',
                onTap: () => Navigator.pushNamed(context, AppRoutes.overtime),
              ),
            ],
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.gavel_rounded,
              iconColor: AppColors.error,
              iconBackgroundColor: AppColors.error.withValues(alpha: 0.1),
              titleKey: 'لائحة الجزاءات والمخالفات',
              subtitleKey: 'رصد مخالفات لائحة السلوك والخصومات',
              onTap: () => Navigator.pushNamed(
                context,
                AppRoutes.disciplinaryRecordViolation,
              ),
            ),
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.shield_outlined,
              iconColor: AppColors.info,
              iconBackgroundColor: AppColors.softBlueBackground,
              titleKey: 'admin.manage.permissions',
              subtitleKey: 'admin.manage.permissionsSub',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.adminPermissions),
            ),
            if (hasLeave) ...[
              hSpace(10),
              AdminManageCardWidget(
                icon: Icons.calendar_today_outlined,
                iconColor: AppColors.success,
                iconBackgroundColor: AppColors.softGreenBackground,
                titleKey: 'admin.manage.leaveManagement',
                subtitleKey: 'admin.manage.leaveManagementSub',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoutes.adminLeaveManagement),
              ),
            ],
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.bar_chart_rounded,
              iconColor: AppColors.brandPrimary,
              iconBackgroundColor: AppColors.softYellowBackground,
              titleKey: 'admin.manage.attendanceRecords',
              subtitleKey: 'admin.manage.attendanceRecordsSub',
              onTap: () =>
                  Navigator.pushNamed(context, AppRoutes.adminAttendance),
            ),
            if (hasPoints) ...[
              hSpace(10),
              AdminManageCardWidget(
                icon: Icons.workspace_premium_rounded,
                iconColor: AppColors.warningOrange,
                iconBackgroundColor: AppColors.softYellowBackground,
                titleKey: 'admin.manage.points',
                subtitleKey: 'admin.manage.pointsSub',
                onTap: () => Navigator.pushNamed(context, AppRoutes.adminPoints),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
