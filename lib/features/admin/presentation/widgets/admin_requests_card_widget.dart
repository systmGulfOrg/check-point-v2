import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminRequestsCardWidget extends StatelessWidget {
  const AdminRequestsCardWidget({
    required this.name,
    required this.deviceId,
    required this.date,
    required this.statusKey,
    super.key,
    this.onApprove,
    this.onReject,
  });

  final String name;
  final String deviceId;
  final String date;
  final String statusKey;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  bool get isPending =>
      statusKey.contains('Pending') || statusKey.contains('pending');
  bool get isApproved =>
      statusKey.contains('Approved') || statusKey.contains('approved');

  Color _getStatusBackgroundColor() {
    if (isPending) return AppColors.softYellowBackground;
    if (isApproved) return AppColors.softGreenBackground;
    return AppColors.softBrandBackground;
  }

  Color _getStatusTextColor() {
    if (isPending) return AppColors.warningOrange;
    if (isApproved) return AppColors.success;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTextStyles.font16Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  statusKey.tr(context: context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: _getStatusTextColor(),
                  ),
                ),
              ),
            ],
          ),
          hSpace(4),
          Text(
            deviceId,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.placeholder,
            ),
          ),
          hSpace(2),
          Text(
            date,
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          if (isPending) ...[
            hSpace(14),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'admin.requests.reject'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                ),
                vSpace(12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onApprove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandPrimary,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'admin.requests.approve'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
