import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminPlanSkeletonCardWidget extends StatelessWidget {
  const AdminPlanSkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 140.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          hSpace(8),
          Container(
            width: double.infinity,
            height: 13.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          hSpace(6),
          Container(
            width: 180.w,
            height: 13.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          hSpace(10),
          Container(
            width: 160.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
