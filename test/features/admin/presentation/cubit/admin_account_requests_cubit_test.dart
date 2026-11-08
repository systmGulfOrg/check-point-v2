import 'package:check_point_v2/core/network/api_failure.dart';
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

  final calls = <({int page, String? status, String? search, bool newestFirst})>[];
  bool fail = false;

  /// Behaves like GET /api/v2/account-requests: filters, searches and pages.
  @override
  Future<ApiResult<AccountRequestsPageModel>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
    String? status,
    String? search,
    bool newestFirst = true,
  }) async {
    calls.add((page: page, status: status, search: search, newestFirst: newestFirst));
    if (fail) {
      return const ApiResult.failure(ApiFailure(messageKey: 'errors.server'));
    }
    final matching = requests
        .where((r) => status == null || r.status == status)
        .where((r) => search == null || search.isEmpty || (r.name ?? '').contains(search))
        .toList();
    final slice = matching.skip(page * pageSize).take(pageSize).toList();
    return ApiResult.success(
      AccountRequestsPageModel(
        items: slice,
        totalCount: matching.length,
        hasNext: (page + 1) * pageSize < matching.length,
      ),
    );
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

    test('each tab asks the server for its status', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      await cubit.loadRequests();
      await cubit.setFilter('admin.requests.filterApproved');
      await cubit.setFilter('admin.requests.filterRejected');

      expect(repo.calls.map((c) => c.status), ['Pending', 'Approved', 'Rejected']);
      expect(cubit.state, isA<AdminAccountRequestsStateSuccess>());
      final state = cubit.state as AdminAccountRequestsStateSuccess;
      expect(state.requests.single.name, 'Khaled');
    });

    test('loads the next page on demand and stops when everything is loaded', () async {
      final repo = _FakeAdminEmployeeRepo();
      repo.requests
        ..clear()
        ..addAll([
          for (var i = 0; i < 25; i++)
            AccountRequestModel(id: i, name: 'R$i', status: 'Pending'),
        ]);
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      await cubit.loadRequests();
      var state = cubit.state as AdminAccountRequestsStateSuccess;
      expect(state.requests, hasLength(20));
      expect(state.hasMore, isTrue);

      await cubit.loadRequests(newResponse: false);
      state = cubit.state as AdminAccountRequestsStateSuccess;
      expect(state.requests, hasLength(25));
      expect(state.hasMore, isFalse);

      await cubit.loadRequests(newResponse: false); // complete: no request
      expect(repo.calls.map((c) => c.page), [0, 1]);
    });

    test('sorting asks the server for the order', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);
      await cubit.setSort(newest: false);
      expect(repo.calls.single.newestFirst, isFalse);
    });

    test('search is sent to the server after a short pause', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      cubit
        ..setSearch('Ah')
        ..setSearch('Ahm');
      await Future<void>.delayed(
        AdminAccountRequestsCubit.searchDebounce + const Duration(milliseconds: 50),
      );

      expect(repo.calls.map((c) => c.search), ['Ahm']);
    });

    test('emits the error key when loading fails', () async {
      final repo = _FakeAdminEmployeeRepo()..fail = true;
      final cubit = AdminAccountRequestsCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      await cubit.loadRequests();
      expect(cubit.state, const AdminAccountRequestsState.error('errors.server'));
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
