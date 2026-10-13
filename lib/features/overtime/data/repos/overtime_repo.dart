import 'package:check_point_v2/core/network/api_result.dart';
import '../models/overtime_request_model.dart';

abstract class OvertimeRepo {
  Future<ApiResult<List<OvertimeRequestModel>>> getRequests();
  Future<ApiResult<void>> createRequest({
    required String requestDate,
    required String startTime,
    required String endTime,
    String? reason,
  });
  Future<ApiResult<void>> updateStatus({
    required String id,
    required String status,
    String? reviewNote,
  });
}
