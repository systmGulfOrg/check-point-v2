import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorSummaryPillWidget extends StatelessWidget {
  const SupervisorSummaryPillWidget({
    required this.icon,
    required this.label,
    required this.color,
    required this.background,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(10.r),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.r, color: color),
        wSpace(5),
        Text(label, style: AppTextStyles.font11Medium.copyWith(color: color)),
      ],
    ),
  );
}
