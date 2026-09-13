import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/core/services/local_notification_service.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/utils/app_date_formatter.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_in_use_case.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_out_use_case.dart';
import 'employee_attendance_state.dart';

class EmployeeAttendanceCubit extends Cubit<EmployeeAttendanceState> {
  EmployeeAttendanceCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.attendanceVerificationService,
    required this.localNotificationService,
  }) : super(const EmployeeAttendanceState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;
  final EmployeeCheckInUseCase checkInUseCase;
  final EmployeeCheckOutUseCase checkOutUseCase;
  final AttendanceVerificationService attendanceVerificationService;
  final LocalNotificationService localNotificationService;

  AdminAttendanceModel? todayAttendance;
  EmployeeModel? employeeProfile;

  bool hasClockIn(AdminAttendanceModel? attendance) =>
      _hasAttendanceTime(attendance?.clockInTime);

  bool hasClockOut(AdminAttendanceModel? attendance) =>
      _hasAttendanceTime(attendance?.clockOutTime);

  bool _hasAttendanceTime(String? rawTime) =>
      AppDateFormatter.formatTimeString(rawTime) != '--:--';

  String? selectedImageBase64;
  CustomerModel? selectedTarget;
  BranchModel? selectedBranch;
  LatLng? currentLocation;

  Future<void> loadBranches() async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId();
    var branchId = await sessionStorage.readBranchId();
    if (branchId == null && employeeId != null && employeeId.isNotEmpty) {
      final employeeResult = await attendanceRepo.getEmployeeById(employeeId);
      if (employeeResult case Success(:final data)) {
        branchId = data.branchId;
        if (branchId != null) {
          await sessionStorage.saveBranchId(branchId);
        }
      }
    }
    final result = branchId == null
        ? const ApiResult<List<BranchModel>>.failure(
            ApiFailure(messageKey: 'errors.branchUnavailable'),
          )
        : (await attendanceRepo.getBranchById(branchId)).when(
            success: (branch) => ApiResult.success([branch]),
            failure: ApiResult.failure,
          );
    switch (result) {
      case Success(:final data):
        emit(EmployeeAttendanceState.branchesLoaded(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> checkIn({
    required String area,
    String? customerId,
    String? locationLabel,
    LatLng? targetCenter,
    List<LatLng> targetPolygon = const [],
  }) async {
    emit(const EmployeeAttendanceState.loading());
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to check in',
      center: targetCenter,
      polygon: targetPolygon,
    );
    if (!verification.isAllowed) {
      emit(EmployeeAttendanceState.error(verification.messageKey!));
      return;
    }
    currentLocation = verification.location;
    final result = await checkInUseCase(
      area: area,
      customerId: customerId ?? selectedTarget?.id?.toString(),
      locationLabel: locationLabel,
      currentLocation: currentLocation,
      selectedImageBase64: selectedImageBase64,
    );

    switch (result) {
      case Success(:final data):
        todayAttendance = data;
        emit(EmployeeAttendanceState.checkInSuccess(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<LatLng?> refreshCurrentLocation() async {
    currentLocation = await attendanceVerificationService.locationService
        .getCurrentPosition();
    return currentLocation;
  }

  bool isWithinAttendanceArea({
    required LatLng point,
    LatLng? center,
    List<LatLng> polygon = const [],
  }) => attendanceVerificationService.isWithinArea(
    point: point,
    center: center,
    polygon: polygon,
  );

  Future<void> checkOut({
    LatLng? targetCenter,
    List<LatLng> targetPolygon = const [],
  }) async {
    emit(const EmployeeAttendanceState.loading());
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to check out',
      center: targetCenter,
      polygon: targetPolygon,
    );
    if (!verification.isAllowed) {
      emit(EmployeeAttendanceState.error(verification.messageKey!));
      return;
    }
    currentLocation = verification.location;
    final result = await checkOutUseCase(
      selectedImageBase64: selectedImageBase64,
    );

    switch (result) {
      case Success(:final data):
        todayAttendance = data;
        emit(EmployeeAttendanceState.checkOutSuccess(data));
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  List<AdminAttendanceModel> _allHistoryRecords = [];
  Set<String> selectedStatusFilters = {};
  String selectedDaysFilter = 'all';

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
    if (employeeId.isNotEmpty) {
      final profileResult = await attendanceRepo.getEmployeeById(employeeId);
      if (profileResult case Success(:final data)) {
        employeeProfile = data;
      }
    }
    final result = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
    );
    switch (result) {
      case Success(:final data):
        _allHistoryRecords = data;
        todayAttendance = _findTodayRecord(data);
        _applyFilters();
      case Failure(:final failure):
        emit(EmployeeAttendanceState.error(failure.messageKey));
    }
  }

  Future<void> scheduleReminders({
    required String attendanceTitle,
    required String attendanceBody,
    required String tasksTitle,
    required String tasksBody,
    required List<AdminTaskModel> tasks,
  }) async {
    final endTime = _parseTime(employeeProfile?.clockOutTime);
    if (endTime != null) {
      final now = DateTime.now();
      final checkout = DateTime(
        now.year,
        now.month,
        now.day,
        endTime.hour,
        endTime.minute,
      ).subtract(const Duration(hours: 1));
      await localNotificationService.scheduleDaily(
        id: LocalNotificationService.attendanceReminderId,
        title: attendanceTitle,
        body: attendanceBody,
        time: checkout,
      );
    }

    final activeTasks = tasks.where((task) {
      final status = task.status?.toLowerCase();
      return status != 'completed' && status != 'done';
    }).length;
    if (activeTasks == 0) {
      await localNotificationService.cancel(
        LocalNotificationService.tasksReminderId,
      );
      return;
    }
    await localNotificationService.scheduleDaily(
      id: LocalNotificationService.tasksReminderId,
      title: tasksTitle,
      body: tasksBody.replaceFirst('{count}', '$activeTasks'),
      time: DateTime(2000, 1, 1, 9),
    );
  }

  AdminAttendanceModel? _findTodayRecord(List<AdminAttendanceModel> records) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matches = records.where((record) {
      final date = _parseDate(record.attendanceDate);
      return date != null && DateTime(date.year, date.month, date.day) == today;
    }).toList();
    if (matches.isEmpty) return null;
    matches.sort((a, b) {
      final aTime = _parseDate(a.clockInTime) ?? DateTime(1900);
      final bTime = _parseDate(b.clockInTime) ?? DateTime(1900);
      return bTime.compareTo(aTime);
    });
    return matches.first;
  }

  DateTime? _parseTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final match = RegExp(r'^(\d{1,2}):(\d{2})').firstMatch(raw.trim());
    if (match == null) return null;
    return DateTime(
      2000,
      1,
      1,
      int.parse(match.group(1)!),
      int.parse(match.group(2)!),
    );
  }

  void toggleStatusFilter(String status) {
    if (selectedStatusFilters.contains(status)) {
      selectedStatusFilters.remove(status);
    } else {
      selectedStatusFilters.add(status);
    }
    _applyFilters();
  }

  void setDaysFilter(String daysFilter) {
    selectedDaysFilter = daysFilter;
    _applyFilters();
  }

  void resetFilters() {
    selectedStatusFilters.clear();
    selectedDaysFilter = 'all';
    _applyFilters();
  }

  void _applyFilters() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filtered = _allHistoryRecords.where((record) {
      // 1. Days Filter
      final recordDate = _parseDate(record.attendanceDate);
      if (recordDate != null) {
        final recordDay = DateTime(
          recordDate.year,
          recordDate.month,
          recordDate.day,
        );
        switch (selectedDaysFilter) {
          case 'today':
            if (!recordDay.isAtSameMomentAs(today)) return false;
          case 'last7':
            final start = today.subtract(const Duration(days: 7));
            if (recordDay.isBefore(start) || recordDay.isAfter(today)) {
              return false;
            }
          case 'last30':
            final start = today.subtract(const Duration(days: 30));
            if (recordDay.isBefore(start) || recordDay.isAfter(today)) {
              return false;
            }
          case 'all':
          default:
            break;
        }
      }

      // 2. Multi-Select Status Filter
      if (selectedStatusFilters.isEmpty) return true;

      final isLate = record.isLate == true;
      final isEarly = record.isEarly == true;
      final isAttended = !isLate && !isEarly;

      bool matches = false;
      if (selectedStatusFilters.contains('attended') && isAttended) {
        matches = true;
      }
      if (selectedStatusFilters.contains('late') && isLate) matches = true;
      if (selectedStatusFilters.contains('early') && isEarly) matches = true;

      return matches;
    }).toList();

    emit(EmployeeAttendanceState.historyLoaded(filtered));
  }

  DateTime? _parseDate(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      return DateTime.parse(raw);
    } catch (_) {
      try {
        final parts = raw.split('-');
        if (parts.length >= 3) {
          final year = int.parse(parts[0]);
          final month = int.parse(parts[1]);
          final dayStr = parts[2].split('T').first.split(' ').first;
          final day = int.parse(dayStr);
          return DateTime(year, month, day);
        }
      } catch (_) {}
      return null;
    }
  }

  void validateCircleLocation(LatLng targetCenter, double radiusMeters) {
    if (currentLocation == null) {
      emit(
        const EmployeeAttendanceState.areaValidationError(
          'Location unavailable',
        ),
      );
      return;
    }
    final distance = attendanceRepo.checkAccessibleAreaForCircle(
      targetCenter,
      currentLocation!,
    );
    if (distance <= radiusMeters) {
      emit(const EmployeeAttendanceState.areaValidationSuccess());
    } else {
      emit(
        const EmployeeAttendanceState.areaValidationError(
          'You are outside the required area boundary',
        ),
      );
    }
  }

  void validatePolygonLocation(List<LatLng> polygon) {
    if (currentLocation == null) {
      emit(
        const EmployeeAttendanceState.areaValidationError(
          'Location unavailable',
        ),
      );
      return;
    }
    final isInPolygon = attendanceRepo.checkAccessibleAreaForPolygon(
      currentLocation!,
      polygon,
    );
    if (isInPolygon) {
      emit(const EmployeeAttendanceState.areaValidationSuccess());
    } else {
      emit(
        const EmployeeAttendanceState.areaValidationError(
          'You are outside the required area boundary',
        ),
      );
    }
  }
}
