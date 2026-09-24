import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeProfileInfoCardWidget extends StatelessWidget {
  const AdminEmployeeProfileInfoCardWidget({
    required this.title,
    required this.children,
    this.icon,
    this.trailing,
    super.key,
  });

  final String title;
  final IconData? icon;
  final Widget? trailing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18.r, color: AppColors.brandPrimary),
                wSpace(8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
          hSpace(12),
          const Divider(height: 1, color: AppColors.border),
          hSpace(10),
          ...children,
        ],
      ),
    );
  }
}
