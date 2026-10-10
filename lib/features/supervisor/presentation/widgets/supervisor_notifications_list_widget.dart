import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../../notifications/data/models/notification_model.dart';
import '../../../notifications/presentation/cubit/notifications_cubit.dart';
import 'supervisor_notification_card_widget.dart';

class SupervisorNotificationsListWidget extends StatelessWidget {
  const SupervisorNotificationsListWidget({
    required this.notifications,
    super.key,
  });

  final List<NotificationModel> notifications;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: notifications.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return InkWell(
          onTap: notification.readAt == null
              ? () =>
                    context.read<NotificationsCubit>().markRead(notification.id)
              : null,
          child: SupervisorNotificationCardWidget(
            typeKey: 'supervisor.notifications.info',
            titleKey: notification.title,
            messageKey: notification.body,
            isWarning: notification.readAt == null,
          ),
        );
      },
    );
  }
}
