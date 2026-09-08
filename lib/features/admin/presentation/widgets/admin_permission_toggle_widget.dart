import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPermissionToggleWidget extends StatelessWidget {
  const AdminPermissionToggleWidget({
    required this.permissionKey,
    required this.isEnabled,
    required this.onChanged,
    super.key,
  });

  final String permissionKey;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 11.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  permissionKey.tr(context: context),
                  style: AppTextStyles.font14SemiBold,
                ),
                hSpace(2),
                Text(
                  'admin.permissions.defaultForSupervisors'.tr(
                    context: context,
                  ),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeThumbColor: AppColors.brandPrimary,
          ),
        ],
      ),
    );
  }
}
