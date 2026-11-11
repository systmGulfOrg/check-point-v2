import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCustomerDetailsInfoRowWidget extends StatelessWidget {
  const AdminCustomerDetailsInfoRowWidget({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.r, color: AppColors.brandPrimary),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(value, style: AppTextStyles.font13Medium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
