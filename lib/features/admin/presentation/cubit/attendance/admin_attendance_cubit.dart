import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_attendance_repo.dart';
import 'admin_attendance_state.dart';

enum AdminAttendanceDateFilter {
  today,
  last30Days,
  last90Days,
  last180Days,
  custom,
  all,
}

class AdminAttendanceCubit extends SafeCubit<AdminAttendanceState> {
  AdminAttendanceCubit({required this.attendanceRepo})
    : super(const AdminAttendanceState.initial());

  final AdminAttendanceRepo attendanceRepo;

  List<AdminAttendanceModel> _allRecords = [];
  List<EmployeeModel> _employees = [];
  AdminAttendanceDateFilter _selectedDateFilter =
      AdminAttendanceDateFilter.today;
  DateTime? _customStartDate;
  DateTime? _customEndDate;
  String _searchQuery = '';
  String? _selectedEmployeeId;
  int? _selectedDepartmentId;
  String _selectedStatus = 'all';
  Map<String, int?> _employeeDepartmentById = const {};
  bool _isLoadingAttendance = false;

  AdminAttendanceDateFilter get selectedDateFilter => _selectedDateFilter;
  DateTime? get customStartDate => _customStartDate;
  DateTime? get customEndDate => _customEndDate;
  String get searchQuery => _searchQuery;
  String? get selectedEmployeeId => _selectedEmployeeId;
  int? get selectedDepartmentId => _selectedDepartmentId;
  String get selectedStatus => _selectedStatus;
  List<EmployeeModel> get employees => _employees;

  List<AdminAttendanceModel> get todayRecords {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return _allRecords.where((record) {
      final recordDate = _parseDate(record.attendanceDate);
      if (recordDate == null) return false;
      final recordDay = DateTime(
        recordDate.year,
        recordDate.month,
        recordDate.day,
      );
      return recordDay.isAtSameMomentAs(today);
    }).toList();
  }

  List<AdminAttendanceModel> get todayPresentRecords {
    return todayRecords.where((r) {
      final hasClockIn = _hasClockIn(r);
      final isNotAbsent = r.status?.toLowerCase() != 'absent';
      return hasClockIn && isNotAbsent;
    }).toList();
  }

  List<({int present, int late, int absent})> get weeklyAttendanceSummary {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    return List.generate(7, (index) {
      final day = weekStart.add(Duration(days: index));
      final records = _allRecords.where((record) {
        final recordDate = _parseDate(record.attendanceDate);
        return recordDate != null &&
            recordDate.year == day.year &&
            recordDate.month == day.month &&
            recordDate.day == day.day;
      });

      return (
        present: records
            .where(
              (record) =>
                  _hasClockIn(record) &&
                  record.isLate != true &&
                  record.status?.toLowerCase() != 'absent',
            )
            .length,
        late: records
            .where(
              (record) =>
                  _hasClockIn(record) &&
                  record.isLate == true &&
                  record.status?.toLowerCase() != 'absent',
            )
            .length,
        absent: records
            .where((record) => record.status?.toLowerCase() == 'absent')
            .length,
      );
    });
  }

  bool _hasClockIn(AdminAttendanceModel record) {
    final clockInTime = record.clockInTime;
    return clockInTime != null &&
        clockInTime.trim().isNotEmpty &&
        clockInTime != '--:--' &&
        !clockInTime.startsWith('00:00');
  }

  bool get isAttendanceLoaded => state.maybeWhen(
    success: (_) => true,
    actionSuccess: (_) => true,
    orElse: () => false,
  );

  List<EmployeeModel> get absentEmployeesToday => getAbsentEmployees();

  List<EmployeeModel> getPresentEmployees([List<EmployeeModel>? employeeList]) {
    if (!isAttendanceLoaded) return const [];

    final employeesToUse = employeeList != null && employeeList.isNotEmpty
        ? employeeList
        : _employees;
    final presentIds = <String>{
      for (final record in todayPresentRecords)
        if (record.employeeId != null && record.employeeId!.isNotEmpty)
          record.employeeId!,
    };
    final presentNames = <String>{
      for (final record in todayPresentRecords)
        if (record.employeeName != null &&
            record.employeeName!.trim().isNotEmpty)
          record.employeeName!.trim().toLowerCase(),
    };

    return employeesToUse.where((employee) {
      final name = (employee.name ?? employee.userName ?? '')
          .trim()
          .toLowerCase();
      return (employee.id != null && presentIds.contains(employee.id)) ||
          (name.isNotEmpty && presentNames.contains(name));
    }).toList();
  }

