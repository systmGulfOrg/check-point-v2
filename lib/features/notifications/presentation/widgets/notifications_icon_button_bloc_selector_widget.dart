import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';

class NotificationsIconButtonBlocSelectorWidget extends StatelessWidget {
  const NotificationsIconButtonBlocSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotificationsCubit, NotificationsState, int>(
      selector: (state) => switch (state) {
        NotificationsSuccess(:final unreadCount) => unreadCount,
        _ => 0,
      },
      builder: (context, unreadCount) {
        return Stack(
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
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.notifications);
                },
                icon: Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.brandInk,
                  size: 20.r,
                ),
              ),
            ),
            if (unreadCount > 0)
              Positioned(
                top: -2.h,
                right: -2.w,
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: const BoxDecoration(
                    color: AppColors.brandPrimary,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 16.r, minHeight: 16.r),
                  child: Center(
                    child: Text(
                      '$unreadCount',
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
        );
      },
    );
  }
}
