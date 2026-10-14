import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import 'package:check_point_v2/features/admin/data/models/locations/department_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'admin_departments_state.dart';

class AdminDepartmentsCubit extends SafeCubit<AdminDepartmentsState> {
  AdminDepartmentsCubit({required this.locationsRepo})
    : super(const AdminDepartmentsState.initial());
  final AdminLocationsRepo locationsRepo;
  List<DepartmentModel> departments = const [];

  Future<void> load() async {
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.getDepartments();
    result.when(
      success: (data) {
        departments = data;
        safeEmit(AdminDepartmentsState.success(data));
      },
      failure: (failure) =>
          safeEmit(AdminDepartmentsState.error(failure.messageKey)),
    );
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return load();
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.searchDepartments(query.trim());
    result.when(
      success: (data) => safeEmit(AdminDepartmentsState.success(data)),
      failure: (failure) =>
          safeEmit(AdminDepartmentsState.error(failure.messageKey)),
    );
  }

  Future<void> addDepartment(DepartmentRequestModel request) async {
    final result = await locationsRepo.addDepartment(request);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          safeEmit(AdminDepartmentsState.error(failure.messageKey)),
    );
  }

  Future<void> editDepartment(int id, DepartmentRequestModel request) async {
    final result = await locationsRepo.editDepartment(id, request);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          safeEmit(AdminDepartmentsState.error(failure.messageKey)),
    );
  }

  Future<void> deleteDepartment(int id) async {
    final result = await locationsRepo.deleteDepartment(id);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          safeEmit(AdminDepartmentsState.error(failure.messageKey)),
    );
  }
}
