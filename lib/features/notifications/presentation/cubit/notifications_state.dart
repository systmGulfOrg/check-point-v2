import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/notification_model.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = NotificationsInitial;
  const factory NotificationsState.loading() = NotificationsLoading;
  const factory NotificationsState.success(
    List<NotificationModel> notifications,
    int unreadCount,
  ) = NotificationsSuccess;
  const factory NotificationsState.error(String messageKey) =
      NotificationsError;
}
