import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/auth/auth_session_storage.dart';
import '../../../../core/network/api_result.dart';
import '../../../admin/data/models/customer_response_model.dart';
import '../../data/models/employee_check_in_request_body.dart';
import '../../data/models/employee_check_out_request_body.dart';
import '../../data/repos/employee_attendance_repo.dart';
import 'employee_attendance_state.dart';

class EmployeeAttendanceCubit extends Cubit<EmployeeAttendanceState> {
  EmployeeAttendanceCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
  }) : super(const EmployeeAttendanceState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;

  String? selectedImageBase64;
  CustomerModel? selectedTarget;
  LatLng? currentLocation;

  Future<void> checkIn({
    required String area,
    String? customerId,
    String? locationLabel,
  }) async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeCheckInRequestBody(
      employeeIdd: employeeId,
      area: area,
      customerId: customerId ?? selectedTarget?.id?.toString(),
      location: locationLabel ?? (currentLocation != null
          ? '${currentLocation!.latitude},${currentLocation!.longitude}'
          : area),
      coordinates: currentLocation != null
          ? [
              AttendanceCoordinate(
                latitude: currentLocation!.latitude,
                longitude: currentLocation!.longitude,
              ),
            ]
          : null,
      employeeImage: selectedImageBase64,
    );

    final result = customerId != null || selectedTarget != null
        ? await attendanceRepo.checkIn(requestBody)
        : await attendanceRepo.checkInWithoutPlan(requestBody);

    switch (result) {
      case Success(:final data):
        emit(EmployeeAttendanceState.checkInSuccess(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> checkOut() async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final requestBody = EmployeeCheckOutRequestBody(
      employeeId: employeeId,
      employeeImage: selectedImageBase64,
    );

    final result = await attendanceRepo.checkOutWithoutPlan(requestBody);

    switch (result) {
      case Success(:final data):
        emit(EmployeeAttendanceState.checkOutSuccess(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> loadCustomersByType(String type) async {
    emit(const EmployeeAttendanceState.loading());
    final result = await attendanceRepo.getCustomersByType(type);
    switch (result) {
      case Success(:final data):
        if (data.isNotEmpty) {
          selectedTarget = data.first;
        }
        emit(EmployeeAttendanceState.targetsLoaded(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> loadAttendanceHistory() async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final result = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
    );
    switch (result) {
      case Success(:final data):
        emit(EmployeeAttendanceState.historyLoaded(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  void validateCircleLocation(LatLng targetCenter, double radiusMeters) {
    if (currentLocation == null) {
      emit(const EmployeeAttendanceState.areaValidationError('Location unavailable'));
      return;
    }
    final distance = attendanceRepo.checkAccessibleAreaForCircle(
      targetCenter,
      currentLocation!,
    );
    if (distance <= radiusMeters) {
      emit(const EmployeeAttendanceState.areaValidationSuccess());
    } else {
      emit(const EmployeeAttendanceState.areaValidationError(
        'You are outside the required area boundary',
      ));
    }
  }

  void validatePolygonLocation(List<LatLng> polygon) {
    if (currentLocation == null) {
      emit(const EmployeeAttendanceState.areaValidationError('Location unavailable'));
      return;
    }
    final isInPolygon = attendanceRepo.checkAccessibleAreaForPolygon(
      currentLocation!,
      polygon,
    );
    if (isInPolygon) {
      emit(const EmployeeAttendanceState.areaValidationSuccess());
    } else {
      emit(const EmployeeAttendanceState.areaValidationError(
        'You are outside the required area boundary',
      ));
    }
  }
}
