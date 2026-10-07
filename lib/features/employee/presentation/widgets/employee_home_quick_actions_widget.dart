import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeHomeQuickActionsWidget extends StatelessWidget {
  const EmployeeHomeQuickActionsWidget({
    required this.onRequestLeave,
    required this.onRequestPermission,
    super.key,
  });

  final VoidCallback onRequestLeave;
  final VoidCallback onRequestPermission;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'employee.home.quickActions'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(12),
        Row(
          children: [
            Expanded(
              child: _QuickActionButton(
                icon: Icons.beach_access_rounded,
                title: 'employee.home.requestLeave'.tr(context: context),
                iconColor: AppColors.brandPrimary,
                backgroundColor: AppColors.softBrandBackground,
                borderColor: AppColors.brandPrimary.withValues(alpha: 0.2),
                onTap: onRequestLeave,
              ),
            ),
            wSpace(12),
            Expanded(
              child: _QuickActionButton(
                icon: Icons.timer_outlined,
                title: 'employee.home.requestPermission'.tr(context: context),
                iconColor: AppColors.info,
                backgroundColor: AppColors.softBlueBackground,
                borderColor: AppColors.info.withValues(alpha: 0.2),
                onTap: onRequestPermission,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final Color iconColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withValues(alpha: 0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: iconColor, size: 20.r),
              ),
              wSpace(10),
              Flexible(
                child: Text(
                  title,
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
