import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_permission_badge_widget.dart';

class AdminPermissionsPermissionRowWidget extends StatelessWidget {
  const AdminPermissionsPermissionRowWidget({
    required this.permission,
    required this.enabled,
    required this.baseRole,
    required this.onChanged,
    super.key,
  });

  final String permission;
  final bool enabled;
  final bool baseRole;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    final label = permission.split('.').last.replaceAll('_', ' ');
    return InkWell(
      onTap: baseRole ? null : onChanged,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          children: [
            Checkbox(
              value: enabled,
              onChanged: baseRole ? null : (_) => onChanged(),
              activeColor: AppColors.brandPrimary,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.font13SemiBold),
                  Text(permission, style: AppTextStyles.font11Regular.copyWith(color: AppColors.placeholder)),
                ],
              ),
            ),
            if (baseRole)
              AdminPermissionBadgeWidget(
                label: 'admin.permissions.base'.tr(context: context),
                color: AppColors.info,
                background: AppColors.softBlueBackground,
              ),
          ],
        ),
      ),
    );
  }
}
