import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class EmployeeSettingsTileWidget extends StatelessWidget {
  const EmployeeSettingsTileWidget({
    required this.icon,
    required this.titleKey,
    required this.valueKey,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String titleKey;
  final String valueKey;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.r,
              color: AppColors.textSecondary,
            ),
            wSpace(12),
            Expanded(
              child: Text(
                titleKey.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              valueKey.startsWith('admin.') || valueKey.startsWith('employee.')
                  ? valueKey.tr(context: context)
                  : valueKey,
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            wSpace(6),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.r,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
