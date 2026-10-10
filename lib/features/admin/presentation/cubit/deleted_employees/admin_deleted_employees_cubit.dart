import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_deleted_employees_state.dart';

class AdminDeletedEmployeesCubit extends Cubit<AdminDeletedEmployeesState> {
  AdminDeletedEmployeesCubit({required this.employeeRepo})
    : super(const AdminDeletedEmployeesState.initial());

  final AdminEmployeeRepo employeeRepo;

  Future<void> load() async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.getDeletedEmployees();
    result.when(
      success: (data) =>
          emit(AdminDeletedEmployeesState.success(employees: data)),
      failure: (failure) =>
          emit(AdminDeletedEmployeesState.error(failure.messageKey)),
    );
  }

  Future<void> restore(String id) async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.restoreEmployee(id: id);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          emit(AdminDeletedEmployeesState.error(failure.messageKey)),
    );
  }

  Future<void> permanentDelete(String id) async {
    emit(const AdminDeletedEmployeesState.loading());
    final result = await employeeRepo.permanentDeleteEmployee(id: id);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          emit(AdminDeletedEmployeesState.error(failure.messageKey)),
    );
  }
}
