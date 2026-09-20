import 'package:check_point_v2/core/auth/auth_session_storage.dart';
import 'package:check_point_v2/core/network/api_failure.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/admin_leave_request_model.dart';
import 'package:check_point_v2/features/employee/data/repos/employee_action_repo.dart';
import 'package:check_point_v2/features/employee/data/services/odoo_timeoff_service.dart';
import 'package:check_point_v2/features/employee/domain/use_cases/employee_leave_requests_use_case.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/leave_requests/employee_leave_requests_state.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeEmployeeActionRepo extends Fake implements EmployeeActionRepo {}

class FakeOdooTimeOffService extends Fake implements OdooTimeOffService {}

class FakeAuthSessionStorage extends Fake implements AuthSessionStorage {}

class FakeLeaveRequestsUseCase extends EmployeeLeaveRequestsUseCase {
  FakeLeaveRequestsUseCase({required this.result})
    : super(
        actionRepo: FakeEmployeeActionRepo(),
        odooTimeOffService: FakeOdooTimeOffService(),
        sessionStorage: FakeAuthSessionStorage(),
      );

  final ApiResult<List<AdminLeaveRequestModel>> result;

  @override
  Future<ApiResult<List<AdminLeaveRequestModel>>>
  getNativeLeaveRequests() async => result;
}

void main() {
  test('emits an error when loading native leave requests fails', () async {
    final leaveRequestsUseCase = FakeLeaveRequestsUseCase(
      result: const ApiResult.failure(ApiFailure(messageKey: 'errors.server')),
    );
    final cubit = EmployeeLeaveRequestsCubit(
      actionRepo: FakeEmployeeActionRepo(),
      odooTimeOffService: FakeOdooTimeOffService(),
      leaveRequestsUseCase: leaveRequestsUseCase,
    );
    addTearDown(cubit.close);

    await cubit.loadLeaveRequests();

    expect(
      cubit.state,
      const EmployeeLeaveRequestsState.error('errors.server'),
    );
  });

  test('emits success when native leave requests load successfully', () async {
    final leaveRequestsUseCase = FakeLeaveRequestsUseCase(
      result: const ApiResult.success([]),
    );
    final cubit = EmployeeLeaveRequestsCubit(
      actionRepo: FakeEmployeeActionRepo(),
      odooTimeOffService: FakeOdooTimeOffService(),
      leaveRequestsUseCase: leaveRequestsUseCase,
    );
    addTearDown(cubit.close);

    await cubit.loadLeaveRequests();

    expect(cubit.state, const EmployeeLeaveRequestsState.success([]));
  });
}
