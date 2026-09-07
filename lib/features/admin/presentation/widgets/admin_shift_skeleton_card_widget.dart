import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminShiftSkeletonCardWidget extends StatelessWidget {
  const AdminShiftSkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                Container(
                  width: 38.r,
                  height: 38.r,
                  decoration: const BoxDecoration(
                    color: AppColors.pageBackground,
                    shape: BoxShape.circle,
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 110.w,
                        height: 14.h,
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      hSpace(5),
                      Container(
                        width: 140.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 55.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                vSpace(8),
                Container(
                  width: 16.r,
                  height: 16.r,
                  decoration: const BoxDecoration(
                    color: AppColors.pageBackground,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 34.h,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 40.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
                Container(width: 1.w, color: AppColors.border),
                Expanded(
                  child: Center(
                    child: Container(
                      width: 40.w,
                      height: 12.h,
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
