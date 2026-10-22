import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminOverviewRowWidget extends StatelessWidget {
  const AdminOverviewRowWidget({
    required this.titleKey,
    required this.value,
    required this.valueColor,
    this.onTap,
    super.key,
  });

  final String titleKey;
  final String value;
  final Color valueColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: valueColor,
                  ),
                ),
                if (onTap != null) ...[
                  wSpace(4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12.r,
                    color: AppColors.textSecondary,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
