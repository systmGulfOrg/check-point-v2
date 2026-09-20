import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPermissionBadgeWidget extends StatelessWidget {
  const AdminPermissionBadgeWidget({
    required this.label,
    required this.color,
    required this.background,
    super.key,
  });

  final String label;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: Text(
        label,
        style: AppTextStyles.font11Medium.copyWith(color: color),
      ),
    );
  }
}
