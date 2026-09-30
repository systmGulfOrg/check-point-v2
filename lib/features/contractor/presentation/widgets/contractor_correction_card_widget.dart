import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_correction_model.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorCorrectionCardWidget extends StatelessWidget {
  const ContractorCorrectionCardWidget({super.key, required this.correction});

  final ContractorCorrectionModel correction;

  Color get statusColor {
    switch (correction.status.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.warning;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(correction.workerName, style: AppTextStyles.font14Bold),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'contractor.requests.status.${correction.status.toLowerCase()}'
                      .tr(),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          hSpace(6),
          Text(
            '${correction.date} • ${correction.workerCode}',
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          hSpace(8),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'contractor.requests.requestedCheckIn'.tr(),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      correction.requestedCheckIn,
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ],
                ),
                Container(width: 1.w, height: 24.h, color: AppColors.border),
                Column(
                  children: [
                    Text(
                      'contractor.requests.requestedCheckOut'.tr(),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      correction.requestedCheckOut,
                      style: AppTextStyles.font14Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          hSpace(8),
          Text(
            '${'contractor.requests.reason'.tr()}: ${correction.reason}',
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
