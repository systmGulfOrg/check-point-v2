import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/permissions/admin_permission_employee_model.dart';
import 'admin_permission_badge_widget.dart';

class AdminPermissionsUserCardWidget extends StatelessWidget {
  const AdminPermissionsUserCardWidget({
    required this.user,
    required this.onManage,
    super.key,
  });

  final AdminPermissionEmployeeModel user;
  final VoidCallback onManage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AppAvatarWidget(
                imageUrl: user.imageUrl,
                name: user.name,
                initials: user.initials,
                subtitle: user.email ?? user.employeeCode,
                radius: 20.r,
                backgroundColor: AppColors.softBlueBackground,
                textColor: AppColors.info,
                enablePreview: true,
              ),
              vSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: AppTextStyles.font14SemiBold),
                    hSpace(2),
                    Text(
                      user.email ??
                          user.employeeCode ??
                          'admin.permissions.notAvailable'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.placeholder,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: AppColors.placeholder),
            ],
          ),
          hSpace(12),
          Wrap(
            spacing: 8.w,
            runSpacing: 6.h,
            children: [
              AdminPermissionBadgeWidget(
                label: user.user.role ?? 'Employee',
                color: AppColors.info,
                background: AppColors.softBlueBackground,
              ),
              AdminPermissionBadgeWidget(
                label: user.user.isActive
                    ? 'admin.permissions.active'.tr(context: context)
                    : 'admin.permissions.disabled'.tr(context: context),
                color: user.user.isActive ? AppColors.success : AppColors.error,
                background: user.user.isActive
                    ? AppColors.softGreenBackground
                    : AppColors.softRedBackground,
              ),
            ],
          ),
          vSpace(10),
          Row(
            children: [
              Expanded(
                child: Text(
                  user.user.lastLoginAt == null
                      ? 'admin.permissions.never'.tr(context: context)
                      : '${'admin.permissions.lastLogin'.tr(context: context)}: ${DateFormat.yMd(context.locale.toString()).format(user.user.lastLoginAt!)}',
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
              TextButton(
                onPressed: onManage,
                child: Text('admin.permissions.manage'.tr(context: context)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
