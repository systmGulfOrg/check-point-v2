import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/notification_model.dart';
import '../cubit/notifications_cubit.dart';
import 'notification_card_widget.dart';

class NotificationsListWidget extends StatelessWidget {
  const NotificationsListWidget({required this.notifications, super.key});

  final List<NotificationModel> notifications;

  Future<void> _handleNotificationTap(
    BuildContext context,
    NotificationModel notification,
  ) async {
    if (notification.readAt == null) {
      context.read<NotificationsCubit>().markRead(notification.id);
    }

    var isAdmin = false;
    if (sl.isRegistered<AuthSessionStorage>()) {
      final roles = await sl<AuthSessionStorage>().readUserRoles();
      isAdmin = roles.any(
        (r) => r.toLowerCase() == 'admin' || r.toLowerCase() == 'hr',
      );
    }

    final route = PushRouteResolver.resolve(
      notification.type,
      notification.data,
      notification.key,
      isAdmin,
    );
    if (route == null || !context.mounted) return;
    await Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: notifications.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCardWidget(
          typeKey: 'supervisor.notifications.info',
          titleKey: notification.title,
          messageKey: notification.body,
          isWarning: notification.readAt == null,
          onTap: () => _handleNotificationTap(context, notification),
        );
      },
    );
  }
}
