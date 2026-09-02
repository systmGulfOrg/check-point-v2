import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorTeamMemberCardWidget extends StatelessWidget {
  const SupervisorTeamMemberCardWidget({
    required this.initials,
    required this.name,
    required this.roleKey,
    required this.email,
    required this.employeeCode,
    required this.departmentKey,
    super.key,
    this.isOnline = true,
  });

  final String initials;
  final String name;
  final String roleKey;
  final String email;
  final String employeeCode;
  final String departmentKey;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    vSpace(8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        roleKey.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.brandPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(4),
                Text(
                  email,
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(2),
                Text(
                  '$employeeCode  ·  ${departmentKey.tr(context: context)}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          if (isOnline)
            Container(
              width: 8.r,
              height: 8.r,
              decoration: const BoxDecoration(
                color: AppColors.success,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
