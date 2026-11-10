import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/models/offline_attendance_models.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/pending_attendance_verification_card_widget.dart';

class PendingAttendanceVerificationListWidget extends StatelessWidget {
  const PendingAttendanceVerificationListWidget({
    super.key,
    required this.items,
    required this.onRefresh,
    required this.onApprove,
    required this.onReject,
  });

  final List<PendingAttendanceItem> items;
  final RefreshCallback onRefresh;
  final ValueChanged<String> onApprove;
  final ValueChanged<String> onReject;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return RefreshIndicator(
        onRefresh: onRefresh,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: [
            SizedBox(height: 120.h),
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.check_circle_outline_rounded,
                    size: 64.sp,
                    color: AppColors.textSecondary,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'offline.emptyPending'.tr(),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final item = items[index];
          return PendingAttendanceVerificationCardWidget(
            item: item,
            onApprove: () => onApprove(item.id),
            onReject: () => onReject(item.id),
          );
        },
      ),
    );
  }
}
