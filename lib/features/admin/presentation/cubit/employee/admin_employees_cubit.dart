import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/employee/add_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_employees_state.dart';

class AdminEmployeesCubit extends SafeCubit<AdminEmployeesState> {
  AdminEmployeesCubit({required this.employeeRepo})
    : super(const AdminEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;
  List<EmployeeModel> allEmployees = const [];
  List<EmployeeModel> get employees => allEmployees;
  String? roleFilter;

  Future<void> loadEmployees({int page = 0, int pageSize = 20}) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.getEmployees(
      page: page,
      pageSize: pageSize,
    );
    result.when(
      success: (data) {
        allEmployees = data;
        safeEmit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      },
      failure: (failure) =>
          safeEmit(AdminEmployeesState.error(failure.messageKey)),
    );
  }

  Future<void> search(String value) async {
    final query = value.trim();
    if (query.isEmpty) {
      await loadEmployees();
      return;
    }
    safeEmit(const AdminEmployeesState.loading());
    final result = await employeeRepo.searchEmployees(searchKey: query);
    result.when(
      success: (data) {
        allEmployees = data;
        safeEmit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      },
      failure: (failure) =>
          safeEmit(AdminEmployeesState.error(failure.messageKey)),
    );
  }

  void setRoleFilter(String? value) {
    roleFilter = value;
    emit(
      AdminEmployeesState.success(
        employees: _filteredEmployees,
        roleFilter: roleFilter,
      ),
    );
  }

  List<EmployeeModel> get _filteredEmployees {
    final filter = roleFilter?.toLowerCase();
    if (filter == null || filter.isEmpty) return allEmployees;
    return allEmployees
        .where(
          (employee) => employee.allRoles.any((r) => r.toLowerCase() == filter),
        )
        .toList();
  }

  Future<String?> addEmployee(AddEmployeeRequestBody body) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.addEmployee(body);
    return result.when(
      success: (_) async {
        await loadEmployees();
        safeEmit(
          AdminEmployeesState.actionSuccess(
            message: 'Employee added successfully',
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
        return null;
      },
      failure: (failure) {
        safeEmit(AdminEmployeesState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> editEmployee(String id, EditEmployeeRequestBody body) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.editEmployee(id: id, body: body);
    return result.when(
      success: (_) async {
        await loadEmployees();
        safeEmit(
          AdminEmployeesState.actionSuccess(
            message: 'Employee updated successfully',
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
        return null;
      },
      failure: (failure) {
        safeEmit(AdminEmployeesState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> deleteEmployee(String userId) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.deleteEmployee(userId: userId);
    return result.when(
      success: (_) async {
        await loadEmployees();
        safeEmit(
          AdminEmployeesState.actionSuccess(
            message: 'Employee deleted successfully',
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
        return null;
      },
      failure: (failure) {
        safeEmit(AdminEmployeesState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> setAttendancePermission(
    String supervisorId,
    bool permission,
  ) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.setAttendancePermission(
      supervisorId: supervisorId,
      permission: permission,
    );
    return result.when(
      success: (_) async {
        await loadEmployees();
        safeEmit(
          AdminEmployeesState.actionSuccess(
            message: 'Permission updated successfully',
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
        return null;
      },
      failure: (failure) {
        safeEmit(AdminEmployeesState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }

  Future<String?> setPlanPermission(
    String supervisorId,
    bool permission,
  ) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.setPlanPermission(
      supervisorId: supervisorId,
      permission: permission,
    );
    return result.when(
      success: (_) async {
        await loadEmployees();
        safeEmit(
          AdminEmployeesState.actionSuccess(
            message: 'Permission updated successfully',
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
        return null;
      },
      failure: (failure) {
        safeEmit(AdminEmployeesState.error(failure.messageKey));
        return failure.messageKey;
      },
    );
  }
}
