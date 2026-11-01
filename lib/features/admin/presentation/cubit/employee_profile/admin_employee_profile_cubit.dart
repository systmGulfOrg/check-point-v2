import 'dart:async';

import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/leaves/data/apis/leaves_api_service.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_balance_model.dart';
import 'package:check_point_v2/features/leaves/data/models/short_leave_model.dart';
import 'admin_employee_profile_state.dart';

class AdminEmployeeProfileCubit extends SafeCubit<AdminEmployeeProfileState> {
  AdminEmployeeProfileCubit({
    required this.attendanceRepo,
    required this.adminApiService,
    required this.leavesApiService,
  }) : super(const AdminEmployeeProfileState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  final AdminApiService adminApiService;
  final LeavesApiService leavesApiService;

  EmployeeModel? employee;
  String? _employeeId;
  List<AdminAttendanceModel> allAttendance = const [];
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  List<PendingDeviceModel> devicesHistory = [];
  List<AdminLeaveRequestModel> leaveRequests = [];
  List<LeaveBalanceModel> leaveBalances = [];
  List<ShortLeaveModel> permissions = [];

  Future<void> load(String employeeId, {EmployeeModel? initialEmployee}) async {
    _employeeId = employeeId;
    if (initialEmployee != null) {
      employee = initialEmployee;
    }
    emit(const AdminEmployeeProfileState.loading());

    final profileResult = await attendanceRepo.getEmployeeById(employeeId);
    profileResult.when(success: (data) => employee = data, failure: (_) {});

    if (employee == null) {
      profileResult.when(
        success: (_) {},
        failure: (failure) =>
            safeEmit(AdminEmployeeProfileState.error(failure.messageKey)),
      );
      return;
    }

    try {
      final devicesResponse = await adminApiService.getEmployeeDevices(
        employeeId,
      );
      if (devicesResponse.isSuccess) {
        devicesHistory = devicesResponse.value;
      }
    } catch (_) {}

    try {
      final leavesResponse = await adminApiService.getAllLeaveRequests();
      if (leavesResponse.isSuccess == true && leavesResponse.value != null) {
        // Match by id only: two employees can share a name.
        leaveRequests = leavesResponse.value!.list
            .where((r) => r.employeeId == employeeId)
            .toList();
      }
    } catch (_) {}

    try {
      final allPerms = await leavesApiService.getShortLeaves();
      permissions = allPerms.where((p) => p.employeeId == employeeId).toList();
    } catch (_) {}

    final attendanceResult = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
      pageIndex: 0,
      itemCount: 150,
    );
    attendanceResult.when(
      success: (data) => allAttendance = data,
      failure: (_) {},
    );

    leaveBalances = await _loadLeaveBalances(employeeId);
    await _computeAndEmit();
  }

  void setMonth(DateTime month) {
    final normalized = DateTime(month.year, month.month);
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    if (normalized.isAfter(currentMonth)) return;
    selectedMonth = normalized;
    unawaited(_computeAndEmit());
  }

  Future<void> _computeAndEmit() async {
    final currentEmp = employee;
    if (currentEmp == null) return;

    final now = DateTime.now();
    final monthlyRecords = allAttendance.where((record) {
      final date = DateTime.tryParse(record.attendanceDate ?? '');
      if (date == null ||
          date.year != selectedMonth.year ||
          date.month != selectedMonth.month) {
        return false;
      }
      return selectedMonth.year != now.year ||
          selectedMonth.month != now.month ||
          !date.isAfter(now);
    }).toList();

    // The server owns these numbers: absence depends on the employee's shifts,
    // weekly offs, holidays and approved leaves, which the app does not know.
    final summary = await _loadMonthSummary(_employeeId);

    safeEmit(
      AdminEmployeeProfileState.success(
        employee: currentEmp,
        attendance: monthlyRecords,
        selectedMonth: selectedMonth,
        attendedDays:
            summary?.presentDays ??
            monthlyRecords
                .map((r) => r.attendanceDate?.split('T').first)
                .whereType<String>()
                .toSet()
                .length,
        absentDays: summary?.absentDays ?? 0,
        lateDays:
            summary?.lateDays ??
            monthlyRecords.where((r) => r.isLate == true).length,
        earlyLeaveDays:
            summary?.earlyLeaveDays ??
            monthlyRecords.where((r) => (r.earlyLeaveMinutes ?? 0) > 0).length,
        totalHours: summary != null
            ? _formatMinutes(summary.workedMinutes)
            : _totalHours(monthlyRecords),
        devicesHistory: devicesHistory,
        leaveRequests: leaveRequests,
        leaveBalances: leaveBalances,
        permissions: permissions,
      ),
    );
  }

