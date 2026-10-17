import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminSubscriptionPendingRequestCardWidget extends StatelessWidget {
  const AdminSubscriptionPendingRequestCardWidget({
    required this.onCancel,
    super.key,
    this.requestedLimit,
  });

  final int? requestedLimit;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.softYellowBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.warningOrange.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.hourglass_top_rounded,
            size: 20.r,
            color: AppColors.warningOrange,
          ),
          wSpace(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'admin.subscription.pendingRequestTitle'.tr(
                    context: context,
                  ),
                  style: AppTextStyles.font13SemiBold,
                ),
                if (requestedLimit != null)
                  Text(
                    'admin.subscription.pendingRequestSubtitle'.tr(
                      context: context,
                      args: ['$requestedLimit'],
                    ),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.placeholder,
                    ),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onCancel,
            child: Text(
              'admin.subscription.cancelRequest'.tr(context: context),
            ),
          ),
        ],
      ),
    );
  }
}
