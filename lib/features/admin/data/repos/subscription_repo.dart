import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/seat_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/subscription_summary_model.dart';

abstract class SubscriptionRepo {
  Future<ApiResult<SubscriptionSummaryModel>> getSubscriptionSummary();
  Future<ApiResult<SeatRequestModel>> createSeatRequest({
    required int requestedLimit,
    String? reason,
  });
  Future<ApiResult<void>> cancelSeatRequest(String id);
}
