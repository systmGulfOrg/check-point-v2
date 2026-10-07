import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorMoreOptionWidget extends StatelessWidget {
  const SupervisorMoreOptionWidget({
    required this.icon,
    required this.labelKey,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    super.key,
    this.subtitleKey,
    this.badge,
  });

  final IconData icon;
  final String labelKey;
  final String? subtitleKey;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Ink(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40.r,
                    height: 40.r,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(icon, color: iconColor, size: 22.r),
                  ),
                  if (badge != null)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        badge!,
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  else
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13.r,
                      color: AppColors.textSecondary.withValues(alpha: 0.4),
                    ),
                ],
              ),
              hSpace(8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    labelKey.tr(context: context),
                    style: AppTextStyles.font13Medium.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitleKey != null) ...[
                    hSpace(2),
                    Text(
                      subtitleKey!.tr(context: context),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 10.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
