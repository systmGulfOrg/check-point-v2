import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminSettingsTileWidget extends StatelessWidget {
  const AdminSettingsTileWidget({
    required this.icon,
    required this.titleKey,
    required this.valueKey,
    super.key,
    this.onTap,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, color: AppColors.textSecondary, size: 20.r),
            vSpace(12),
            Expanded(
              child: Text(
                titleKey.tr(context: context),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            Text(
              valueKey.tr(context: context),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            vSpace(6),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.placeholder,
              size: 20.r,
            ),
          ],
        ),
      ),
    );
  }
}
