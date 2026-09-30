import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';

class AdminSiteContractorCardWidget extends StatelessWidget {
  const AdminSiteContractorCardWidget({
    required this.contractor,
    required this.assignedWorkersCount,
    this.onTap,
    super.key,
  });

  final ContractorCompanyModel contractor;
  final int assignedWorkersCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = contractor.status.toLowerCase() == 'active';
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
              child: Icon(
                Icons.business_rounded,
                color: AppColors.brandPrimary,
                size: 20.r,
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
                          contractor.name,
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
                          contractor.status.tr(context: context),
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
                        Icons.tag_rounded,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      vSpace(4),
                      Text(
                        contractor.code,
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                      Text(
                        ' • ',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '$assignedWorkersCount ${'admin.siteMembers.workers'.tr(context: context)}',
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.info,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (contractor.contactPhone != null &&
                      contractor.contactPhone!.isNotEmpty) ...[
                    hSpace(4),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_outlined,
                          size: 14.r,
                          color: AppColors.textSecondary,
                        ),
                        vSpace(4),
                        Expanded(
                          child: Text(
                            contractor.contactPhone!,
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
