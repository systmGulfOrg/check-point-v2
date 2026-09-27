import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_department_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_department_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeLocationsRepo implements AdminLocationsRepo {
  final departments = <DepartmentModel>[
    const DepartmentModel(id: 1, departmentName: 'Engineering'),
    const DepartmentModel(id: 2, departmentName: 'Human Resources'),
  ];

  @override
  Future<ApiResult<List<DepartmentModel>>> getDepartments() async {
    return ApiResult.success(departments);
  }

  @override
  Future<ApiResult<List<DepartmentModel>>> searchDepartments(
    String searchKey,
  ) async {
    final filtered = departments
        .where(
          (d) => (d.departmentName ?? '').toLowerCase().contains(
            searchKey.toLowerCase(),
          ),
        )
        .toList();
    return ApiResult.success(filtered);
  }

  @override
  Future<ApiResult<void>> addDepartment(DepartmentRequestModel request) async {
    departments.add(
      DepartmentModel(id: 3, departmentName: request.departmentName),
    );
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> editDepartment(
    int id,
    DepartmentRequestModel request,
  ) async {
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<void>> deleteDepartment(int id) async {
    departments.removeWhere((d) => d.id == id);
    return const ApiResult.success(null);
  }

  @override
  Future<ApiResult<List<BranchModel>>> getBranches() async =>
      const ApiResult.success([]);
  @override
  Future<ApiResult<void>> addBranch(BranchRequestModel request) async =>
      const ApiResult.success(null);
  @override
  Future<ApiResult<void>> editBranch(
    int id,
    BranchRequestModel request,
  ) async => const ApiResult.success(null);
  @override
  Future<ApiResult<void>> deleteBranch(int id) async =>
      const ApiResult.success(null);
  @override
  Future<ApiResult<List<CustomerModel>>> getCustomersByType(
    String type,
  ) async => const ApiResult.success([]);
  @override
  Future<ApiResult<void>> addCustomer(CustomerRequestModel request) async =>
      const ApiResult.success(null);
  @override
  Future<ApiResult<void>> editCustomer(
    String id,
    CustomerRequestModel request,
  ) async => const ApiResult.success(null);
  @override
  Future<ApiResult<void>> deleteCustomer(String id) async =>
      const ApiResult.success(null);
}

class _FakeEmployeeRepo implements AdminEmployeeRepo {
  final employees = <EmployeeModel>[
    const EmployeeModel(
      id: '1',
      name: 'Ahmed',
      userName: 'ahmed@test.com',
      role: 'Supervisor',
      departmentId: 1,
      departmentName: 'Engineering',
      canAddAttendance: true,
      canAddPlan: true,
    ),
  ];

  @override
  Future<ApiResult<List<EmployeeModel>>> getEmployeesInDepartment({
    required int departmentId,
  }) async {
    final filtered = employees
        .where((e) => e.departmentId == departmentId)
        .toList();
    return ApiResult.success(filtered);
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
  Future<ApiResult<List<AccountRequestModel>>> getAccountRequests({
    int page = 0,
    int pageSize = 20,
  }) async => const ApiResult.success([]);
  @override
  Future<ApiResult<void>> approveAccountRequest({
    required int id,
    required dynamic body,
  }) async => const ApiResult.success(null);
  @override
  Future<ApiResult<void>> rejectAccountRequest({
    required int id,
    required String reason,
  }) async => const ApiResult.success(null);
  @override
  Future<ApiResult<void>> deleteAccountRequest({required int id}) async =>
      const ApiResult.success(null);
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
  group('AdminDepartmentsCubit', () {
    test('load emits loading and success with department list', () async {
      final repo = _FakeLocationsRepo();
      final cubit = AdminDepartmentsCubit(locationsRepo: repo);
      addTearDown(cubit.close);

      expectLater(
        cubit.stream,
        emitsInOrder([
          const AdminDepartmentsState.loading(),
          AdminDepartmentsState.success(repo.departments),
        ]),
      );

      await cubit.load();
    });

    test('addDepartment calls repo and reloads list', () async {
      final repo = _FakeLocationsRepo();
      final cubit = AdminDepartmentsCubit(locationsRepo: repo);
      addTearDown(cubit.close);

      await cubit.addDepartment(
        const DepartmentRequestModel(departmentName: 'Product'),
      );
      expect(repo.departments, hasLength(3));
    });
  });

  group('AdminDepartmentEmployeesCubit', () {
    test(
      'load fetches employees in specific department successfully',
      () async {
        final repo = _FakeEmployeeRepo();
        final cubit = AdminDepartmentEmployeesCubit(employeeRepo: repo);
        addTearDown(cubit.close);

        expectLater(
          cubit.stream,
          emitsInOrder([
            const AdminDepartmentEmployeesState.loading(),
            AdminDepartmentEmployeesState.success(repo.employees),
          ]),
        );

        await cubit.load(1);
      },
    );
  });
}
