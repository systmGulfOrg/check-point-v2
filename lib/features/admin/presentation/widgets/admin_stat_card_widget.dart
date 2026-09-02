import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminStatCardWidget extends StatelessWidget {
  const AdminStatCardWidget({
    required this.icon,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.value,
    required this.labelKey,
    super.key,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackgroundColor;
  final String value;
  final String labelKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: iconBackgroundColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: iconColor, size: 20.r),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                value,
                style: AppTextStyles.font24Bold.copyWith(
                  color: AppColors.textPrimary,
                  height: 1.1,
                ),
              ),
              hSpace(2),
              Text(
                labelKey.tr(context: context),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
