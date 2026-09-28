import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class SupervisorViolationTileWidget extends StatelessWidget {
  const SupervisorViolationTileWidget({
    super.key,
    required this.name,
    required this.trade,
    required this.contractor,
    required this.distance,
  });

  final String name;
  final String trade;
  final String contractor;
  final String distance;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.error.withValues(alpha: 0.4)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.location_off_rounded, color: AppColors.error, size: 20.r),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.font14Bold),
                SizedBox(height: 2.h),
                Text(
                  '$trade • $contractor',
                  style: AppTextStyles.font12Regular.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: AppTextStyles.font11Medium.copyWith(
              color: AppColors.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
