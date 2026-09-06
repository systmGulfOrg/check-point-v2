import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
import '../../data/models/add_employee_request_body.dart';
import '../../data/models/edit_employee_request_body.dart';
import '../../data/models/employee_model.dart';
import '../../data/repos/admin_employee_repo.dart';
import 'admin_employees_state.dart';

class AdminEmployeesCubit extends Cubit<AdminEmployeesState> {
  AdminEmployeesCubit({required this.employeeRepo})
    : super(const AdminEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;
  List<EmployeeModel> allEmployees = const [];
  String? roleFilter;

  Future<void> loadEmployees() async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.getEmployees(page: 0, pageSize: 50);
    switch (result) {
      case Success(:final data):
        allEmployees = data;
        emit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
    }
  }

  Future<void> search(String value) async {
    final query = value.trim();
    if (query.isEmpty) {
      await loadEmployees();
      return;
    }
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.searchEmployees(searchKey: query);
    switch (result) {
      case Success(:final data):
        allEmployees = data;
        emit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
    }
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
        .where((employee) => employee.role?.toLowerCase() == filter)
        .toList();
  }

  Future<bool> addEmployee(AddEmployeeRequestBody body) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.addEmployee(body);
    switch (result) {
      case Success():
        await loadEmployees();
        emit(const AdminEmployeesState.actionSuccess('Employee added successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> editEmployee(String id, EditEmployeeRequestBody body) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.editEmployee(id: id, body: body);
    switch (result) {
      case Success():
        await loadEmployees();
        emit(const AdminEmployeesState.actionSuccess('Employee updated successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> deleteEmployee(String userId) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.deleteEmployee(userId: userId);
    switch (result) {
      case Success():
        await loadEmployees();
        emit(const AdminEmployeesState.actionSuccess('Employee deleted successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> setAttendancePermission(String supervisorId, bool permission) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.setAttendancePermission(
      supervisorId: supervisorId,
      permission: permission,
    );
    switch (result) {
      case Success():
        await loadEmployees();
        emit(const AdminEmployeesState.actionSuccess('Permission updated successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }

  Future<bool> setPlanPermission(String supervisorId, bool permission) async {
    emit(const AdminEmployeesState.loading());
    final result = await employeeRepo.setPlanPermission(
      supervisorId: supervisorId,
      permission: permission,
    );
    switch (result) {
      case Success():
        await loadEmployees();
        emit(const AdminEmployeesState.actionSuccess('Permission updated successfully'));
        return true;
      case Failure(:final failure):
        emit(AdminEmployeesState.error(failure.messageKey));
        return false;
      default:
        return false;
    }
  }
}
