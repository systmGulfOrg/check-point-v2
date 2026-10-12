import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';

class AdminContractorCardWidget extends StatelessWidget {
  const AdminContractorCardWidget({
    required this.contractor,
    this.onTap,
    super.key,
  });

  final ContractorCompanyModel contractor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: Container(
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
                    child: Text(
                      contractor.name,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: contractor.status == 'active'
                          ? AppColors.softGreenBackground
                          : AppColors.softYellowBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      contractor.status == 'active'
                          ? 'admin.contractors.active'.tr()
                          : 'admin.contractors.inactive'.tr(),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: contractor.status == 'active'
                            ? AppColors.success
                            : AppColors.warningOrange,
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(8),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      contractor.code,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                  vSpace(12),
                  if (contractor.taxNumber != null)
                    Text(
                      '${'admin.contractors.taxNumber'.tr()}: ${contractor.taxNumber}',
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 13.r,
                          color: AppColors.brandPrimary,
                        ),
                        vSpace(4),
                        Text(
                          '${contractor.workerCount} ${'admin.contractors.totalWorkers'.tr()}',
                          style: AppTextStyles.font11Medium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ],
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
                    Icons.person_outline_rounded,
                    size: 16.r,
                    color: AppColors.textSecondary,
                  ),
                  vSpace(6),
                  Text(
                    contractor.contactName ?? '',
                    style: AppTextStyles.font13Medium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  if (contractor.contactPhone != null) ...[
                    Icon(
                      Icons.phone_outlined,
                      size: 16.r,
                      color: AppColors.textSecondary,
                    ),
                    vSpace(4),
                    Text(
                      contractor.contactPhone!,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    vSpace(8),
                  ],
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13.r,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
