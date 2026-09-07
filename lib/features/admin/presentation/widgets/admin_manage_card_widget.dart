import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminManageCardWidget extends StatelessWidget {
  const AdminManageCardWidget({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.titleKey,
    required this.subtitleKey,
    super.key,
    this.count,
    this.onTap,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String titleKey;
  final String subtitleKey;
  final int? count;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Padding(
          padding: EdgeInsets.all(14.r),
          child: Row(
            children: [
              Container(
                width: 42.r,
                height: 42.r,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(icon, color: iconColor, size: 22.r),
              ),
              vSpace(14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titleKey.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      subtitleKey.tr(context: context),
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (count != null) ...[
                Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Center(
                    child: Text(
                      '$count',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                vSpace(8),
              ],
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.placeholder,
                size: 20.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
