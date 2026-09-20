import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorSummaryTimeWidget extends StatelessWidget {
  const SupervisorSummaryTimeWidget({
    required this.label,
    required this.value,
    required this.color,
    required this.background,
    super.key,
  });

  final String label;
  final String value;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.2),
    ),
    child: Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyles.font12Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        hSpace(3),
        Text(value, style: AppTextStyles.font16Bold.copyWith(color: color)),
      ],
    ),
  );
}
