import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeCardWidget extends StatelessWidget {
  const AdminEmployeeCardWidget({
    required this.initials,
    required this.name,
    required this.email,
    required this.empCode,
    super.key,
    this.imageUrl,
    this.roles = const [],
    this.roleKey,
    this.department,
    this.isOnline = true,
    this.onEdit,
    this.onDelete,
    this.onTap,
  });

  final String? imageUrl;
  final String initials;
  final String name;
  final List<String> roles;
  final String? roleKey;
  final String email;
  final String empCode;
  final String? department;
  final bool isOnline;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  static Color _getRoleBackgroundColor(String role) {
    final lower = role.toLowerCase();
    if (lower.contains('admin')) {
      return AppColors.softBrandBackground;
    }
    if (lower.contains('supervisor')) {
      return AppColors.softYellowBackground;
    }
    if (lower.contains('hr')) {
      return AppColors.softPurpleBackground;
    }
    return AppColors.softGreenBackground;
  }

  static Color _getRoleTextColor(String role) {
    final lower = role.toLowerCase();
    if (lower.contains('admin')) {
      return AppColors.brandPrimary;
    }
    if (lower.contains('supervisor')) {
      return AppColors.warningOrange;
    }
    if (lower.contains('hr')) {
      return AppColors.purpleText;
    }
    return AppColors.success;
  }

  static String _getRoleLabel(String role) {
    return switch (role.toLowerCase()) {
      'admin' => 'admin.roles.admin',
      'supervisor' => 'admin.roles.supervisor',
      _ => 'admin.roles.employee',
    };
  }

  @override
  Widget build(BuildContext context) {
    final subText = department != null && department!.isNotEmpty
        ? '$empCode  •  $department'
        : empCode;

    final displayRoles = roles.isNotEmpty
        ? roles
        : (roleKey != null && roleKey!.isNotEmpty
              ? [roleKey!]
              : const ['Employee']);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
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
          children: [
            Padding(
              padding: EdgeInsets.all(14.r),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppAvatarWidget(
                    imageUrl: imageUrl,
                    name: name,
                    initials: initials,
                    subtitle: empCode,
                    radius: 22.r,
                    enablePreview: true,
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: AppTextStyles.font16Bold.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        hSpace(4),
                        Wrap(
                          spacing: 4.w,
                          runSpacing: 4.h,
                          children: displayRoles.map((role) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: _getRoleBackgroundColor(role),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                _getRoleLabel(role).tr(context: context),
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: _getRoleTextColor(role),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        hSpace(4),
                        Text(
                          email,
                          style: AppTextStyles.font13Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        hSpace(4),
                        Text(
                          subText,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isOnline)
                    Padding(
                      padding: EdgeInsets.only(top: 4.h),
                      child: Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: const BoxDecoration(
                          color: AppColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            if (onEdit != null || onDelete != null)
              Row(
                children: [
                  if (onEdit != null)
                    Expanded(
                      child: InkWell(
                        onTap: onEdit,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.border),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'admin.locations.edit'.tr(context: context),
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (onDelete != null)
                    Expanded(
                      child: InkWell(
                        onTap: onDelete,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          decoration: const BoxDecoration(
                            border: Border(
                              top: BorderSide(color: AppColors.border),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'admin.locations.delete'.tr(context: context),
                            style: AppTextStyles.font13SemiBold.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
