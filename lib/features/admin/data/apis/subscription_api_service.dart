import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'package:check_point_v2/features/admin/data/models/subscription/seat_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/subscription_summary_model.dart';

part 'subscription_api_service.g.dart';

@RestApi()
abstract class SubscriptionApiService {
  factory SubscriptionApiService(Dio dio, {String? baseUrl}) =
      _SubscriptionApiService;

  @GET('/api/v2/subscription')
  Future<SubscriptionSummaryResultModel> getSubscriptionSummary();

  @POST('/api/v2/seat-requests')
  Future<SeatRequestResultModel> createSeatRequest(
    @Body() CreateSeatRequestBody body,
  );

  @PATCH('/api/v2/seat-requests/{id}/status')
  Future<SeatRequestResultModel> cancelSeatRequest(
    @Path('id') String id,
    @Body() Map<String, dynamic> body,
  );
}
