import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';

class EmployeeCheckInUseCase {
  EmployeeCheckInUseCase({
    required this.attendanceRepo,
    required this.sessionStorage,
  }); 

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  Future<ApiResult<AdminAttendanceModel>> call({
    required String area,
    String? customerId,
    String? locationLabel,
    LatLng? currentLocation,
    String? selectedImageBase64,
  }) async {
    final employeeId = await sessionStorage.readEmployeeId() ?? '';
    final apiArea = switch (area) {
      'Branch' => 'Office',
      'Customer' => 'Customer',
      'Site' => 'Site',
      'Remote' => 'Remote',
      _ => 'Office',
    };
    final requestBody = EmployeeCheckInRequestBody(
      employeeIdd: employeeId,
      area: apiArea,
      customerId: customerId,
      location:
          locationLabel ??
          (currentLocation != null
              ? '${currentLocation.latitude},${currentLocation.longitude}'
              : apiArea),
      coordinates: currentLocation != null
          ? [
              AttendanceCoordinate(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude,
              ),
            ]
          : null,
      employeeImage: selectedImageBase64,
    );
    

    if (customerId != null) {
      return attendanceRepo.checkIn(requestBody);
    } else {
      return attendanceRepo.checkInWithoutPlan(requestBody);
    }
  }
}