  Future<_MonthSummary?> _loadMonthSummary(String? employeeId) async {
    if (employeeId == null) return null;
    final now = DateTime.now();
    final first = DateTime(selectedMonth.year, selectedMonth.month);
    final lastOfMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);
    final last = lastOfMonth.isAfter(now) ? now : lastOfMonth;
    String ymd(DateTime d) =>
        '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    try {
      final response = await adminApiService.getAttendanceSummary(
        from: ymd(first),
        to: ymd(last),
        employeeId: employeeId,
      );
      final value = (response as Map<String, dynamic>)['value'];
      if (value is! Map<String, dynamic>) return null;
      int n(String k) => (value[k] as num?)?.toInt() ?? 0;
      return _MonthSummary(
        presentDays: n('presentDays'),
        absentDays: n('absentDays'),
        lateDays: n('lateCount'),
        earlyLeaveDays: n('earlyLeaveCount'),
        workedMinutes: n('totalWorkedMinutes'),
      );
    } catch (_) {
      return null;
    }
  }

  Future<List<LeaveBalanceModel>> _loadLeaveBalances(String employeeId) async {
    final year = DateTime.now().year;
    try {
      final response = await adminApiService.getEmployeeLeaveBalance(
        employeeId: employeeId,
        year: year,
      );
      final value = (response as Map<String, dynamic>)['value'];
      final rows = value is Map<String, dynamic> ? value['balances'] : null;
      if (rows is! List) return const [];
      return rows
          .whereType<Map<String, dynamic>>()
          // Unlimited / unpaid types have no entitlement to show a balance for.
          .where((r) => r['entitlement'] != null)
          .map(
            (r) => LeaveBalanceModel(
              id: r['leaveTypeId']?.toString() ?? '',
              leaveTypeId: r['leaveTypeId']?.toString() ?? '',
              leaveTypeName: r['typeName']?.toString() ?? '',
              year: year,
              totalAllocated: (r['entitlement'] as num).toInt(),
              usedBalance: (r['used'] as num?)?.toInt() ?? 0,
              remainingBalance: (r['remaining'] as num?)?.toInt() ?? 0,
              carriedOver: 0,
            ),
          )
          .toList();
    } catch (_) {
      return const [];
    }
  }

  String _formatMinutes(int totalMinutes) =>
      '${totalMinutes ~/ 60}h ${totalMinutes % 60}m';

  String _totalHours(List<AdminAttendanceModel> records) {
    var totalMinutes = 0;
    for (final record in records) {
      final hoursStr = record.dayHours ?? '';
      final parts = hoursStr.split(':');
      if (parts.length >= 2) {
        final hours = int.tryParse(parts[0]) ?? 0;
        final minutes = int.tryParse(parts[1]) ?? 0;
        totalMinutes += (hours * 60) + minutes;
      }
    }
    final hours = totalMinutes ~/ 60;
    final remainingMinutes = totalMinutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }
}

class _MonthSummary {
  const _MonthSummary({
    required this.presentDays,
    required this.absentDays,
    required this.lateDays,
    required this.earlyLeaveDays,
    required this.workedMinutes,
  });

  final int presentDays;
  final int absentDays;
  final int lateDays;
  final int earlyLeaveDays;
  final int workedMinutes;
}
