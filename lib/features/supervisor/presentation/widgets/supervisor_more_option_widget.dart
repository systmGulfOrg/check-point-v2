import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// One row of the "More" menu: icon, title, one-line hint and a chevron.
class SupervisorMoreOptionWidget extends StatelessWidget {
  const SupervisorMoreOptionWidget({
    required this.icon,
    required this.labelKey,
    required this.onTap,
    this.subtitleKey,
    super.key,
  });

  final IconData icon;
  final String labelKey;
  final String? subtitleKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, size: 20.r, color: AppColors.brandPrimary),
            ),
            wSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    labelKey.tr(context: context),
                    style: AppTextStyles.font14Bold,
                  ),
                  if (subtitleKey != null)
                    Text(
                      subtitleKey!.tr(context: context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
