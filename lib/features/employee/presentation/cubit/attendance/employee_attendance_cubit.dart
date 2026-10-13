import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/utils/app_date_formatter.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
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
  }) : super(const EmployeeAttendanceState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;
  final EmployeeCheckInUseCase checkInUseCase;
  final EmployeeCheckOutUseCase checkOutUseCase;
  final AttendanceVerificationService attendanceVerificationService;

  AdminAttendanceModel? todayAttendance;
  EmployeeModel? employeeProfile;

  Future<EmployeeModel?> loadEmployeeProfile() async {
    final employeeId = await sessionStorage.readUserId();
    if (employeeId == null || employeeId.isEmpty) return null;
    final result = await attendanceRepo.getEmployeeById(employeeId);
    return result.when(
      success: (data) {
        employeeProfile = data;
        return data;
      },
      failure: (_) => null,
    );
  }

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
    int? branchId = await sessionStorage.readBranchId();
    if (branchId == null && employeeId != null && employeeId.isNotEmpty) {
      final employeeResult = await attendanceRepo.getEmployeeById(employeeId);
      final id = employeeResult.when(
        success: (data) => data.branchId,
        failure: (_) => null,
      );
      if (id != null) {
        branchId = id;
        await sessionStorage.saveBranchId(id);
      }
    }
    final ApiResult<List<BranchModel>> result;
    if (branchId != null) {
      final branchResult = await attendanceRepo.getBranchById(branchId);
      result = await branchResult.when(
        success: (data) async => ApiResult.success([data]),
        failure: (_) => attendanceRepo.getBranches(),
      );
    } else {
      result = await attendanceRepo.getBranches();
    }
    result.when(
      success: (data) => emit(EmployeeAttendanceState.branchesLoaded(data)),
      failure: (failure) => emit(EmployeeAttendanceState.error(failure.messageKey)),
    );
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

    result.when(
      success: (data) {
        todayAttendance = data;
        emit(EmployeeAttendanceState.checkInSuccess(data));
      },
      failure: (failure) =>
          emit(EmployeeAttendanceState.error(failure.messageKey)),
    );
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
      currentLocation: currentLocation,
    );

    result.when(
      success: (data) {
        todayAttendance = data;
        emit(EmployeeAttendanceState.checkOutSuccess(data));
      },
      failure: (failure) =>
          emit(EmployeeAttendanceState.error(failure.messageKey)),
    );
  }

  List<AdminAttendanceModel> _allHistoryRecords = [];
  Set<String> selectedStatusFilters = {};
  String selectedDaysFilter = 'all';

  Future<void> loadCustomersByType(String type) async {
    emit(const EmployeeAttendanceState.loading());
    final result = await attendanceRepo.getCustomersByType(type);
    result.when(
      success: (data) {
        if (data.isNotEmpty) {
          selectedTarget = data.first;
        }
        emit(EmployeeAttendanceState.targetsLoaded(data));
      },
      failure: (failure) =>
          emit(EmployeeAttendanceState.error(failure.messageKey)),
    );
  }

  Future<void> loadAttendanceHistory() async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    if (employeeId.isNotEmpty) {
      final profileResult = await attendanceRepo.getEmployeeById(employeeId);
      profileResult.when(
        success: (data) => employeeProfile = data,
        failure: (_) {},
      );
    }
    final result = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
    );
    result.when(
      success: (data) {
        _allHistoryRecords = data;
        todayAttendance = _findTodayRecord(data);
        _applyFilters();
      },
      failure: (_) {
        // Fallback to empty list instead of showing errors.unknown
        _allHistoryRecords = [];
        todayAttendance = null;
        _applyFilters();
      },
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
      if (selectedStatusFilters.contains('early_check_in') && !isLate) {
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
