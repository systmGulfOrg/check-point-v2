import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../../../notifications/presentation/cubit/notifications_state.dart';

class EmployeeSettingsNotificationsTileBlocSelectorWidget
    extends StatelessWidget {
  const EmployeeSettingsNotificationsTileBlocSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotificationsCubit, NotificationsState, int>(
      selector: (state) => switch (state) {
        NotificationsSuccess(:final unreadCount) => unreadCount,
        _ => 0,
      },
      builder: (context, unreadCount) {
        return InkWell(
          onTap: () => Navigator.pushNamed(context, AppRoutes.notifications),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Icon(
                  Icons.notifications_none_rounded,
                  size: 20.r,
                  color: AppColors.textSecondary,
                ),
                wSpace(12),
                Expanded(
                  child: Text(
                    'employee.settings.notifications'.tr(context: context),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                if (unreadCount > 0)
                  Container(
                    margin: EdgeInsetsDirectional.only(end: 8.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Text(
                      '$unreadCount',
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                else
                  Text(
                    'employee.settings.enabled'.tr(context: context),
                    style: AppTextStyles.font13Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                wSpace(6),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18.r,
                  color: AppColors.placeholder,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
