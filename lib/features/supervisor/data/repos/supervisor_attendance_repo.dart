import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';

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
