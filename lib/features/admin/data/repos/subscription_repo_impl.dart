import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/subscription_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/seat_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/subscription_summary_model.dart';
import 'subscription_repo.dart';

class SubscriptionRepoImpl implements SubscriptionRepo {
  SubscriptionRepoImpl({required this.api});

  final SubscriptionApiService api;

  @override
  Future<ApiResult<SubscriptionSummaryModel>> getSubscriptionSummary() async {
    try {
      final response = await api.getSubscriptionSummary();
      final summary = response.value;
      if (response.isSuccess != true || summary == null) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.subscriptionLoadFailed'),
        );
      }
      return ApiResult.success(summary);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<SeatRequestModel>> createSeatRequest({
    required int requestedLimit,
    String? reason,
  }) async {
    try {
      final response = await api.createSeatRequest(
        CreateSeatRequestBody(requestedLimit: requestedLimit, reason: reason),
      );
      final request = response.value;
      if (response.isSuccess != true || request == null) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.seatRequestFailed',
          ),
        );
      }
      return ApiResult.success(request);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<void>> cancelSeatRequest(String id) async {
    try {
      await api.cancelSeatRequest(id, const {'action': 'cancel'});
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }
}
