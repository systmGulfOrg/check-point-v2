import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/styles/app_text_styles.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';

class SupervisorNotificationsHeaderWidget extends StatelessWidget {
  const SupervisorNotificationsHeaderWidget({
    required this.unreadCount,
    super.key,
  });

  final int unreadCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16.w, 4.h, 16.w, 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'supervisor.notifications.unread'.tr(args: ['$unreadCount']),
            style: AppTextStyles.font12Regular,
          ),
          TextButton(
            onPressed: unreadCount == 0
                ? null
                : () => context.read<NotificationsCubit>().markAllRead(),
            child: Text('supervisor.notifications.markAllRead'.tr()),
          ),
        ],
      ),
    );
  }
}
