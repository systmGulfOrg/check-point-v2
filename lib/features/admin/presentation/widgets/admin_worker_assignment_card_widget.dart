import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';

class AdminWorkerAssignmentCardWidget extends StatelessWidget {
  const AdminWorkerAssignmentCardWidget({
    required this.assignment,
    super.key,
  });

  final WorkerSiteAssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.workerName,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      assignment.contractorName ?? '',
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'admin.assignments.active'.tr(),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          hSpace(12),
          const Divider(height: 1, color: AppColors.border),
          hSpace(12),
          Row(
            children: [
              Icon(
                Icons.location_city_rounded,
                size: 16.r,
                color: AppColors.brandPrimary,
              ),
              vSpace(6),
              Text(
                '${'admin.assignments.site'.tr()}: ${assignment.siteName}',
                style: AppTextStyles.font13Medium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          hSpace(6),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16.r,
                color: AppColors.textSecondary,
              ),
              vSpace(6),
              Text(
                '${'admin.assignments.validFrom'.tr()}: ${assignment.validFrom ?? '-'}  →  ${'admin.assignments.validUntil'.tr()}: ${assignment.validUntil ?? '-'}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
