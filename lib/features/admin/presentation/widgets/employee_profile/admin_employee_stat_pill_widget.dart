import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// Icon + label/value pill used in the employee attendance tab.
class AdminEmployeeStatPillWidget extends StatelessWidget {
  const AdminEmployeeStatPillWidget({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    super.key,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(12.r),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Row(
      children: [
        Icon(icon, size: 24.r, color: color),
        wSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.font11Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(2),
              Text(
                value,
                style: AppTextStyles.font18Bold.copyWith(color: color),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
