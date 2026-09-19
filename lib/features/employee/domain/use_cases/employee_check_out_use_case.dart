import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_out_request_body.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EmployeeCheckOutUseCase {
  EmployeeCheckOutUseCase({
    required this.attendanceRepo,
    required this.sessionStorage,
  });

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  Future<ApiResult<AdminAttendanceModel>> call({
    String? selectedImageBase64,
    LatLng? currentLocation,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeCheckOutRequestBody(
      employeeId: employeeId,
      employeeImage: selectedImageBase64,
      location: currentLocation == null
          ? null
          : '${currentLocation.latitude},${currentLocation.longitude}',
      coordinates: currentLocation == null
          ? null
          : [
              AttendanceCoordinate(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude,
              ),
            ],
    );

    return attendanceRepo.checkOutWithoutPlan(requestBody);
  }
}
