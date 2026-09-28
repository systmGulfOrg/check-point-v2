import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';

class ContractorWorkerQrSheetWidget extends StatelessWidget {
  const ContractorWorkerQrSheetWidget({
    super.key,
    required this.worker,
  });

  final ContractorWorkerModel worker;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            worker.fullName,
            style: AppTextStyles.font16Bold,
          ),
          SizedBox(height: 4.h),
          Text(
            '${worker.jobTitle} • ${worker.workerCode}',
            style: AppTextStyles.font12Regular.copyWith(color: AppColors.textSecondary),
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Icon(Icons.qr_code_2_rounded, size: 140.r, color: AppColors.textPrimary),
          ),
          SizedBox(height: 16.h),
          Text(
            'contractor.workers.qrCode'.tr(),
            style: AppTextStyles.font13Medium.copyWith(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
