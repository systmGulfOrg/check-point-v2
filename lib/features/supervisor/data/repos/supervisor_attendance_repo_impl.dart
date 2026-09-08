import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure_mapper.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/supervisor/data/apis/supervisor_api_service.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';
import 'supervisor_attendance_repo.dart';

class SupervisorAttendanceRepoImpl implements SupervisorAttendanceRepo {
  SupervisorAttendanceRepoImpl({
    required this.api,
    required this.sessionStorage,
  });
  final SupervisorApiService api;
  final AuthSessionStorage sessionStorage;

  Future<int?> _resolveDepartmentId(int? departmentId) async {
    if (departmentId != null) return departmentId;
    final cached = await sessionStorage.readDepartmentId();
    if (cached != null) return cached;
    final userId = await sessionStorage.readUserId();
    if (userId != null && userId.isNotEmpty) {
      try {
        final empRes = await api.getEmployeeById(userId);
        final id = empRes.value?.departmentId;
        if (id != null) {
          await sessionStorage.saveDepartmentId(id);
          return id;
        }
      } catch (_) {}
    }
    return null;
  }

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendance({
    int? departmentId,
    String? attendanceDate,
  }) async {
    try {
      final deptId = await _resolveDepartmentId(departmentId);
      final response = deptId != null
          ? await api.getAttendanceByDepartment(
              deptId,
              attendanceDate: attendanceDate,
            )
          : await api.getAttendance();
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getLateComers(
    String day,
  ) async {
    try {
      final response = await api.getLateComers(day);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getEarlyLeavers(
    String day,
  ) async {
    try {
      final response = await api.getEarlyLeavers(day);
      return ApiResult.success(response.value?.list ?? []);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> checkIn(
    SupervisorAttendanceCheckInRequestBody body,
  ) async {
    try {
      await api.checkIn(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }

  @override
  Future<ApiResult<void>> checkOut(
    SupervisorAttendanceCheckOutRequestBody body,
  ) async {
    try {
      await api.checkOut(body);
      return const ApiResult.success(null);
    } catch (e) {
      return ApiResult.failure(ApiFailureMapper.map(e));
    }
  }
}
