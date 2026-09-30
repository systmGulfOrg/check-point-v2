import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_attendance_repo.dart';
import 'supervisor_attendance_state.dart';

class SupervisorAttendanceCubit extends Cubit<SupervisorAttendanceState> {
  SupervisorAttendanceCubit({
    required this.attendanceRepo,
    required this.attendanceVerificationService,
  }) : super(const SupervisorAttendanceState.initial());

  final SupervisorAttendanceRepo attendanceRepo;
  final AttendanceVerificationService attendanceVerificationService;

  List<AdminAttendanceModel> _allAttendance = const [];
  List<AdminAttendanceModel> _lateComers = const [];
  List<AdminAttendanceModel> _earlyLeavers = const [];
  int _selectedFilterIndex = 0;

  List<AdminAttendanceModel> get allAttendance => _allAttendance;
  List<AdminAttendanceModel> get lateComers => _lateComers;
  List<AdminAttendanceModel> get earlyLeavers => _earlyLeavers;
  int get selectedFilterIndex => _selectedFilterIndex;

  Future<void> loadAttendance({int? departmentId, String? date}) async {
    emit(const SupervisorAttendanceState.loading());
    final day = date ?? DateTime.now().toIso8601String().substring(0, 10);

    final attResult = await attendanceRepo.getAttendance(
      departmentId: departmentId,
      attendanceDate: day,
    );
    final lateResult = await attendanceRepo.getLateComers(day);
    final earlyResult = await attendanceRepo.getEarlyLeavers(day);

    _allAttendance = attResult.when(
      success: (data) => data,
      failure: (_) => _allAttendance,
    );

    _lateComers = lateResult.when(
      success: (data) => data,
      failure: (_) => _lateComers,
    );

    _earlyLeavers = earlyResult.when(
      success: (data) => data,
      failure: (_) => _earlyLeavers,
    );

    emit(
      SupervisorAttendanceState.success(
        attendance: _allAttendance,
        lateComers: _lateComers,
        earlyLeavers: _earlyLeavers,
        selectedFilterIndex: _selectedFilterIndex,
      ),
    );
  }

  void setFilter(int index) {
    _selectedFilterIndex = index;
    emit(
      SupervisorAttendanceState.success(
        attendance: _allAttendance,
        lateComers: _lateComers,
        earlyLeavers: _earlyLeavers,
        selectedFilterIndex: _selectedFilterIndex,
      ),
    );
  }

  Future<bool> checkIn(SupervisorAttendanceCheckInRequestBody body) async {
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to record attendance',
    );
    if (!verification.isAllowed) {
      emit(SupervisorAttendanceState.error(verification.messageKey!));
      return false;
    }
    body = SupervisorAttendanceCheckInRequestBody(
      employeeIdd: body.employeeIdd,
      latitude: verification.location!.latitude,
      longitude: verification.location!.longitude,
      area: body.area,
      clockInTime: body.clockInTime,
      attendanceDate: body.attendanceDate,
      employeeImage: body.employeeImage,
      customerId: body.customerId,
    );
    final result = await attendanceRepo.checkIn(body);
    return result.when(
      success: (_) async {
        await loadAttendance();
        return true;
      },
      failure: (failure) {
        emit(SupervisorAttendanceState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> checkOut(SupervisorAttendanceCheckOutRequestBody body) async {
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to record attendance',
    );
    if (!verification.isAllowed) {
      emit(SupervisorAttendanceState.error(verification.messageKey!));
      return false;
    }
    final result = await attendanceRepo.checkOut(body);
    return result.when(
      success: (_) async {
        await loadAttendance();
        return true;
      },
      failure: (failure) {
        emit(SupervisorAttendanceState.error(failure.messageKey));
        return false;
      },
    );
  }
}
