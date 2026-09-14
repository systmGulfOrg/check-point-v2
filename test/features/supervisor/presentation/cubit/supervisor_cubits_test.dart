import 'package:local_auth/local_auth.dart';

import 'package:check_point_v2/core/auth/biometric_auth_service.dart';
import 'package:check_point_v2/core/services/attendance_verification_service.dart';
import 'package:check_point_v2/core/services/location_service.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';
import 'package:check_point_v2/features/admin/data/models/tasks/admin_task_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/employee/data/models/leave_requests/employee_leave_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_in_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/attendance/supervisor_attendance_check_out_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/models/tasks/supervisor_update_task_status_request_body.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_attendance_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_leave_requests_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_plans_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_tasks_repo.dart';
import 'package:check_point_v2/features/supervisor/data/repos/supervisor_team_repo.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/leave_requests/supervisor_leave_requests_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/plans/supervisor_plans_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/tasks/supervisor_tasks_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSupervisorTeamRepo implements SupervisorTeamRepo {
  final members = <EmployeeModel>[
    const EmployeeModel(id: '1', name: 'John Doe', role: 'Employee'),
  ];

  @override
  Future<ApiResult<List<EmployeeModel>>> getTeamEmployees({
    int? departmentId,
  }) async => ApiResult.success(members);

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees(String query) async =>
      ApiResult.success(members);

  @override
  Future<ApiResult<EmployeeModel>> getEmployeeProfile(String id) async =>
      ApiResult.success(members.first);
}

class _FakeSupervisorAttendanceRepo implements SupervisorAttendanceRepo {
  final records = <AdminAttendanceModel>[
    const AdminAttendanceModel(
      id: 1,
      employeeName: 'John',
      clockInTime: '08:00',
    ),
  ];

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getAttendance({
    int? departmentId,
    String? attendanceDate,
  }) async => ApiResult.success(records);

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getLateComers(
    String day,
  ) async => ApiResult.success([]);

  @override
  Future<ApiResult<List<AdminAttendanceModel>>> getEarlyLeavers(
    String day,
  ) async => ApiResult.success([]);

  @override
  Future<ApiResult<void>> checkIn(
    SupervisorAttendanceCheckInRequestBody body,
  ) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> checkOut(
    SupervisorAttendanceCheckOutRequestBody body,
  ) async => const ApiResult.success(null);
}

class _FakeSupervisorLeaveRequestsRepo implements SupervisorLeaveRequestsRepo {
  final requests = <AdminLeaveRequestModel>[
    const AdminLeaveRequestModel(
      id: 1,
      employeeName: 'John',
      status: 'Pending',
    ),
  ];

  @override
  Future<ApiResult<List<AdminLeaveRequestModel>>> getLeaveRequests({
    int? departmentId,
    String? type,
  }) async => ApiResult.success(requests);

  @override
  Future<ApiResult<List<LeaveTypeModel>>> getLeaveTypes() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<void>> createLeaveRequest(
    EmployeeLeaveRequestBody body,
  ) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> approveOrRejectLeaveRequest(
    ChangeRequestLeaveStatus body,
  ) async => const ApiResult.success(null);
}

class _FakeSupervisorTasksRepo implements SupervisorTasksRepo {
  final tasks = <AdminTaskModel>[
    const AdminTaskModel(id: 1, title: 'Task 1', status: 'To Do'),
  ];

  @override
  Future<ApiResult<List<AdminTaskModel>>> getTasks({
    int? departmentId,
    String? employeeId,
  }) async => ApiResult.success(tasks);

  @override
  Future<ApiResult<void>> addTask(AddTaskRequestBody body) async {
    tasks.add(
      AdminTaskModel(id: 2, title: body.title, description: body.description),
    );
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> editTask(int id, AddTaskRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deleteTask(int id) async {
    tasks.removeWhere((t) => t.id == id);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> assignTask(AssignTaskRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> updateTaskStatus(
    SupervisorUpdateTaskStatusRequestBody body,
  ) async => const ApiResult.success(null);
}

class _FakeSupervisorPlansRepo implements SupervisorPlansRepo {
  final plans = <AdminPlanModel>[const AdminPlanModel(id: 1, title: 'Plan 1')];

  @override
  Future<ApiResult<List<AdminPlanModel>>> getPlans({int? departmentId}) async =>
      ApiResult.success(plans);

  @override
  Future<ApiResult<List<AdminPlanModel>>> getCustomerPlans({
    int? departmentId,
  }) async => ApiResult.success(plans);

  @override
  Future<ApiResult<void>> createPlan(CreatePlanRequestBody body) async {
    plans.add(AdminPlanModel(id: 2, title: body.title));
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> deletePlan(int id) async {
    plans.removeWhere((p) => p.id == id);
    return const ApiResult.success(null);
  }
}

void main() {
  group('Supervisor Cubits Tests', () {
    test('SupervisorTeamCubit loads team members successfully', () async {
      final repo = _FakeSupervisorTeamRepo();
      final cubit = SupervisorTeamCubit(teamRepo: repo);

      expect(cubit.state, const SupervisorTeamState.initial());
      await cubit.loadTeam();
      expect(cubit.state, isA<SupervisorTeamSuccess>());
    });

    test('SupervisorAttendanceCubit loads attendance successfully', () async {
      final repo = _FakeSupervisorAttendanceRepo();
      final cubit = SupervisorAttendanceCubit(
        attendanceRepo: repo,
        attendanceVerificationService: AttendanceVerificationService(
          locationService: LocationService(),
          biometricAuthService: BiometricAuthService(
            localAuthentication: LocalAuthentication(),
          ),
        ),
      );

      await cubit.loadAttendance();
      expect(cubit.state, isA<SupervisorAttendanceSuccess>());
    });

    test(
      'SupervisorLeaveRequestsCubit loads and approves leave request',
      () async {
        final repo = _FakeSupervisorLeaveRequestsRepo();
        final cubit = SupervisorLeaveRequestsCubit(leaveRequestsRepo: repo);

        await cubit.loadLeaveRequests();
        expect(cubit.state, isA<SupervisorLeaveRequestsSuccess>());

        final success = await cubit.approveRequest(1);
        expect(success, isTrue);
      },
    );

    test('SupervisorTasksCubit loads and adds task', () async {
      final repo = _FakeSupervisorTasksRepo();
      final cubit = SupervisorTasksCubit(tasksRepo: repo);

      await cubit.loadTasks();
      expect(cubit.state, isA<SupervisorTasksSuccess>());

      final success = await cubit.addTask(
        const AddTaskRequestBody(title: 'New Task', description: 'Desc'),
      );
      expect(success, isTrue);
    });

    test('SupervisorPlansCubit loads and creates plan', () async {
      final repo = _FakeSupervisorPlansRepo();
      final cubit = SupervisorPlansCubit(plansRepo: repo);

      await cubit.loadPlans();
      expect(cubit.state, isA<SupervisorPlansSuccess>());

      final success = await cubit.createPlan(
        const CreatePlanRequestBody(
          title: 'New Plan',
          description: 'Desc',
          startDate: '2026-09-01',
          endDate: '2026-09-02',
          assignedEmployeeId: '1',
        ),
      );
      expect(success, isTrue);
    });
  });
}
