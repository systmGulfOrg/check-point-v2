import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminRegistrationRequestCardWidget extends StatelessWidget {
  const AdminRegistrationRequestCardWidget({
    required this.onView,
    required this.onApprove,
    required this.onReject,
    super.key,
  });

  final VoidCallback onView;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(16.r),
    decoration: AppDecorations.card,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.softBrandBackground,
              child: Text(
                'AM',
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
            vSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ahmed Mohamed', style: AppTextStyles.font16Bold),
                  hSpace(4),
                  Text(
                    'Samsung A54  •  02/09/2026',
                    style: AppTextStyles.font12Regular,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.softYellowBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Text(
                'admin.requests.filterPending'.tr(context: context),
                style: AppTextStyles.font12Bold.copyWith(
                  color: AppColors.warningOrange,
                ),
              ),
            ),
          ],
        ),
        hSpace(16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onView,
                icon: Icon(Icons.visibility_outlined, size: 17.r),
                label: Text('admin.requests.viewDetails'.tr(context: context)),
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
            vSpace(8),
            PopupMenuButton<String>(
              color: AppColors.white,
              surfaceTintColor: AppColors.white,
              elevation: 8,
              onSelected: (value) {
                if (value == 'approve') onApprove();
                if (value == 'reject') onReject();
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'approve',
                  child: Text('admin.requests.approve'.tr(context: context)),
                ),
                PopupMenuItem(
                  value: 'reject',
                  child: Text('admin.requests.reject'.tr(context: context)),
                ),
              ],
              child: Container(
                width: 46.r,
                height: 46.r,
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: const Icon(
                  Icons.more_horiz_rounded,
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
