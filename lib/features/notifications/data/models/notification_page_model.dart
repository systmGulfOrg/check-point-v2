import 'notification_model.dart';

class NotificationPageModel {
  const NotificationPageModel({required this.items, required this.unreadCount});

  final List<NotificationModel> items;
  final int unreadCount;
}
