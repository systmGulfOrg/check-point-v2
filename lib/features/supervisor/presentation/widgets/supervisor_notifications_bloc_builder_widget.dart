import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import '../../../notifications/presentation/cubit/notifications_state.dart';
import 'supervisor_notification_card_widget.dart';
import 'supervisor_notifications_header_widget.dart';
import 'supervisor_notifications_list_widget.dart';

class SupervisorNotificationsBlocBuilderWidget extends StatelessWidget {
  const SupervisorNotificationsBlocBuilderWidget({super.key});

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
                    SupervisorNotificationsHeaderWidget(
                      unreadCount: unreadCount,
                    ),
                    Expanded(
                      child: SupervisorNotificationsListWidget(
                        notifications: notifications,
                      ),
                    ),
                  ],
                ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
