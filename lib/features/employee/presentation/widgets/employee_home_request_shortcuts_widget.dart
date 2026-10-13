import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';

class EmployeeHomeRequestShortcutsWidget extends StatelessWidget {
  const EmployeeHomeRequestShortcutsWidget({super.key});

  @override
  Widget build(BuildContext context) => AppCardContainerWidget(
    padding: EdgeInsets.all(10.w),
    child: Row(
      children: [
        Expanded(
          child: Material(
            color: AppColors.softBlueBackground,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, AppRoutes.remoteWork),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.swap_horiz_rounded,
                      color: AppColors.info,
                      size: 20.r,
                    ),
                    wSpace(6),
                    Flexible(
                      child: Text(
                        'remoteWork.requestLocation'.tr(context: context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font12SemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        wSpace(8),
        Expanded(
          child: Material(
            color: AppColors.softYellowBackground,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, AppRoutes.overtime),
              borderRadius: BorderRadius.circular(12.r),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 11.h, horizontal: 6.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.more_time_rounded,
                      color: AppColors.warningOrange,
                      size: 20.r,
                    ),
                    wSpace(6),
                    Flexible(
                      child: Text(
                        'overtime.title'.tr(context: context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font12SemiBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
