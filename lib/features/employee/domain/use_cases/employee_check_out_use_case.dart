import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/employee/data/models/attendance/employee_check_in_request_body.dart';
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
    LatLng? currentLocation,
    LocationSample? sample,
  }) async {
    final employeeId = await sessionStorage.readUserId() ?? '';

    String? deviceUuid;
    try {
      if (sl.isRegistered<DeviceIdentityProvider>()) {
        deviceUuid = sl<DeviceIdentityProvider>().mobileId;
      }
    } catch (_) {}

    final nowIso = DateTime.now().toUtc().toIso8601String();

    final requestBody = EmployeeCheckOutRequestBody(
      employeeId: employeeId,
      employeeImage: selectedImageBase64,
      deviceUuid: deviceUuid,
      capturedWallClock: nowIso,
      mockLocationDetected: sample?.isMockFromNative,
      location: currentLocation == null
          ? null
          : '${currentLocation.latitude},${currentLocation.longitude}',
      coordinates: currentLocation == null
          ? null
          : [
              AttendanceCoordinate(
                latitude: currentLocation.latitude,
                longitude: currentLocation.longitude,
                accuracyM: sample?.accuracy,
                provider: sample?.provider,
                speed: sample?.speed,
                isMock: sample?.isMockFromNative,
                capturedWallClock: nowIso,
                kind: 'out',
              ),
            ],
    );

    return attendanceRepo.checkOutWithoutPlan(requestBody);
  }
}
