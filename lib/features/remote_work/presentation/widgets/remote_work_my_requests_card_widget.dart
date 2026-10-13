import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_request_model.dart';

class RemoteWorkMyRequestsCardWidget extends StatelessWidget {
  const RemoteWorkMyRequestsCardWidget({
    required this.requests,
    required this.onDelete,
    super.key,
  });

  final List<RemoteWorkRequestModel> requests;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    return AppCardContainerWidget(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
      child: Column(
        children: requests.asMap().entries.map((entry) {
          final request = entry.value;
          final isLast = entry.key == requests.length - 1;
          final statusKey = 'remoteWork.status.${request.status.toLowerCase()}';
          return Column(
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                minVerticalPadding: 10.h,
                leading: Container(
                  width: 34.r,
                  height: 34.r,
                  decoration: BoxDecoration(
                    color: AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.schedule_outlined,
                    size: 18.r,
                    color: AppColors.info,
                  ),
                ),
                title: Text(
                  request.requestDate.split('T').first,
                  style: AppTextStyles.font13SemiBold,
                ),
                subtitle: Text(
                  request.targetWorkSystem == 'onsite'
                      ? 'remoteWork.onsiteTab'.tr(context: context)
                      : 'remoteWork.remoteTab'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      statusKey.tr(context: context),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: request.status.toLowerCase() == 'approved'
                            ? AppColors.success
                            : request.status.toLowerCase() == 'rejected'
                            ? AppColors.error
                            : AppColors.warningOrange,
                      ),
                    ),
                    if (request.status.toLowerCase() == 'pending')
                      IconButton(
                        tooltip: 'common.delete'.tr(context: context),
                        onPressed: () => onDelete(request.id),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: AppColors.error,
                          size: 20.r,
                        ),
                      ),
                  ],
                ),
              ),
              if (!isLast) const Divider(height: 1),
            ],
          );
        }).toList(),
      ),
    );
  }
}
