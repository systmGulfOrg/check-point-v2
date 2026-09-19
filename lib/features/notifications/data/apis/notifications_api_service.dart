import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'notifications_api_service.g.dart';

@RestApi()
abstract class NotificationsApiService {
  factory NotificationsApiService(Dio dio, {String? baseUrl}) =
      _NotificationsApiService;

  @GET('/api/v2/notifications')
  Future<dynamic> getNotifications({
    @Query('unreadOnly') bool unreadOnly = false,
    @Query('itemCount') int itemCount = 50,
    @Query('index') int index = 0,
  });

  @PATCH('/api/v2/notifications/{id}/read')
  Future<dynamic> markRead(@Path('id') String id);

  @POST('/api/v2/notifications/read-all')
  Future<dynamic> markAllRead();
}
