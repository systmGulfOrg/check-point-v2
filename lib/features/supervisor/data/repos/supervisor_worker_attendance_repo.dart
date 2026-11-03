import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/record_worker_attendance_response_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/worker_attendance/worker_day_response_model.dart';

abstract class SupervisorWorkerAttendanceRepo {
  Future<ApiResult<List<WorkerDayItemModel>>> getWorkerAttendanceDay({
    required String date,
    String? contractorId,
    String? search,
    int index = 0,
    int itemCount = 100,
  });

  Future<ApiResult<RecordWorkerAttendanceValueModel>> recordWorkerAttendance(
    RecordWorkerAttendanceRequestBody body,
  );
}
