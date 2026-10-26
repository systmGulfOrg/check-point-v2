import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:drift/drift.dart' show OrderingTerm;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/connectivity/connectivity_cubit.dart';
import 'package:check_point_v2/core/database/app_database.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/core/services/attendance_sync_service.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/core/services/device_clock_service.dart';
import 'package:check_point_v2/core/utils/app_date_formatter.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_in_use_case.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_check_out_use_case.dart';
import 'package:check_point_v2/features/overtime/data/models/overtime_request_model.dart';
import 'package:check_point_v2/features/overtime/data/repos/overtime_repo.dart';
import 'employee_attendance_state.dart';

class EmployeeAttendanceCubit extends SafeCubit<EmployeeAttendanceState> {
  EmployeeAttendanceCubit({
    required this.attendanceRepo,
    required this.sessionStorage,
    required this.checkInUseCase,
    required this.checkOutUseCase,
    required this.attendanceVerificationService,
    required this.overtimeRepo,
  }) : super(const EmployeeAttendanceState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AuthSessionStorage sessionStorage;
  final EmployeeCheckInUseCase checkInUseCase;
  final EmployeeCheckOutUseCase checkOutUseCase;
  final AttendanceVerificationService attendanceVerificationService;
  final OvertimeRepo overtimeRepo;

  AdminAttendanceModel? todayAttendance;
  EmployeeModel? employeeProfile;
  List<OvertimeRequestModel> todayOvertimeRequests = [];

  Future<EmployeeModel?> loadEmployeeProfile() async {
    final employeeId = await sessionStorage.readUserId();
    if (employeeId == null || employeeId.isEmpty) return null;
    final result = await attendanceRepo.getEmployeeById(employeeId);
    return result.when(
      success: (data) {
        employeeProfile = data;
        if (data.branchId != null) {
          sessionStorage.saveBranchId(data.branchId!);
        }
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
    if (branchId == null && employeeProfile?.branchId != null) {
      branchId = employeeProfile!.branchId;
    }
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
      success: (data) => safeEmit(EmployeeAttendanceState.branchesLoaded(data)),
      failure: (failure) {
        // Offline resilience: if branch cache is missing, construct fallback from profile
        final fallbackName = employeeProfile?.branchName ?? 'Office';
        final fallbackBranch = BranchModel(
          id: branchId ?? employeeProfile?.branchId,
          name: fallbackName,
          location: fallbackName,
          coordinates: const [],
        );
        safeEmit(EmployeeAttendanceState.branchesLoaded([fallbackBranch]));
      },
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
    final isOnline = sl.isRegistered<ConnectivityCubit>()
        ? sl<ConnectivityCubit>().state.isOnline
        : true;
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to check in',
      center: targetCenter,
      polygon: targetPolygon,
      requireLocation: area != 'Remote',
      requirePlayIntegrity: isOnline,
    );
    if (!verification.isAllowed) {
      safeEmit(EmployeeAttendanceState.error(verification.messageKey!));
      return;
    }
    currentLocation = verification.location;

    if (!isOnline) {
      final clockSnapshot = await sl<DeviceClockService>().getClockSnapshot();
      final db = sl<AppDatabase>();
      final latestAnchor = await (db.select(db.timeAnchors)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])
            ..limit(1))
          .getSingleOrNull();

      await sl<AttendanceSyncService>().enqueue(
        type: 'in',
        wallClock: clockSnapshot.wallClock,
        monotonicMs: clockSnapshot.monotonicMs,
        bootId: clockSnapshot.bootId,
        anchorServerTime: latestAnchor?.serverTime,
        anchorMonotonicMs: latestAnchor?.monotonicMs.toInt(),
        anchorBootId: latestAnchor?.bootId,
        latitude: currentLocation?.latitude,
        longitude: currentLocation?.longitude,
        accuracyM: verification.sample?.accuracy,
        mockLocationDetected:
            verification.sample?.isMockFromNative ?? false,
        area: area,
        customerId: customerId ?? selectedTarget?.id?.toString(),
      );

      final now = clockSnapshot.wallClock.toLocal();
      final localDateStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final localTimeStr =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      final optimisticModel = AdminAttendanceModel(
        clockInTime: localTimeStr,
        attendanceDate: localDateStr,
        area: area,
        customerId: customerId ?? selectedTarget?.id?.toString(),
        status: 'Present',
      );
      todayAttendance = optimisticModel;
      safeEmit(EmployeeAttendanceState.checkInSuccess(optimisticModel));
      return;
    }

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
        safeEmit(EmployeeAttendanceState.checkInSuccess(data));
      },
      failure: (failure) =>
          safeEmit(EmployeeAttendanceState.error(failure.messageKey)),
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
    final isOnline = sl.isRegistered<ConnectivityCubit>()
        ? sl<ConnectivityCubit>().state.isOnline
        : true;
    final verification = await attendanceVerificationService.verify(
      biometricReason: 'Verify your identity to check out',
      center: targetCenter,
      polygon: targetPolygon,
      requireLocation:
          todayAttendance?.area != 'Remote' &&
          employeeProfile?.todayWorkMode != 'remote',
      requirePlayIntegrity: isOnline,
    );
    if (!verification.isAllowed) {
      safeEmit(EmployeeAttendanceState.error(verification.messageKey!));
      return;
    }
    currentLocation = verification.location;

