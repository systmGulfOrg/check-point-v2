import 'package:check_point_v2/core/core.dart';
import '../../domain/repos/notifications_repo.dart';
import '../apis/notifications_api_service.dart';
import '../models/notification_model.dart';
import '../models/notification_page_model.dart';
import '../models/push_token_request_body.dart';

class NotificationsRepoImpl implements NotificationsRepo {
  NotificationsRepoImpl({required this.api});

  final NotificationsApiService api;

  @override
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

  @override
  Future<ApiResult<void>> markRead(String id) async {
    try {
      await api.markRead(id);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> markAllRead() async {
    try {
      await api.markAllRead();
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> registerPushToken({
    required String token,
    String? platform,
  }) async {
    try {
      await api.registerPushToken(
        PushTokenRequestBody(token: token, platform: platform),
      );
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> deregisterPushToken(String token) async {
    try {
      await api.deregisterPushToken(
        DeregisterPushTokenRequestBody(token: token),
      );
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
