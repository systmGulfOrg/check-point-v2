import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPolicyTimeCardWidget extends StatelessWidget {
  const AdminPolicyTimeCardWidget({
    required this.labelKey,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  final String labelKey;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16.r, color: color),
          wSpace(6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  labelKey.tr(context: context),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(2),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font13SemiBold.copyWith(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
