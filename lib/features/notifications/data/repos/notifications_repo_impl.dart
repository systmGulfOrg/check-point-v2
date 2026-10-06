import '../../../../core/network/api_failure_mapper.dart';
import '../../../../core/network/api_result.dart';
import '../apis/notifications_api_service.dart';
import '../models/notification_model.dart';
import '../models/notification_page_model.dart';

class NotificationsRepoImpl {
  NotificationsRepoImpl({required this.api});

  final NotificationsApiService api;

  Future<ApiResult<NotificationPageModel>> getNotifications() async {
    try {
      final response = await api.getNotifications();
      final value = response['value'];
      final items = value is Map<String, dynamic> ? value['items'] : null;
      final list = items is List
          ? items
                .whereType<Map<String, dynamic>>()
                .map(NotificationModel.fromJson)
                .toList()
          : <NotificationModel>[];
      final unreadCount =
          value is Map<String, dynamic> && value['unreadCount'] is num
          ? (value['unreadCount'] as num).toInt()
          : list.where((notification) => notification.readAt == null).length;
      return ApiResult.success(
        NotificationPageModel(items: list, unreadCount: unreadCount),
      );
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<void>> markRead(String id) async {
    try {
      await api.markRead(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  Future<ApiResult<void>> markAllRead() async {
    try {
      await api.markAllRead();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
