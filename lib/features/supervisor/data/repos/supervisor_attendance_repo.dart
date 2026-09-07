import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/admin_attendance_model.dart';
import '../models/supervisor_attendance_check_in_request_body.dart';
import '../models/supervisor_attendance_check_out_request_body.dart';

abstract class SupervisorAttendanceRepo {
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendance({
    int? departmentId,
    String? attendanceDate,
  });
  Future<ApiResult<List<AdminAttendanceModel>>> getLateComers(String day);
  Future<ApiResult<List<AdminAttendanceModel>>> getEarlyLeavers(String day);
  Future<ApiResult<void>> checkIn(SupervisorAttendanceCheckInRequestBody body);
  Future<ApiResult<void>> checkOut(
    SupervisorAttendanceCheckOutRequestBody body,
  );
}
