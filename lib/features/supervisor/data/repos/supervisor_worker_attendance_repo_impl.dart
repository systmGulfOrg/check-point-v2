import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_response_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/worker_day_response_model.dart';
import 'supervisor_worker_attendance_repo.dart';

class SupervisorWorkerAttendanceRepoImpl
    implements SupervisorWorkerAttendanceRepo {
  SupervisorWorkerAttendanceRepoImpl({required this.api});

  final SupervisorApiService api;

  @override
  Future<ApiResult<List<WorkerDayItemModel>>> getWorkerAttendanceDay({
    required String date,
    String? contractorId,
    String? search,
    int index = 0,
    int itemCount = 100,
  }) async {
    try {
      final response = await api.getWorkerAttendanceDay(
        date: date,
        contractorId: contractorId,
        search: search,
        index: index,
        itemCount: itemCount,
      );
      if (response.isSuccess != true && response.value == null) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.somethingWentWrong',
          ),
        );
      }
      final items = response.value?.items ?? const [];
      return ApiResult.success(items);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }

  @override
  Future<ApiResult<RecordWorkerAttendanceValueModel>> recordWorkerAttendance(
    RecordWorkerAttendanceRequestBody body,
  ) async {
    try {
      final response = await api.recordWorkerAttendance(body);
      if (response.isSuccess != true && response.value == null) {
        return ApiResult.failure(
          ApiFailureMapper.fromMessages(
            response.errors,
            fallbackMessageKey: 'errors.somethingWentWrong',
          ),
        );
      }
      final value = response.value;
      if (value == null) {
        return const ApiResult.failure(
          ApiFailure(messageKey: 'errors.somethingWentWrong'),
        );
      }
      return ApiResult.success(value);
    } catch (error) {
      return ApiResult.failure(ApiFailureMapper.map(error));
    }
  }
}
