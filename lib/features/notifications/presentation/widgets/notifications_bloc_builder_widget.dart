import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import 'notification_card_widget.dart';
import 'notifications_empty_state_widget.dart';
import 'notifications_error_widget.dart';
import 'notifications_header_widget.dart';
import 'notifications_list_widget.dart';

class NotificationsBlocBuilderWidget extends StatelessWidget {
  const NotificationsBlocBuilderWidget({super.key});

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
            itemBuilder: (_, _) => const NotificationCardWidget(
              typeKey: 'Notification',
              titleKey: 'Loading Notification Title Placeholder',
              messageKey: 'Loading notification message details placeholder',
              isWarning: false,
            ),
          ),
        ),
        NotificationsError(:final messageKey) => NotificationsErrorWidget(
          messageKey: messageKey,
          onRetry: () => context.read<NotificationsCubit>().load(),
        ),
        NotificationsSuccess(:final notifications, :final unreadCount) =>
          notifications.isEmpty
              ? const NotificationsEmptyStateWidget()
              : Column(
                  children: [
                    NotificationsHeaderWidget(unreadCount: unreadCount),
                    Expanded(
                      child: NotificationsListWidget(
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
