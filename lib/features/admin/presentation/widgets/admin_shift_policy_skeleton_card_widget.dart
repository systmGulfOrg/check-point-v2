import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminShiftPolicySkeletonCardWidget extends StatelessWidget {
  const AdminShiftPolicySkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 130.w,
                height: 15.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              Container(
                width: 45.w,
                height: 13.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          hSpace(8),
          Row(
            children: [
              Container(
                width: 14.r,
                height: 14.r,
                decoration: const BoxDecoration(
                  color: AppColors.pageBackground,
                  shape: BoxShape.circle,
                ),
              ),
              wSpace(6),
              Container(
                width: 100.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              wSpace(12),
              Container(
                width: 14.r,
                height: 14.r,
                decoration: const BoxDecoration(
                  color: AppColors.pageBackground,
                  shape: BoxShape.circle,
                ),
              ),
              wSpace(4),
              Container(
                width: 70.w,
                height: 12.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
          hSpace(8),
          Container(
            width: 180.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          hSpace(10),
          Container(
            width: 120.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          hSpace(8),
          Row(
            children: [
              Container(
                width: 70.w,
                height: 26.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              wSpace(6),
              Container(
                width: 80.w,
                height: 26.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
