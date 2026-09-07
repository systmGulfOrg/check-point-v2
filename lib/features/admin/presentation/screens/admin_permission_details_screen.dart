import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_employees_cubit.dart';
import '../widgets/admin_permission_toggle_widget.dart';

class AdminPermissionDetailsScreen extends StatefulWidget {
  const AdminPermissionDetailsScreen({required this.supervisorKey, super.key});

  final String supervisorKey;

  @override
  State<AdminPermissionDetailsScreen> createState() =>
      _AdminPermissionDetailsScreenState();
}

class _AdminPermissionDetailsScreenState
    extends State<AdminPermissionDetailsScreen> {
  final enabledPermissions = <String>{};

  static const _defaultPermissions = <String>[
    'admin.permissions.items.viewTeam',
    'admin.permissions.items.viewAttendance',
    'admin.permissions.items.approveLeave',
    'admin.permissions.items.rejectLeave',
    'admin.permissions.items.createTasks',
    'admin.permissions.items.assignTasks',
    'admin.permissions.items.createPlans',
  ];

  static const _extendedPermissions = <String>[
    'admin.permissions.items.viewAnalytics',
    'admin.permissions.items.clockInOut',
    'admin.permissions.items.createCustomers',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.permissions.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 17.r,
                  backgroundColor: AppColors.softBlueBackground,
                  child: Text(
                    (widget.supervisorKey.isNotEmpty)
                        ? widget.supervisorKey[0].toUpperCase()
                        : 'S',
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.info,
                    ),
                  ),
                ),
                vSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.supervisorKey.tr(context: context),
                      style: AppTextStyles.font14SemiBold,
                    ),
                    Text(
                      'supervisor.profile.employeeId'.tr(context: context),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.placeholder,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            hSpace(18),
            Text(
              'admin.permissions.defaultTitle'.tr(context: context),
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            hSpace(8),
            for (final permission in _defaultPermissions)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: AdminPermissionToggleWidget(
                  permissionKey: permission,
                  isEnabled: enabledPermissions.contains(permission),
                  onChanged: (value) {
                    setState(
                      () => value
                          ? enabledPermissions.add(permission)
                          : enabledPermissions.remove(permission),
                    );
                    context.read<AdminEmployeesCubit>().setAttendancePermission(
                      widget.supervisorKey,
                      value,
                    );
                  },
                ),
              ),
            hSpace(8),
            Text(
              'admin.permissions.extendedTitle'.tr(context: context),
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 0.5,
              ),
            ),
            hSpace(8),
            for (final permission in _extendedPermissions)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: AdminPermissionToggleWidget(
                  permissionKey: permission,
                  isEnabled: enabledPermissions.contains(permission),
                  onChanged: (value) {
                    setState(
                      () => value
                          ? enabledPermissions.add(permission)
                          : enabledPermissions.remove(permission),
                    );
                    context.read<AdminEmployeesCubit>().setPlanPermission(
                      widget.supervisorKey,
                      value,
                    );
                  },
                ),
              ),
            hSpace(8),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.infoBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Text(
                'admin.permissions.apiNotice'.tr(context: context),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.brandInk,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
