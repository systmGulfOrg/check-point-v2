import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/network/api_result.dart';
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
    final result = await employeeRepo.getEmployees(page: 0, pageSize: 20);
    switch (result) {
      case Success<List<EmployeeModel>>(:final data):
        allEmployees = data;
        emit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      case Failure<List<EmployeeModel>>(:final failure):
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
      case Success<List<EmployeeModel>>(:final data):
        allEmployees = data;
        emit(
          AdminEmployeesState.success(
            employees: _filteredEmployees,
            roleFilter: roleFilter,
          ),
        );
      case Failure<List<EmployeeModel>>(:final failure):
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
}
