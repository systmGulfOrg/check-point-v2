import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'employee_details_state.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';

class EmployeeDetailsCubit extends SafeCubit<EmployeeDetailsState> {
  EmployeeDetailsCubit({required this.attendanceRepo})
    : super(const EmployeeDetailsState.initial());

  final EmployeeAttendanceRepo attendanceRepo;
  EmployeeModel? employee;
  List<AdminAttendanceModel> allAttendance = const [];
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month);
  List<PendingDeviceModel> devicesHistory = [];

  Future<void> load(String employeeId) async {
    emit(const EmployeeDetailsState.loading());
    final profileResult = await attendanceRepo.getEmployeeById(employeeId);
    final hasProfile = profileResult.when(
      success: (data) {
        employee = data;
        return true;
      },
      failure: (failure) {
        safeEmit(EmployeeDetailsState.error(failure.messageKey));
        return false;
      },
    );
    if (!hasProfile) return;

    try {
      final devicesResponse = await sl<AdminApiService>().getEmployeeDevices(
        employeeId,
      );
      if (devicesResponse.isSuccess) {
        devicesHistory = devicesResponse.value;
      }
    } catch (_) {}
    final attendanceResult = await attendanceRepo.getAttendanceHistory(
      employeeId: employeeId,
      pageIndex: 0,
      itemCount: 100,
    );
    attendanceResult.when(
      success: (data) {
        allAttendance = data;
        _emitMonthlyDetails();
      },
      failure: (failure) =>
          safeEmit(EmployeeDetailsState.error(failure.messageKey)),
    );
  }

  void setMonth(DateTime month) {
    final normalized = DateTime(month.year, month.month);
    final currentMonth = DateTime(DateTime.now().year, DateTime.now().month);
    if (normalized.isAfter(currentMonth)) return;
    selectedMonth = normalized;
    _emitMonthlyDetails();
  }

  void _emitMonthlyDetails() {
    final profile = employee;
    if (profile == null) return;
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
    emit(
      EmployeeDetailsState.success(
        employee: profile,
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
      ),
    );
  }

  String _totalHours(List<AdminAttendanceModel> records) {
    var totalMinutes = 0;
    for (final record in records) {
      final raw = record.dayHours;
      if (raw == null || raw.trim().isEmpty) continue;
      final parts = raw.split(':');
      if (parts.length >= 2) {
        totalMinutes +=
            (int.tryParse(parts[0]) ?? 0) * 60 + (int.tryParse(parts[1]) ?? 0);
      }
    }
    return '${totalMinutes ~/ 60}h ${totalMinutes % 60}m';
  }
}
