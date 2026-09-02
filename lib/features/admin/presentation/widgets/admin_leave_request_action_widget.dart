import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminLeaveRequestActionWidget extends StatelessWidget {
  const AdminLeaveRequestActionWidget({
    required this.icon,
    required this.labelKey,
    required this.color,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String labelKey;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 11.h),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 16.r),
            vSpace(5),
            Text(
              labelKey.tr(context: context),
              style: AppTextStyles.font12Medium.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
