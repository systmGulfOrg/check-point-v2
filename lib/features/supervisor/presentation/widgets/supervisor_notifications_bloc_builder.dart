import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/core.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../../../notifications/presentation/cubit/notifications_state.dart';
import 'supervisor_notification_card_widget.dart';

class SupervisorNotificationsBlocBuilder extends StatelessWidget {
  const SupervisorNotificationsBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) => switch (state) {
        NotificationsInitial() => const SizedBox.shrink(),
        NotificationsLoading() => Skeletonizer(
          enabled: true,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            itemCount: 4,
            separatorBuilder: (_, _) => hSpace(10),
            itemBuilder: (_, _) => const SupervisorNotificationCardWidget(
              typeKey: 'Notification',
              titleKey: 'Loading Notification Title Placeholder',
              messageKey: 'Loading notification message details placeholder',
              isWarning: false,
            ),
          ),
        ),
        NotificationsError(:final messageKey) => Center(
          child: Text(messageKey.tr()),
        ),
        NotificationsSuccess(:final notifications, :final unreadCount) =>
          notifications.isEmpty
              ? Center(child: Text('common.noData'.tr()))
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                        16.w,
                        4.h,
                        16.w,
                        8.h,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'supervisor.notifications.unread'.tr(
                              args: ['$unreadCount'],
                            ),
                            style: AppTextStyles.font12Regular,
                          ),
                          TextButton(
                            onPressed: unreadCount == 0
                                ? null
                                : () => context
                                      .read<NotificationsCubit>()
                                      .markAllRead(),
                            child: Text(
                              'supervisor.notifications.markAllRead'.tr(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                        itemCount: notifications.length,
                        separatorBuilder: (_, _) => hSpace(10),
                        itemBuilder: (context, index) {
                          final notification = notifications[index];
                          return InkWell(
                            onTap: notification.readAt == null
                                ? () => context
                                      .read<NotificationsCubit>()
                                      .markRead(notification.id)
                                : null,
                            child: SupervisorNotificationCardWidget(
                              typeKey: 'supervisor.notifications.info',
                              titleKey: notification.title,
                              messageKey: notification.body,
                              isWarning: notification.readAt == null,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
