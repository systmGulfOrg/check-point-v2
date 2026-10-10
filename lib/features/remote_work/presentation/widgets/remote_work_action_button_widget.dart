import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class RemoteWorkActionButtonWidget extends StatelessWidget {
  const RemoteWorkActionButtonWidget({
    required this.label,
    required this.icon,
    required this.onTap,
    super.key,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8.r),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.r, color: AppColors.brandPrimary),
          SizedBox(width: 3.w),
          Text(
            label,
            style: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}
