import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_motion.dart';
import '../../../../core/styles/app_text_styles.dart';

Future<void> showLeavePolicyDialog(BuildContext context) async {
  await showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'leaves.policy.title'.tr(context: context),
    barrierColor: Colors.black54,
    transitionDuration: AppMotion.routeEnter,
    pageBuilder: (context, animation, secondaryAnimation) =>
        const LeavePolicyDialogWidget(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: AppMotion.enterCurve,
        reverseCurve: AppMotion.exitCurve,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.92, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class LeavePolicyDialogWidget extends StatelessWidget {
  const LeavePolicyDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final policies = [
      'leaves.policy.twoConsecutiveDays',
      'leaves.policy.48Hours',
      'leaves.policy.managerAndHr',
      'leaves.policy.balance',
    ];

    return Dialog(
      backgroundColor: AppColors.cardBackground,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44.r,
                  height: 44.r,
                  decoration: const BoxDecoration(
                    color: AppColors.softBrandBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.policy_outlined,
                    color: AppColors.brandPrimary,
                    size: 24.r,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'leaves.policy.title'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'leaves.policy.subtitle'.tr(context: context),
              style: AppTextStyles.font13Regular,
            ),
            SizedBox(height: 16.h),
            for (var index = 0; index < policies.length; index++) ...[
              if (index > 0) SizedBox(height: 12.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: const BoxDecoration(
                      color: AppColors.softGreenBackground,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: AppColors.success,
                      size: 16.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      policies[index].tr(context: context),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textPrimary,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            SizedBox(height: 20.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pop(context),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'common.gotIt'.tr(context: context),
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
