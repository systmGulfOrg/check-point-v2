import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/approve_account_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAdminEmployeeRepo implements AdminEmployeeRepo {
  final requests = <AccountRequestModel>[
    const AccountRequestModel(
      id: 1,
      name: 'Ahmed',
      mobileId: 'DEVICE-1',
      status: 'Pending',
    ),
    const AccountRequestModel(
      id: 2,
      name: 'Sara',
      mobileId: 'DEVICE-2',
      status: 'Approved',
    ),
    const AccountRequestModel(
      id: 3,
      name: 'Khaled',
      mobileId: 'DEVICE-3',
      status: 'Rejected',
      rejectReason: 'Duplicate entry',
    ),
  ];

  @override
  Future<ApiResult<List<AccountRequestModel>>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
  }) async {
    return ApiResult.success(requests);
  }

  @override
  Future<ApiResult<void>> approveAccountRequest({
    required int id,
    required ApproveAccountRequestBody body,
  }) async {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      requests[index] = AccountRequestModel(
        id: id,
        name: requests[index].name,
        mobileId: requests[index].mobileId,
        status: 'Approved',
      );
    }
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> rejectAccountRequest({
    required int id,
    required String reason,
  }) async {
    final index = requests.indexWhere((r) => r.id == id);
    if (index != -1) {
      requests[index] = AccountRequestModel(
        id: id,
        name: requests[index].name,
        mobileId: requests[index].mobileId,
        status: 'Rejected',
        rejectReason: reason,
      );
    }
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> deleteAccountRequest({required int id}) async {
    requests.removeWhere((r) => r.id == id);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployeesInDepartment({
    required int departmentId,
  }) async => const ApiResult.success([]);

  @override
  Future<ApiResult<void>> addEmployee(AddEmployeeRequestBody body) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> editEmployee({
    required String id,
    required EditEmployeeRequestBody body,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> deleteEmployee({required String userId}) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> setAttendancePermission({
    required String supervisorId,
    required bool permission,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<void>> setPlanPermission({
    required String supervisorId,
    required bool permission,
  }) async => const ApiResult.success(null);

  @override
  Future<ApiResult<List<EmployeeModel>>> getDeletedEmployees() async =>
      const ApiResult.success([]);

  @override
  Future<ApiResult<void>> restoreEmployee({required String id}) async =>
      const ApiResult.success(null);

  @override
  Future<ApiResult<void>> permanentDeleteEmployee({required String id}) async =>
      const ApiResult.success(null);
}

void main() {
  group('AdminAccountRequestsCubit', () {
    test('loadRequests filters pending requests by default', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AdminAccountRequestsState.loading(),
          isA<AdminAccountRequestsStateSuccess>().having(
            (s) => s.requests.length,
            'pending count',
            1,
          ),
        ]),
      );

      await cubit.loadRequests();
    });

    test('approveRequest updates request to approved and reloads', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      await cubit.loadRequests();

      final error = await cubit.approveRequest(
        id: 1,
        body: const ApproveAccountRequestBody(
          userName: 'ahmed',
          password: 'Password123!',
          roles: ['Employee', 'Supervisor'],
          shiftId: 1,
        ),
      );

      expect(error, isNull);
      expect(repo.requests.firstWhere((r) => r.id == 1).status, 'Approved');
    });

    test('rejectRequest sets rejection reason and reloads', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      await cubit.loadRequests();

      final error = await cubit.rejectRequest(
        id: 1,
        reason: 'Device not registered with company',
      );

      expect(error, isNull);
      final req = repo.requests.firstWhere((r) => r.id == 1);
      expect(req.status, 'Rejected');
      expect(req.rejectReason, 'Device not registered with company');
    });
  });
}
