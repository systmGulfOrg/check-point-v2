import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminAttendanceSkeletonCardWidget extends StatelessWidget {
  const AdminAttendanceSkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: const BoxDecoration(
                  color: AppColors.pageBackground,
                  shape: BoxShape.circle,
                ),
              ),
              wSpace(10),
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
                      width: 65.w,
                      height: 10.h,
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ],
                ),
              ),
              wSpace(8),
              Container(
                width: 60.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
              wSpace(6),
              Container(
                width: 32.w,
                height: 22.h,
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ),
            ],
          ),
          hSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          hSpace(5),
                          Container(
                            width: 80.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 26.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      color: AppColors.border,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 60.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          hSpace(5),
                          Container(
                            width: 45.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                Container(height: 1.h, color: AppColors.border),
                hSpace(8),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          hSpace(5),
                          Container(
                            width: 70.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 26.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      color: AppColors.border,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 50.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          hSpace(5),
                          Container(
                            width: 70.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: AppColors.border,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
