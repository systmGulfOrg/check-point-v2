import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminEmployeeRoleBadgeWidget extends StatelessWidget {
  const AdminEmployeeRoleBadgeWidget({required this.role, super.key});

  final String role;

  Color get _backgroundColor {
    final lower = role.toLowerCase();
    if (lower.contains('admin')) return AppColors.softBrandBackground;
    if (lower.contains('supervisor')) return AppColors.softYellowBackground;
    return AppColors.softGreenBackground;
  }

  Color get _textColor {
    final lower = role.toLowerCase();
    if (lower.contains('admin')) return AppColors.brandPrimary;
    if (lower.contains('supervisor')) return AppColors.warningOrange;
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        role,
        style: AppTextStyles.font11Medium.copyWith(
          color: _textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
