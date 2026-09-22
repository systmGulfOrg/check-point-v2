import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
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

class AdminAttendanceCubit extends Cubit<AdminAttendanceState> {
  AdminAttendanceCubit({required this.attendanceRepo})
    : super(const AdminAttendanceState.initial());

  final AdminAttendanceRepo attendanceRepo;

  List<AdminAttendanceModel> _allRecords = [];
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

  void setEmployeeDirectory(List<EmployeeModel> employees) {
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
    switch (result) {
      case Success(:final data):
        _allRecords = data;
        _isLoadingAttendance = false;
        _emitFiltered();
      case Failure(:final failure):
        _isLoadingAttendance = false;
        emit(AdminAttendanceState.error(failure.messageKey));
    }
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
      // 1. Search Query Filter
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
        _ => true,
      };
      if (!statusMatches) return false;

      // 2. Date Filter
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
    switch (result) {
      case Success():
        await loadAttendance();
        return true;
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteAttendance(int id) async {
    emit(const AdminAttendanceState.loading());
    final result = await attendanceRepo.deleteAttendance(id);
    switch (result) {
      case Success():
        await loadAttendance();
        return true;
      case Failure(:final failure):
        emit(AdminAttendanceState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
