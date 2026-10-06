import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';

class AdminRegistrationRequestCardWidget extends StatelessWidget {
  const AdminRegistrationRequestCardWidget({
    required this.request,
    required this.onView,
    this.onApprove,
    this.onReject,
    this.onDelete,
    super.key,
  });

  final AccountRequestModel request;
  final VoidCallback onView;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;
  final VoidCallback? onDelete;

  Color _getStatusBackgroundColor() {
    if (request.isApproved) return AppColors.softGreenBackground;
    if (request.isRejected) return AppColors.softRedBackground;
    return AppColors.softYellowBackground;
  }

  Color _getStatusTextColor() {
    if (request.isApproved) return AppColors.success;
    if (request.isRejected) return AppColors.error;
    return AppColors.warningOrange;
  }

  String _getStatusText(BuildContext context) {
    if (request.isApproved) {
      return 'admin.requests.filterApproved'.tr(context: context);
    }
    if (request.isRejected) {
      return 'admin.requests.filterRejected'.tr(context: context);
    }
    return 'admin.requests.filterPending'.tr(context: context);
  }

  @override
  Widget build(BuildContext context) {
    final name = request.name?.trim().isNotEmpty == true ? request.name! : '-';
    final deviceId = request.mobileId ?? '-';
    final date = request.createdDate != null
        ? AppDateFormatter.formatDayMonthYear(request.createdDate!)
        : '-';

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: AppDecorations.card,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              AppAvatarWidget(
                imageUrl: request.photo,
                name: name,
                subtitle: request.mobileId,
                radius: 24.r,
                enablePreview: true,
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyles.font16Bold),
                    hSpace(4),
                    Text(
                      '$deviceId  •  $date',
                      style: AppTextStyles.font12Regular,
                    ),
                    if (request.phone != null && request.phone!.isNotEmpty) ...[
                      hSpace(2),
                      Text(
                        request.phone!,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: _getStatusBackgroundColor(),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  _getStatusText(context),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: _getStatusTextColor(),
                  ),
                ),
              ),
            ],
          ),
          if (request.rejectReason != null &&
              request.rejectReason!.isNotEmpty) ...[
            hSpace(10),
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.softRedBackground.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                '${'admin.requests.rejectionReason'.tr(context: context)}: ${request.rejectReason}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ],
          hSpace(14),
          if (request.isPending) ...[
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
                vSpace(10),
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
                vSpace(10),
                InkWell(
                  onTap: onView,
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    width: 42.r,
                    height: 42.r,
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Icon(
                      Icons.visibility_outlined,
                      color: AppColors.brandInk,
                      size: 20.r,
                    ),
                  ),
                ),
              ],
            ),
          ] else ...[
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onView,
                    icon: Icon(Icons.visibility_outlined, size: 17.r),
                    label: Text(
                      'admin.requests.viewDetails'.tr(context: context),
                    ),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.brandInk,
                      side: const BorderSide(color: AppColors.border),
                      padding: EdgeInsets.symmetric(vertical: 11.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                if (onDelete != null) ...[
                  vSpace(8),
                  InkWell(
                    onTap: onDelete,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      width: 46.r,
                      height: 46.r,
                      decoration: BoxDecoration(
                        color: AppColors.softRedBackground,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                        size: 20.r,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
