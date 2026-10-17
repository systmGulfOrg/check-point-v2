import 'package:check_point_v2/core/network/api_result.dart';
import '../../data/models/notification_page_model.dart';

abstract class NotificationsRepo {
  Future<ApiResult<NotificationPageModel>> getNotifications();
  Future<ApiResult<void>> markRead(String id);
  Future<ApiResult<void>> markAllRead();
  Future<ApiResult<void>> registerPushToken({
    required String token,
    String? platform,
  });
  Future<ApiResult<void>> deregisterPushToken(String token);
}
