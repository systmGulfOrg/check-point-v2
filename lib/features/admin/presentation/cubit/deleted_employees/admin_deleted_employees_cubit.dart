import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_deleted_employees_state.dart';

class AdminDeletedEmployeesCubit extends Cubit<AdminDeletedEmployeesState> {
  AdminDeletedEmployeesCubit({required this.employeeRepo})
    : super(const AdminDeletedEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;

  Future<void> load() async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.getDeletedEmployees();
    switch (result) {
      case Success(:final data):
        emit(AdminDeletedEmployeesState.success(employees: data));
      case Failure(:final failure):
        emit(AdminDeletedEmployeesState.error(failure.messageKey));
    }
  }

  Future<void> restore(String id) async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.restoreEmployee(id: id);
    switch (result) {
      case Success():
        await load();
      case Failure(:final failure):
        emit(AdminDeletedEmployeesState.error(failure.messageKey));
    }
  }

  Future<void> permanentDelete(String id) async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.permanentDeleteEmployee(id: id);
    switch (result) {
      case Success():
        await load();
      case Failure(:final failure):
        emit(AdminDeletedEmployeesState.error(failure.messageKey));
    }
  }
}
