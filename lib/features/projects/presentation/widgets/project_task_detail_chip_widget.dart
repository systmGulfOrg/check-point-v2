import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ProjectTaskDetailChipWidget extends StatelessWidget {
  const ProjectTaskDetailChipWidget({
    required this.icon,
    required this.label,
    required this.bg,
    required this.textColor,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color bg;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: textColor),
          SizedBox(width: 5.w),
          Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
