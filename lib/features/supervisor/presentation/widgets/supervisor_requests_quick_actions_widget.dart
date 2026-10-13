import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';

class SupervisorRequestsQuickActionsWidget extends StatelessWidget {
  const SupervisorRequestsQuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) => AppCardContainerWidget(
    padding: EdgeInsets.all(12.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'employee.home.quickActions'.tr(context: context),
          style: AppTextStyles.font14Bold,
        ),
        hSpace(10),
        Row(
          children: [
            Expanded(
              child: Material(
                color: AppColors.softBlueBackground,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.remoteWork),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 8.w,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.swap_horiz_rounded,
                          color: AppColors.info,
                          size: 22.r,
                        ),
                        hSpace(5),
                        Text(
                          'remoteWork.requestLocation'.tr(context: context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font12SemiBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            wSpace(10),
            Expanded(
              child: Material(
                color: AppColors.softYellowBackground,
                borderRadius: BorderRadius.circular(12.r),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, AppRoutes.overtime),
                  borderRadius: BorderRadius.circular(12.r),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 12.h,
                      horizontal: 8.w,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          Icons.more_time_rounded,
                          color: AppColors.warningOrange,
                          size: 22.r,
                        ),
                        hSpace(5),
                        Text(
                          'overtime.title'.tr(context: context),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font12SemiBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
