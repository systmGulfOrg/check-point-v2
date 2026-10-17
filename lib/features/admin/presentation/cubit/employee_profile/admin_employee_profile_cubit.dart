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
  List<AdminAttendanceModel> allAttendance = const [];
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  List<PendingDeviceModel> devicesHistory = [];
  List<AdminLeaveRequestModel> leaveRequests = [];
  List<LeaveBalanceModel> leaveBalances = [];
  List<ShortLeaveModel> permissions = [];

  Future<void> load(String employeeId, {EmployeeModel? initialEmployee}) async {
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

    // Load Devices
    try {
      final devicesResponse = await adminApiService.getEmployeeDevices(
        employeeId,
      );
      if (devicesResponse.isSuccess) {
        devicesHistory = devicesResponse.value;
      }
    } catch (_) {}

    // Load Leave Requests
    try {
      final leavesResponse = await adminApiService.getAllLeaveRequests();
      if (leavesResponse.isSuccess == true && leavesResponse.value != null) {
        final allLeaves = leavesResponse.value!.list;
        final empName = employee?.name?.trim().toLowerCase();
        leaveRequests = allLeaves.where((r) {
          final matchesId = r.employeeId == employeeId;
          final matchesName =
              empName != null &&
              r.employeeName?.trim().toLowerCase() == empName;
          return matchesId || matchesName;
        }).toList();
      }
    } catch (_) {}

    // Load Permissions / Short Leaves
    try {
      final allPerms = await leavesApiService.getShortLeaves();
      permissions = allPerms.where((p) => p.employeeId == employeeId).toList();
    } catch (_) {}

    // Load Attendance History
    final attendanceResult = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
      pageIndex: 0,
      itemCount: 150,
    );
    attendanceResult.when(
      success: (data) => allAttendance = data,
      failure: (_) {},
    );

    _computeAndEmit();
  }

  void setMonth(DateTime month) {
    final normalized = DateTime(month.year, month.month);
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    if (normalized.isAfter(currentMonth)) return;
    selectedMonth = normalized;
    _computeAndEmit();
  }

  void _computeAndEmit() {
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

    final attendedDates = monthlyRecords
        .map((record) => record.attendanceDate?.split('T').first)
        .whereType<String>()
        .toSet();

    final daysInScope =
        selectedMonth.year == now.year && selectedMonth.month == now.month
        ? now.day
        : DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;

    // Build Default Leave Balances
    final totalAnnual = currentEmp.leaveBalance ?? 21;
    final usedAnnual = leaveRequests
        .where(
          (r) =>
              r.status?.toLowerCase() == 'approved' &&
              (r.leaveType?.toLowerCase().contains('annual') == true ||
                  r.leaveType?.toLowerCase().contains('سنوي') == true),
        )
        .length;
    final usedCasual = leaveRequests
        .where(
          (r) =>
              r.status?.toLowerCase() == 'approved' &&
              (r.leaveType?.toLowerCase().contains('casual') == true ||
                  r.leaveType?.toLowerCase().contains('عارض') == true),
        )
        .length;
    final usedSick = leaveRequests
        .where(
          (r) =>
              r.status?.toLowerCase() == 'approved' &&
              (r.leaveType?.toLowerCase().contains('sick') == true ||
                  r.leaveType?.toLowerCase().contains('مرض') == true),
        )
        .length;

    final currentYear = DateTime.now().year;
    leaveBalances = [
      LeaveBalanceModel(
        id: 'annual',
        leaveTypeId: '1',
        leaveTypeName: 'Annual Leave',
        year: currentYear,
        totalAllocated: totalAnnual,
        usedBalance: usedAnnual,
        remainingBalance: (totalAnnual - usedAnnual).clamp(0, totalAnnual),
        carriedOver: 0,
      ),
      LeaveBalanceModel(
        id: 'casual',
        leaveTypeId: '2',
        leaveTypeName: 'Casual Leave',
        year: currentYear,
        totalAllocated: 7,
        usedBalance: usedCasual,
        remainingBalance: (7 - usedCasual).clamp(0, 7),
        carriedOver: 0,
      ),
      LeaveBalanceModel(
        id: 'sick',
        leaveTypeId: '3',
        leaveTypeName: 'Sick Leave',
        year: currentYear,
        totalAllocated: 14,
        usedBalance: usedSick,
        remainingBalance: (14 - usedSick).clamp(0, 14),
        carriedOver: 0,
      ),
    ];

    emit(
      AdminEmployeeProfileState.success(
        employee: currentEmp,
        attendance: monthlyRecords,
        selectedMonth: selectedMonth,
        attendedDays: attendedDates.length,
        absentDays: (daysInScope - attendedDates.length).clamp(0, daysInScope),
        lateDays: monthlyRecords.where((item) => item.isLate == true).length,
        earlyLeaveDays: monthlyRecords
            .where((item) => item.isEarly == true)
            .length,
        totalHours: _totalHours(monthlyRecords),
        devicesHistory: devicesHistory,
        leaveRequests: leaveRequests,
        leaveBalances: leaveBalances,
        permissions: permissions,
      ),
    );
  }

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
