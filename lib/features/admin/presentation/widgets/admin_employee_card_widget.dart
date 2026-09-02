import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminEmployeeCardWidget extends StatelessWidget {
  const AdminEmployeeCardWidget({
    required this.initials,
    required this.name,
    required this.roleKey,
    required this.email,
    required this.empCode,
    super.key,
    this.department,
    this.isOnline = true,
  });

  final String initials;
  final String name;
  final String roleKey;
  final String email;
  final String empCode;
  final String? department;
  final bool isOnline;

  Color _getRoleBackgroundColor() {
    if (roleKey.contains('Admin') || roleKey.contains('admin')) {
      return AppColors.softBrandBackground;
    }
    if (roleKey.contains('Supervisor') || roleKey.contains('supervisor')) {
      return AppColors.softYellowBackground;
    }
    return AppColors.softGreenBackground;
  }

  Color _getRoleTextColor() {
    if (roleKey.contains('Admin') || roleKey.contains('admin')) {
      return AppColors.brandPrimary;
    }
    if (roleKey.contains('Supervisor') || roleKey.contains('supervisor')) {
      return AppColors.warningOrange;
    }
    return AppColors.success;
  }

  @override
  Widget build(BuildContext context) {
    final subText = department != null && department!.isNotEmpty
        ? '$empCode  •  $department'
        : empCode;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.softBrandBackground,
            child: Text(
              initials,
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ),
          vSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        name,
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    vSpace(8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getRoleBackgroundColor(),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        roleKey.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: _getRoleTextColor(),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(2),
                Text(
                  email,
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(4),
                Text(
                  subText,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          if (isOnline)
            Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Container(
                width: 8.r,
                height: 8.r,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
