import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAdminEmployeeRepo implements AdminEmployeeRepo {
  final employees = <EmployeeModel>[
    const EmployeeModel(
      id: '1',
      name: 'Ahmed',
      userName: 'ahmed',
      role: 'Employee',
    ),
    const EmployeeModel(
      id: '2',
      name: 'Sara',
      userName: 'sara',
      role: 'Supervisor',
    ),
  ];

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployees({
    required int page,
    required int pageSize,
  }) async {
    return ApiResult.success(employees);
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> searchEmployees({
    required String searchKey,
  }) async {
    final filtered = employees
        .where(
          (e) => (e.name ?? '').toLowerCase().contains(searchKey.toLowerCase()),
        )
        .toList();
    return ApiResult.success(filtered);
  }

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployeesInDepartment({
    required int departmentId,
  }) async {
    return ApiResult.success(employees);
  }

  @override
  Future<ApiResult<void>> addEmployee(AddEmployeeRequestBody body) async {
    employees.add(
      EmployeeModel(
        id: '3',
        name: body.name,
        userName: body.username,
        role: body.role,
      ),
    );
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> editEmployee({
    required String id,
    required EditEmployeeRequestBody body,
  }) async {
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> deleteEmployee({required String userId}) async {
    employees.removeWhere((e) => e.id == userId);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> setAttendancePermission({
    required String supervisorId,
    required bool permission,
  }) async {
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> setPlanPermission({
    required String supervisorId,
    required bool permission,
  }) async {
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<List<AccountRequestModel>>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
  }) async {
    return const ApiResult.success([]);
  }

  @override
  Future<ApiResult<void>> deleteAccountRequest({required int id}) async {
    return const ApiResult.success(null);
  }
}

void main() {
  group('AdminEmployeesCubit', () {
    test('loadEmployees loads employee list from repo successfully', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminEmployeesCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AdminEmployeesState.loading(),
          AdminEmployeesState.success(
            employees: repo.employees,
            roleFilter: null,
          ),
        ]),
      );

      await cubit.loadEmployees();
    });

    test('addEmployee calls repo and reloads list', () async {
      final repo = _FakeAdminEmployeeRepo();
      final cubit = AdminEmployeesCubit(employeeRepo: repo);
      addTearDown(cubit.close);

      final body = const AddEmployeeRequestBody(
        name: 'Mohamed',
        username: 'mohamed',
        password: 'pass',
        position: 'Developer',
        mobileId: 'm123',
        role: 'Employee',
        departmentId: 1,
        branchId: 1,
      );

      final success = await cubit.addEmployee(body);
      expect(success, isTrue);
      expect(repo.employees, hasLength(3));
    });
  });
}
