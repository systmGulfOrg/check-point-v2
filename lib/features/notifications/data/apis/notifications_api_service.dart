import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/push_token_request_body.dart';

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

  @POST('/api/v2/devices/tokens')
  Future<dynamic> registerPushToken(@Body() PushTokenRequestBody body);

  @DELETE('/api/v2/devices/tokens')
  Future<dynamic> deregisterPushToken(
    @Body() DeregisterPushTokenRequestBody body,
  );
}
