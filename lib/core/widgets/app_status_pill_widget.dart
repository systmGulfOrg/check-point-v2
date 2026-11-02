import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

/// Small rounded label with an optional leading icon, used for statuses and
/// tags (work mode, request status, tier).
class AppStatusPillWidget extends StatelessWidget {
  const AppStatusPillWidget({
    required this.label,
    required this.color,
    required this.backgroundColor,
    this.icon,
    super.key,
  });

  final String label;
  final Color color;
  final Color backgroundColor;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14.r, color: color),
            wSpace(4),
          ],
          Text(label, style: AppTextStyles.font11Medium.copyWith(color: color)),
        ],
      ),
    );
  }
}
