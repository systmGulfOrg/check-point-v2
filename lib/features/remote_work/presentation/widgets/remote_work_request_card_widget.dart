import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_request_model.dart';

class RemoteWorkRequestCardWidget extends StatelessWidget {
  const RemoteWorkRequestCardWidget({
    required this.request,
    required this.canReview,
    required this.isOwnRequest,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final RemoteWorkRequestModel request;
  final bool canReview;
  final bool isOwnRequest;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) {
    final isPending = request.status.toLowerCase() == 'pending';
    final isOnsite = request.targetWorkSystem == 'onsite';
    final statusKey = 'remoteWork.status.${request.status.toLowerCase()}';

    return AppCardContainerWidget(
      margin: EdgeInsets.only(top: 10.h),
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: isOnsite
                        ? AppColors.softBrandBackground
                        : AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isOnsite
                        ? Icons.business_outlined
                        : Icons.home_work_outlined,
                    color: isOnsite ? AppColors.brandPrimary : AppColors.info,
                    size: 20.r,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.employeeName ??
                            'remoteWork.unknownEmployee'.tr(context: context),
                        style: AppTextStyles.font14SemiBold,
                      ),
                      hSpace(3),
                      Text(
                        isOnsite
                            ? 'remoteWork.onsiteTab'.tr(context: context)
                            : 'remoteWork.remoteTab'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  statusKey.tr(context: context),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: isPending
                        ? AppColors.warningOrange
                        : request.status.toLowerCase() == 'approved'
                        ? AppColors.success
                        : AppColors.error,
                  ),
                ),
              ],
            ),
            hSpace(10),
            Text(
              '${'remoteWork.date'.tr(context: context)}: ${request.requestDate.split('T').first}',
              style: AppTextStyles.font12Regular,
            ),
            if (request.reason != null && request.reason!.isNotEmpty) ...[
              hSpace(5),
              Text(
                '${'remoteWork.reason'.tr(context: context)}: ${request.reason}',
                style: AppTextStyles.font12Regular,
              ),
            ],
            if (canReview && !isOwnRequest && isPending) ...[
              hSpace(12),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      child: Text('remoteWork.reject'.tr(context: context)),
                    ),
                  ),
                  wSpace(10),
                  Expanded(
                    child: CustomButton(
                      text: 'remoteWork.approve'.tr(context: context),
                      height: 42,
                      onTap: onApprove,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
