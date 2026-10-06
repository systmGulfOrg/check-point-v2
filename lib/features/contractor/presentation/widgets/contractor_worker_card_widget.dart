import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorWorkerCardWidget extends StatelessWidget {
  const ContractorWorkerCardWidget({
    super.key,
    required this.worker,
    this.onTap,
    this.onQrTap,
  });

  final ContractorWorkerModel worker;
  final VoidCallback? onTap;
  final VoidCallback? onQrTap;

  Color get statusColor {
    switch (worker.status.toLowerCase()) {
      case 'present':
        return AppColors.success;
      case 'late':
        return AppColors.warning;
      case 'absent':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.6)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.03),
            blurRadius: 8.r,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        onTap: onTap,
        leading: CircleAvatar(
          radius: 22.r,
          backgroundColor: AppColors.brandPrimary.withValues(alpha: 0.12),
          child: Text(
            worker.displayName.isNotEmpty
                ? worker.displayName[0].toUpperCase()
                : 'W',
            style: AppTextStyles.font16Bold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                worker.displayName,
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                worker.status,
                style: AppTextStyles.font11Medium.copyWith(
                  color: statusColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            hSpace(4),
            Text(
              '${worker.displayJob.isNotEmpty ? worker.displayJob : "عامل"} • ${worker.displayCode}',
              style: AppTextStyles.font12Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(4),
            Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14.r,
                  color: AppColors.brandPrimary,
                ),
                wSpace(4),
                Expanded(
                  child: Text(
                    '${worker.projectName ?? ""} ${worker.siteName != null ? "- ${worker.siteName}" : ""}'.trim(),
                    style: AppTextStyles.font11Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.qr_code_2_rounded, color: AppColors.brandPrimary, size: 24.r),
          onPressed: onQrTap,
        ),
      ),
    );
  }
}