  List<EmployeeModel> getOnLeaveEmployees(
    List<EmployeeModel> employeeList,
    List<AdminLeaveRequestModel> leaveRequests,
  ) {
    final onLeaveIds = employeeIdsOnLeave(leaveRequests, DateTime.now());
    return employeeList
        .where(
          (employee) => employee.id != null && onLeaveIds.contains(employee.id),
        )
        .toList();
  }

  /// Employees who have not clocked in yet today and are not on leave.
  /// Split into "late" (shift hasn't ended yet) and "absent" (shift ended).
  List<EmployeeModel> _getNotClockedInEmployees([
    List<EmployeeModel>? employeeList,
    List<AdminLeaveRequestModel>? leaveRequests,
  ]) {
    if (!isAttendanceLoaded) {
      return const [];
    }

    final employeesToUse = employeeList != null && employeeList.isNotEmpty
        ? employeeList
        : _employees;
    final presentIds = <String>{};
    final presentNames = <String>{};

    for (final r in todayPresentRecords) {
      if (r.employeeId != null && r.employeeId!.isNotEmpty) {
        presentIds.add(r.employeeId!);
      }
      if (r.employeeName != null && r.employeeName!.trim().isNotEmpty) {
        presentNames.add(r.employeeName!.trim().toLowerCase());
      }
    }

    final onLeaveIds = leaveRequests == null
        ? const <String>{}
        : employeeIdsOnLeave(leaveRequests, DateTime.now());

    return employeesToUse.where((emp) {
      final id = emp.id;
      final name = (emp.name ?? emp.userName ?? '').trim().toLowerCase();
      if (id != null && id.isNotEmpty && presentIds.contains(id)) {
        return false;
      }
      if (name.isNotEmpty && presentNames.contains(name)) {
        return false;
      }
      if (id != null && onLeaveIds.contains(id)) {
        return false;
      }
      if (emp.todayIsWorkingDay == false) {
        return false;
      }
      return true;
    }).toList();
  }

  bool _hasShiftEnded(EmployeeModel employee) {
    final end = _parseTodayTime(employee.todayWorkEnd);
    if (end == null) return false;
    return DateTime.now().isAfter(end);
  }

  DateTime? _parseTodayTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    final parts = raw.trim().split(':');
    if (parts.length < 2) return null;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return null;
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  /// Employees who haven't clocked in yet but whose shift is still ongoing.
  List<EmployeeModel> getLateEmployees([
    List<EmployeeModel>? employeeList,
    List<AdminLeaveRequestModel>? leaveRequests,
  ]) {
    return _getNotClockedInEmployees(
      employeeList,
      leaveRequests,
    ).where((emp) => !_hasShiftEnded(emp)).toList();
  }

  /// Employees who didn't clock in and whose shift has already ended.
  List<EmployeeModel> getAbsentEmployees([
    List<EmployeeModel>? employeeList,
    List<AdminLeaveRequestModel>? leaveRequests,
  ]) {
    return _getNotClockedInEmployees(
      employeeList,
      leaveRequests,
    ).where(_hasShiftEnded).toList();
  }

  int get todayPresentCount =>
      isAttendanceLoaded ? todayPresentRecords.length : 0;
  int get todayAbsentCount => absentEmployeesToday.length;
  int get todayLateCount => getLateEmployees().length;

  void setEmployeeDirectory(List<EmployeeModel> employees) {
    _employees = employees;
    _employeeDepartmentById = {
      for (final employee in employees)
        if (employee.id != null) employee.id!: employee.departmentId,
    };
    if (!_isLoadingAttendance) _emitFiltered();
  }

  void setEmployeeFilter(String? employeeId) {
    _selectedEmployeeId = employeeId;
    _emitFiltered();
  }

