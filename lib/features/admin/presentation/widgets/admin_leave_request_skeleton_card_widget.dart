import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminLeaveRequestSkeletonCardWidget extends StatelessWidget {
  const AdminLeaveRequestSkeletonCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
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
                      Row(
                        children: [
                          Container(
                            width: 80.w,
                            height: 13.h,
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: 65.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                        ],
                      ),
                      hSpace(6),
                      Container(
                        width: 150.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                      hSpace(4),
                      Container(
                        width: 120.w,
                        height: 12.h,
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 38.h,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Container(
                      width: 50.w,
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
                      width: 50.w,
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
