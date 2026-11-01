import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// A small card with a label over one number.
class EmployeeHomeStatCardWidget extends StatelessWidget {
  const EmployeeHomeStatCardWidget({
    required this.label,
    required this.value,
    this.trailing,
    this.onTap,
    super.key,
  });

  final String label;
  final String value;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cardBackground,
      borderRadius: BorderRadius.circular(16.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(14.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(4),
              Row(
                children: [
                  Text(value, style: AppTextStyles.font20Bold),
                  if (trailing != null) ...[wSpace(6), trailing!],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