  void setDepartmentFilter(int? departmentId) {
    _selectedDepartmentId = departmentId;
    _emitFiltered();
  }

  void setStatusFilter(String status) {
    _selectedStatus = status;
    _emitFiltered();
  }

  void clearAdvancedFilters() {
    _selectedEmployeeId = null;
    _selectedDepartmentId = null;
    _selectedStatus = 'all';
    _emitFiltered();
  }

  Future<void> loadAttendance() async {
    _isLoadingAttendance = true;
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.getAdminAttendance();
    result.when(
      success: (data) {
        _allRecords = data;
        _isLoadingAttendance = false;
        _emitFiltered();
      },
      failure: (failure) {
        _isLoadingAttendance = false;
        safeEmit(AdminAttendanceState.error(failure.messageKey));
      },
    );
  }

  Future<void> setDateFilter(
    AdminAttendanceDateFilter filter, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    _selectedDateFilter = filter;
    _customStartDate = startDate;
    _customEndDate = endDate;
    emit(const AdminAttendanceState.loading());
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _emitFiltered();
  }

  void search(String query) {
    _searchQuery = query.trim().toLowerCase();
    _emitFiltered();
  }

  void _emitFiltered() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final filtered = _allRecords.where((record) {
      if (_searchQuery.isNotEmpty) {
        final name = (record.employeeName ?? '').toLowerCase();
        final area = (record.area ?? '').toLowerCase();
        final date = (record.attendanceDate ?? '').toLowerCase();
        if (!name.contains(_searchQuery) &&
            !area.contains(_searchQuery) &&
            !date.contains(_searchQuery)) {
          return false;
        }
      }

      if (_selectedEmployeeId != null &&
          record.employeeId != _selectedEmployeeId) {
        return false;
      }

      if (_selectedDepartmentId != null &&
          _employeeDepartmentById[record.employeeId] != _selectedDepartmentId) {
        return false;
      }

      final statusMatches = switch (_selectedStatus) {
        'late' => record.isLate == true,
        'earlyCheckout' => record.isEarly == true,
        'onTime' => record.isLate != true && record.isEarly != true,
        'absent' => record.status?.toLowerCase() == 'absent',
        _ => true,
      };
      if (!statusMatches) return false;

      final recordDate = _parseDate(record.attendanceDate);
      if (recordDate == null) {
        return _selectedDateFilter == AdminAttendanceDateFilter.all;
      }

      final recordDay = DateTime(
        recordDate.year,
        recordDate.month,
        recordDate.day,
      );

      switch (_selectedDateFilter) {
        case AdminAttendanceDateFilter.today:
          return recordDay.isAtSameMomentAs(today);
        case AdminAttendanceDateFilter.last30Days:
          final start = today.subtract(const Duration(days: 30));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.last90Days:
          final start = today.subtract(const Duration(days: 90));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.last180Days:
          final start = today.subtract(const Duration(days: 180));
          return !recordDay.isBefore(start) && !recordDay.isAfter(today);
        case AdminAttendanceDateFilter.custom:
          if (_customStartDate == null || _customEndDate == null) return true;
          final start = DateTime(
            _customStartDate!.year,
            _customStartDate!.month,
            _customStartDate!.day,
          );
          final end = DateTime(
            _customEndDate!.year,
            _customEndDate!.month,
            _customEndDate!.day,
          );
          return !recordDay.isBefore(start) && !recordDay.isAfter(end);
        case AdminAttendanceDateFilter.all:
          return true;
      }
    }).toList();

    emit(AdminAttendanceState.success(filtered));
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

  Future<bool> updateAttendance({
    required int id,
    String? clockInTime,
    String? clockOutTime,
    String? status,
    String? reason,
  }) async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.updateAttendance(
      id: id,
      clockInTime: clockInTime,
      clockOutTime: clockOutTime,
      status: status,
      reason: reason,
    );
    return result.when(
      success: (_) async {
        await loadAttendance();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminAttendanceState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteAttendance(int id) async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.deleteAttendance(id);
    return result.when(
      success: (_) async {
        await loadAttendance();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminAttendanceState.error(failure.messageKey));
        return false;
      },
    );
  }
}
