import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';

class AdminSiteWorkerCardWidget extends StatelessWidget {
  const AdminSiteWorkerCardWidget({
    required this.worker,
    this.onTap,
    super.key,
  });

  final ContractorWorkerModel worker;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = worker.status.toLowerCase() == 'active';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20.r,
              backgroundColor: AppColors.softBlueBackground,
              child: Text(
                worker.fullName.isNotEmpty
                    ? worker.fullName.characters.first.toUpperCase()
                    : 'W',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          worker.fullName,
                          style: AppTextStyles.font14SemiBold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: isActive
                              ? AppColors.softGreenBackground
                              : AppColors.softRedBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          worker.status.tr(context: context),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: isActive
                                ? AppColors.success
                                : AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                  hSpace(4),
                  Row(
                    children: [
                      Icon(
                        Icons.badge_outlined,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      vSpace(4),
                      Text(
                        worker.workerCode,
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      if (worker.jobTitle.isNotEmpty) ...[
                        Text(
                          ' • ',
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            worker.jobTitle,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (worker.contractorName != null &&
                      worker.contractorName!.isNotEmpty) ...[
                    hSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.business_outlined,
                          size: 14.r,
                          color: AppColors.textSecondary,
                        ),
                        vSpace(4),
                        Expanded(
                          child: Text(
                            worker.contractorName!,
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.placeholder,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
