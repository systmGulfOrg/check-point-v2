import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_employee_profile_info_card_widget.dart';
import 'admin_employee_profile_info_row_widget.dart';

class AdminEmployeeProfileSkeletonWidget extends StatelessWidget {
  const AdminEmployeeProfileSkeletonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        physics: const NeverScrollableScrollPhysics(),
        children: [
          // Header Card Skeleton
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 32.r,
                      backgroundColor: AppColors.brandPrimary.withValues(
                        alpha: 0.15,
                      ),
                      child: Text('AZ', style: AppTextStyles.font20Bold),
                    ),
                    wSpace(14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Employee Full Name Placeholder',
                            style: AppTextStyles.font16Bold,
                          ),
                          hSpace(4),
                          Text(
                            'Senior Job Position Title',
                            style: AppTextStyles.font13Medium,
                          ),
                          hSpace(6),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(
                                    alpha: 0.15,
                                  ),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'Active',
                                  style: AppTextStyles.font11Medium,
                                ),
                              ),
                              wSpace(6),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 2.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.pageBackground,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'EMP-0000',
                                  style: AppTextStyles.font11Medium,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hSpace(16),
                const Divider(height: 1, color: AppColors.border),
                hSpace(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone_outlined, size: 18),
                        wSpace(6),
                        Text('Call Phone', style: AppTextStyles.font13Medium),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.email_outlined, size: 18),
                        wSpace(6),
                        Text('Send Email', style: AppTextStyles.font13Medium),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSpace(14),
          // Tab bar placeholder
          Container(
            height: 44.h,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                4,
                (index) => Container(
                  width: 70.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
              ),
            ),
          ),
          hSpace(16),
          // Information Card Skeleton
          const AdminEmployeeProfileInfoCardWidget(
            title: 'Job Information Loading Section',
            icon: Icons.work_outline_rounded,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'Employee Code',
                value: 'EMP-0000000000',
                icon: Icons.tag_rounded,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'Job Title',
                value: 'Executive Position Role',
                icon: Icons.badge_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'Job Grade',
                value: 'Grade 4 Senior Specialist',
                icon: Icons.military_tech_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'Department',
                value: 'Operations and Logistics',
                icon: Icons.business_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'Branch Location',
                value: 'Headquarters Main Branch',
                icon: Icons.location_on_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
