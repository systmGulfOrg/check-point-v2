import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class SupervisorContractorHeadcountCardWidget extends StatelessWidget {
  const SupervisorContractorHeadcountCardWidget({
    super.key,
    required this.contractorName,
    required this.code,
    required this.presentCount,
    required this.totalCount,
    required this.lateCount,
    required this.outsideGeofenceCount,
    this.onTap,
  });

  final String contractorName;
  final String code;
  final int presentCount;
  final int totalCount;
  final int lateCount;
  final int outsideGeofenceCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final double percent = totalCount > 0 ? (presentCount / totalCount) : 0.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          margin: EdgeInsets.only(bottom: 12.h),
          padding: EdgeInsets.all(14.r),
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
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contractorName,
                      style: AppTextStyles.font14Bold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(2),
                    Text(
                      'Code: $code',
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              wSpace(8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  '$presentCount / $totalCount Present',
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.brandPrimaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          hSpace(10),
          ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressIndicator(
              value: percent,
              minHeight: 6.h,
              backgroundColor: AppColors.pageBackground,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandPrimary),
            ),
          ),
          hSpace(10),
          Wrap(
            spacing: 12.w,
            runSpacing: 4.h,
            children: [
              if (lateCount > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time_filled_rounded, size: 14.r, color: AppColors.warning),
                    wSpace(4),
                    Text(
                      '$lateCount Late',
                      style: AppTextStyles.font11Medium.copyWith(color: AppColors.warning),
                    ),
                  ],
                ),
              if (outsideGeofenceCount > 0)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_off_rounded, size: 14.r, color: AppColors.error),
                    wSpace(4),
                    Text(
                      '$outsideGeofenceCount Outside Geofence',
                      style: AppTextStyles.font11Medium.copyWith(color: AppColors.error),
                    ),
                  ],
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
