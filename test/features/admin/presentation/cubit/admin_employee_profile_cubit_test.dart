import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/apis/admin_api_service.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_attendance_repo.dart';
import 'package:check_point_v2/features/leaves/data/apis/leaves_api_service.dart';
import 'package:check_point_v2/features/leaves/data/models/short_leave_model.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRepo extends Fake implements EmployeeAttendanceRepo {
  @override
  Future<ApiResult<EmployeeModel>> getEmployeeById(String employeeId) async =>
      ApiResult.success(
        EmployeeModel.fromJson({'id': employeeId, 'name': 'A'}),
      );

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendanceHistory({
    required String employeeId,
    int pageIndex = 0,
    int itemCount = 10,
  }) async => const ApiResult.success([]);
}

class _FakeAdminApi extends Fake implements AdminApiService {
  _FakeAdminApi({this.summaryFails = false});
  final bool summaryFails;

  @override
  Future<dynamic> getAttendanceSummary({
    required String from,
    required String to,
    String? employeeId,
  }) async {
    if (summaryFails) throw Exception('offline');
    return {
      'value': {
        'presentDays': 11,
        'absentDays': 3,
        'lateCount': 5,
        'earlyLeaveCount': 2,
        'totalWorkedMinutes': 5680,
      },
    };
  }

  @override
  Future<dynamic> getEmployeeLeaveBalance({
    required String employeeId,
    int? year,
  }) async => {
    'value': {
      'balances': [
        {
          'leaveTypeId': 'a',
          'typeName': 'Annual',
          'entitlement': 21,
          'used': 4,
          'remaining': 17,
        },
        // unlimited type: no entitlement, must not be shown as a balance
        {
          'leaveTypeId': 'u',
          'typeName': 'Unpaid',
          'entitlement': null,
          'used': 1,
          'remaining': null,
        },
      ],
    },
  };

  @override
  Future<Never> getEmployeeDevices(String employeeId) => throw Exception('n/a');

  @override
  Future<Never> getAllLeaveRequests() => throw Exception('n/a');
}

class _FakeLeavesApi extends Fake implements LeavesApiService {
  @override
  Future<List<ShortLeaveModel>> getShortLeaves() async => const [];
}

void main() {
  AdminEmployeeProfileCubit build({bool summaryFails = false}) =>
      AdminEmployeeProfileCubit(
        attendanceRepo: _FakeRepo(),
        adminApiService: _FakeAdminApi(summaryFails: summaryFails),
        leavesApiService: _FakeLeavesApi(),
      );

  test('month stats come from the server summary', () async {
    final cubit = build();
    await cubit.load('emp-1');
    final s = cubit.state.mapOrNull(success: (s) => s)!;
    expect(s.attendedDays, 11);
    // Not "days in month - present": weekends, holidays and leaves are excluded server-side.
    expect(s.absentDays, 3);
    expect(s.lateDays, 5);
    expect(s.earlyLeaveDays, 2);
    expect(s.totalHours, '94h 40m');
    await cubit.close();
  });

  test(
    'leave balances are real server days, unlimited types skipped',
    () async {
      final cubit = build();
      await cubit.load('emp-1');
      final s = cubit.state.mapOrNull(success: (s) => s)!;
      expect(s.leaveBalances, hasLength(1));
      expect(s.leaveBalances.single.totalAllocated, 21);
      expect(s.leaveBalances.single.usedBalance, 4);
      expect(s.leaveBalances.single.remainingBalance, 17);
      await cubit.close();
    },
  );

  test('without the summary it never invents absences', () async {
    final cubit = build(summaryFails: true);
    await cubit.load('emp-1');
    final s = cubit.state.mapOrNull(success: (s) => s)!;
    expect(s.absentDays, 0);
    await cubit.close();
  });
}
