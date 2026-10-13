import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorWorkLocationQuickActionWidget extends StatelessWidget {
  const SupervisorWorkLocationQuickActionWidget({super.key});

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
    borderRadius: BorderRadius.circular(14.r),
    child: AppCardContainerWidget(
      backgroundColor: AppColors.softBlueBackground,
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.swap_horiz_rounded,
                color: AppColors.info,
                size: 22.r,
              ),
            ),
            wSpace(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'remoteWork.requestLocation'.tr(context: context),
                    style: AppTextStyles.font14SemiBold,
                  ),
                  hSpace(3),
                  Text(
                    'supervisor.workLocationActionSubtitle'.tr(
                      context: context,
                    ),
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16.r),
          ],
        ),
      ),
    ),
  );
}
