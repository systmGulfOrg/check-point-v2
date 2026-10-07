import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminLeaveRequestActionWidget extends StatelessWidget {
  const AdminLeaveRequestActionWidget({
    required this.icon,
    required this.labelKey,
    required this.color,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String labelKey;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
      child: Material(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10.r),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: color.withValues(alpha: 0.25)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 16.r),
                SizedBox(width: 6.w),
                Text(
                  labelKey.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