    if (!isOnline) {
      final clockSnapshot = await sl<DeviceClockService>().getClockSnapshot();
      final db = sl<AppDatabase>();
      final latestAnchor = await (db.select(db.timeAnchors)
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.id)])
            ..limit(1))
          .getSingleOrNull();

      await sl<AttendanceSyncService>().enqueue(
        type: 'out',
        wallClock: clockSnapshot.wallClock,
        monotonicMs: clockSnapshot.monotonicMs,
        bootId: clockSnapshot.bootId,
        anchorServerTime: latestAnchor?.serverTime,
        anchorMonotonicMs: latestAnchor?.monotonicMs.toInt(),
        anchorBootId: latestAnchor?.bootId,
        latitude: currentLocation?.latitude,
        longitude: currentLocation?.longitude,
        accuracyM: verification.sample?.accuracy,
        mockLocationDetected:
            verification.sample?.isMockFromNative ?? false,
      );

      final now = clockSnapshot.wallClock.toLocal();
      final localDateStr =
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
      final localTimeStr =
          '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}';

      final optimisticModel = AdminAttendanceModel(
        id: todayAttendance?.id,
        employeeId: todayAttendance?.employeeId,
        employeeName: todayAttendance?.employeeName,
        clockInTime: todayAttendance?.clockInTime,
        clockOutTime: localTimeStr,
        attendanceDate: todayAttendance?.attendanceDate ?? localDateStr,
        area: todayAttendance?.area,
        status: 'Present',
      );
      todayAttendance = optimisticModel;
      safeEmit(EmployeeAttendanceState.checkOutSuccess(optimisticModel));
      return;
    }

    final result = await checkOutUseCase(
      selectedImageBase64: selectedImageBase64,
      currentLocation: currentLocation,
    );

    result.when(
      success: (data) {
        todayAttendance = data;
        safeEmit(EmployeeAttendanceState.checkOutSuccess(data));
      },
      failure: (failure) =>
          safeEmit(EmployeeAttendanceState.error(failure.messageKey)),
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
        safeEmit(EmployeeAttendanceState.targetsLoaded(data));
      },
      failure: (failure) =>
          safeEmit(EmployeeAttendanceState.error(failure.messageKey)),
    );
  }

  Future<void> loadAttendanceHistory() async {
    emit(const EmployeeAttendanceState.loading());
    final employeeId = await sessionStorage.readUserId() ?? '';
    final isOnline = sl.isRegistered<ConnectivityCubit>()
        ? sl<ConnectivityCubit>().state.isOnline
        : true;

    // If online, flush any pending offline attendance first so server creates the records
    if (isOnline) {
      try {
        await sl<AttendanceSyncService>().syncPending();
      } catch (_) {}
    }

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
    final overtimeResult = await overtimeRepo.getRequests();
    overtimeResult.when(
      success: (requests) => todayOvertimeRequests = requests,
      failure: (_) => todayOvertimeRequests = [],
    );
    result.when(
      success: (data) {
        _allHistoryRecords = data;
        todayAttendance = _findTodayRecord(data);
      },
      failure: (_) {
        // Keep todayAttendance if already set optimistically or offline
      },
    );

    // Overlay pending offline attendance records from Drift SQLite queue
    try {
      final db = sl<AppDatabase>();
      final pendingList = await (db.select(db.pendingAttendanceTable)
            ..where((tbl) => tbl.status.equals('queued'))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.wallClock)]))
          .get();
      if (pendingList.isNotEmpty) {
        final pendingIn = pendingList.where((p) => p.type == 'in').lastOrNull;
        final pendingOut = pendingList.where((p) => p.type == 'out').lastOrNull;
        if (pendingIn != null || pendingOut != null) {
          final now = DateTime.now();
          final todayDateStr =
              '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
          final existing = todayAttendance ??
              AdminAttendanceModel(
                attendanceDate: todayDateStr,
                employeeName: employeeProfile?.name,
              );
          final inTime = pendingIn != null
              ? '${pendingIn.wallClock.toLocal().hour.toString().padLeft(2, '0')}:${pendingIn.wallClock.toLocal().minute.toString().padLeft(2, '0')}:${pendingIn.wallClock.toLocal().second.toString().padLeft(2, '0')}'
              : existing.clockInTime;
          final outTime = pendingOut != null
              ? '${pendingOut.wallClock.toLocal().hour.toString().padLeft(2, '0')}:${pendingOut.wallClock.toLocal().minute.toString().padLeft(2, '0')}:${pendingOut.wallClock.toLocal().second.toString().padLeft(2, '0')}'
              : existing.clockOutTime;

          todayAttendance = AdminAttendanceModel(
            id: existing.id,
            employeeId: existing.employeeId,
            employeeName: existing.employeeName,
            attendanceDate: existing.attendanceDate ?? todayDateStr,
            clockInTime: inTime,
            clockOutTime: outTime,
            area: pendingIn?.area ?? existing.area,
            status: 'Present',
          );
        }
      }
    } catch (_) {}

    _applyFilters();
  }

  int get todayOvertimeMinutes {
    final now = DateTime.now();
    final todayStr =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    return todayOvertimeRequests
        .where(
          (r) =>
              r.requestDate.startsWith(todayStr) &&
              r.status.toLowerCase() != 'rejected',
        )
        .fold(0, (sum, r) => sum + r.durationMinutes);
  }

  String? get todayWorkedHoursWithOvertime {
    final raw = todayAttendance?.dayHours;
    var baseMinutes = 0;
    if (raw != null && raw.trim().isNotEmpty && raw != 'null') {
      if (raw.contains(':')) {
        final parts = raw.split(':');
        final hours = int.tryParse(parts[0]) ?? 0;
        final mins = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;
        baseMinutes = hours * 60 + mins;
      } else {
        final numValue = double.tryParse(raw);
        if (numValue != null) {
          baseMinutes = (numValue * 60).round();
        }
      }
    } else if (todayAttendance?.clockInTime != null) {
      final inTime = _parseDate(todayAttendance!.clockInTime);
      if (inTime != null) {
        final outTime =
            _parseDate(todayAttendance!.clockOutTime) ?? DateTime.now();
        final diff = outTime.difference(inTime).inMinutes;
        if (diff > 0) baseMinutes = diff;
      }
    }

    final overtime = todayOvertimeMinutes;
    final totalMinutes = baseMinutes + overtime;
    if (totalMinutes <= 0) {
      return raw;
    }

    final hours = totalMinutes ~/ 60;
    final mins = totalMinutes % 60;
    if (hours > 0 && mins > 0) {
      return '${hours}h ${mins}m';
    } else if (hours > 0) {
      return '${hours}h';
    } else {
      return '${mins}m';
    }
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
    if (isClosed) return;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filtered = _allHistoryRecords.where((record) {
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
          'errors.locationUnavailable',
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
          'errors.outsideAttendanceArea',
        ),
      );
    }
  }

  void validatePolygonLocation(List<LatLng> polygon) {
    if (currentLocation == null) {
      emit(
        const EmployeeAttendanceState.areaValidationError(
          'errors.locationUnavailable',
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
          'errors.outsideAttendanceArea',
        ),
      );
    }
  }
}
