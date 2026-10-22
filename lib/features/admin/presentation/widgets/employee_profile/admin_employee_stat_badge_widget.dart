import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeStatBadgeWidget extends StatelessWidget {
  const AdminEmployeeStatBadgeWidget({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(10.r),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: AppTextStyles.font11Medium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        hSpace(4),
        Text(value, style: AppTextStyles.font14Bold.copyWith(color: color)),
      ],
    ),
  );
}
