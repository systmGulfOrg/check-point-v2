import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';

class EmployeeCheckOutUseCase {
  EmployeeCheckOutUseCase({
    required this.attendanceRepo,
    required this.sessionStorage,
  });

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  Future<ApiResult<AdminAttendanceModel>> call({
    String? selectedImageBase64,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeCheckOutRequestBody(
      employeeId: employeeId,
      employeeImage: selectedImageBase64,
    );

    return attendanceRepo.checkOutWithoutPlan(requestBody);
  }
}
