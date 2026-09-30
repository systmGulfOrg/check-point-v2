import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_manage_card_widget.dart';

class AdminManageScreen extends StatelessWidget {
  const AdminManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.calendar_month_outlined,
              iconColor: AppColors.brandPrimary,
              iconBackgroundColor: AppColors.softBrandBackground,
              titleKey: 'admin.manage.remoteWork',
              subtitleKey: 'admin.manage.remoteWorkSub',
              onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
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
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.assignment_outlined,
              iconColor: AppColors.warningOrange,
              iconBackgroundColor: AppColors.softYellowBackground,
              titleKey: 'admin.manage.tasks',
              subtitleKey: 'admin.manage.tasksSub',
              onTap: () => Navigator.pushNamed(context, AppRoutes.adminTasks),
            ),
            hSpace(10),
            AdminManageCardWidget(
              icon: Icons.map_outlined,
              iconColor: AppColors.error,
              iconBackgroundColor: AppColors.softBrandBackground,
              titleKey: 'admin.manage.plansMissions',
              subtitleKey: 'admin.manage.plansMissionsSub',
              onTap: () => Navigator.pushNamed(context, AppRoutes.adminPlans),
            ),
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
          ],
        ),
      ),
    );
  }
}
