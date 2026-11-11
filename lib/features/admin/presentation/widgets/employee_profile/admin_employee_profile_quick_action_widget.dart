import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeProfileQuickActionWidget extends StatelessWidget {
  const AdminEmployeeProfileQuickActionWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isEnabled,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final bool isEnabled;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.r),
      child: Opacity(
        opacity: isEnabled ? 1.0 : 0.45,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16.r, color: color),
              wSpace(6),
              Text(
                label,
                style: AppTextStyles.font12Medium.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
