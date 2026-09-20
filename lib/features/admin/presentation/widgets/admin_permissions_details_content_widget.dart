import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/permissions/admin_permission_employee_model.dart';
import '../../data/models/permissions/admin_permissions_catalogue_model.dart';
import '../cubit/permissions/admin_permissions_cubit.dart';
import 'admin_permission_badge_widget.dart';
import 'admin_permissions_permission_row_widget.dart';

class AdminPermissionsDetailsContentWidget extends StatelessWidget {
  const AdminPermissionsDetailsContentWidget({
    required this.user,
    required this.catalogue,
    required this.selectedPermissions,
    required this.saving,
    super.key,
  });

  final AdminPermissionEmployeeModel user;
  final AdminPermissionsCatalogueModel catalogue;
  final List<String> selectedPermissions;
  final bool saving;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AdminPermissionsCubit>();
    final grouped = cubit.groupedPermissions(catalogue);
    final isAdmin = cubit.isAdmin(user);
    final role =
        user.user.role ?? 'admin.permissions.employee'.tr(context: context);
    final contact =
        user.email ??
        user.employeeCode ??
        'admin.permissions.notAvailable'.tr(context: context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 21.r,
              backgroundColor: AppColors.softBlueBackground,
              child: Text(
                user.initials,
                style: AppTextStyles.font12Bold.copyWith(color: AppColors.info),
              ),
            ),
            vSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name, style: AppTextStyles.font16Bold),
                  Text(
                    '$role • $contact',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        hSpace(18),
        if (isAdmin)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.softBrandBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.brandPrimary.withValues(alpha: 0.25),
              ),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.verified_user_outlined,
                  color: AppColors.brandPrimary,
                  size: 42.r,
                ),
                hSpace(10),
                Text(
                  'admin.permissions.adminAccess'.tr(context: context),
                  style: AppTextStyles.font16Bold,
                ),
                hSpace(4),
                Text(
                  'admin.permissions.adminDescription'.tr(context: context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          )
        else
          ...grouped.entries.map(
            (entry) => Padding(
              padding: EdgeInsets.only(bottom: 14.h),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(entry.key, style: AppTextStyles.font14Bold),
                        AdminPermissionBadgeWidget(
                          label: '${entry.value.length}',
                          color: AppColors.info,
                          background: AppColors.softBlueBackground,
                        ),
                      ],
                    ),
                    hSpace(8),
                    ...entry.value.map(
                      (permission) => AdminPermissionsPermissionRowWidget(
                        permission: permission,
                        enabled:
                            selectedPermissions.contains(permission) ||
                            cubit.isBasePermission(permission),
                        baseRole: cubit.isBasePermission(permission),
                        onChanged: () => cubit.togglePermission(permission),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        if (!isAdmin)
          CustomButton(
            text: 'admin.permissions.save'.tr(context: context),
            onTap: () async {
              final saved = await cubit.saveSelected();
              if (saved && context.mounted) Navigator.pop(context);
            },
            isLoading: saving,
          ),
      ],
    );
  }
}
