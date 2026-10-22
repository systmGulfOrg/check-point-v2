import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_attendance_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeAdminAttendanceRepo implements AdminAttendanceRepo {
  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAdminAttendance({
    int itemCount = 1000,
    int index = 0,
  }) async {
    return ApiResult.success([
      AdminAttendanceModel(
        employeeId: 'present',
        employeeName: 'Ahmed',
        attendanceDate: DateTime.now().toIso8601String(),
        clockInTime: '09:00',
      ),
      AdminAttendanceModel(
        employeeId: 'chart-late',
        attendanceDate: DateTime.now().toIso8601String(),
        clockInTime: '09:30',
        isLate: true,
      ),
      AdminAttendanceModel(
        employeeId: 'chart-absent',
        attendanceDate: DateTime.now().toIso8601String(),
        status: 'absent',
      ),
    ]);
  }

  @override
  Future<ApiResult<void>> updateAttendance({
    required int id,
    String? clockInTime,
    String? clockOutTime,
    String? status,
    String? reason,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deleteAttendance(int id) async =>
      const ApiResult.success(null);
}

void main() {
  test(
    'separates today employees by present, late, absent, and leave',
    () async {
      final cubit = AdminAttendanceCubit(
        attendanceRepo: FakeAdminAttendanceRepo(),
      );
      addTearDown(cubit.close);
      final employees = [
        const EmployeeModel(
          id: 'present',
          name: 'Ahmed',
          todayWorkEnd: '23:59',
        ),
        const EmployeeModel(id: 'late', name: 'Sara', todayWorkEnd: '23:59'),
        const EmployeeModel(id: 'absent', name: 'Karim', todayWorkEnd: '00:00'),
        const EmployeeModel(id: 'leave', name: 'Dina', todayWorkEnd: '23:59'),
      ];

      await cubit.loadAttendance();

      final today = DateTime.now().toIso8601String();
      final leaveRequests = [
        AdminLeaveRequestModel(
          employeeId: 'leave',
          startDate: today,
          endDate: today,
          status: 'Approved',
        ),
      ];

      expect(cubit.getPresentEmployees(employees).map((e) => e.id), [
        'present',
      ]);
      expect(
        cubit.getLateEmployees(employees, leaveRequests).map((e) => e.id),
        ['late'],
      );
      expect(
        cubit.getAbsentEmployees(employees, leaveRequests).map((e) => e.id),
        ['absent'],
      );
      expect(
        cubit.getOnLeaveEmployees(employees, leaveRequests).map((e) => e.id),
        ['leave'],
      );
      final todaySummary =
          cubit.weeklyAttendanceSummary[DateTime.now().weekday - 1];
      expect(todaySummary.present, 1);
      expect(todaySummary.late, 1);
      expect(todaySummary.absent, 1);
    },
  );
}
