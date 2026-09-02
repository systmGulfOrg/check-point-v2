import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorMoreOptionWidget extends StatelessWidget {
  const SupervisorMoreOptionWidget({
    required this.icon,
    required this.labelKey,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    super.key,
    this.badge,
  });

  final IconData icon;
  final String labelKey;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final String? badge;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 17.r,
                    backgroundColor: backgroundColor,
                    child: Icon(icon, color: iconColor, size: 19.r),
                  ),
                  hSpace(7),
                  Text(
                    labelKey.tr(context: context),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (badge != null)
              PositionedDirectional(
                top: 7.h,
                end: 7.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: AppColors.error,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge!,
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.white,
                      fontSize: 8.sp,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
