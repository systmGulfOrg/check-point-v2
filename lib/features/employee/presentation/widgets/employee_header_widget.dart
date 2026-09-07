import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class EmployeeHeaderWidget extends StatelessWidget {
  const EmployeeHeaderWidget({
    required this.titleKey,
    required this.userName,
    required this.dateText,
    required this.notificationCount,
    super.key,
  });

  final String titleKey;
  final String userName;
  final String dateText;
  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              titleKey.tr(context: context),
              style: AppTextStyles.font24Bold,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.border),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadow,
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.brandInk,
                      size: 20.r,
                    ),
                  ),
                ),
                if (notificationCount > 0)
                  Positioned(
                    top: -2.h,
                    right: -2.w,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: const BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 16.r,
                        minHeight: 16.r,
                      ),
                      child: Center(
                        child: Text(
                          '$notificationCount',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        hSpace(16),
        Text(
          'employee.home.greeting'.tr(context: context),
          style: AppTextStyles.font14Regular,
        ),
        hSpace(4),
        Text(userName, style: AppTextStyles.font20Bold),
        hSpace(4),
        Text(dateText, style: AppTextStyles.font13Regular),
      ],
    );
  }
}
