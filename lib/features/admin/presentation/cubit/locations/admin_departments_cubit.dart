import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/network/api_result.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_request_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'admin_departments_state.dart';

class AdminDepartmentsCubit extends Cubit<AdminDepartmentsState> {
  AdminDepartmentsCubit({required this.locationsRepo})
    : super(const AdminDepartmentsState.initial());
  final AdminLocationsRepo locationsRepo;
  List<DepartmentModel> departments = const [];

  Future<void> load() async {
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.getDepartments();
    switch (result) {
      case Success(:final data):
        departments = data;
        emit(AdminDepartmentsState.success(data));
      case Failure(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return load();
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.searchDepartments(query.trim());
    switch (result) {
      case Success(:final data):
        emit(AdminDepartmentsState.success(data));
      case Failure(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }

  Future<void> addDepartment(DepartmentRequestModel request) async {
    final result = await locationsRepo.addDepartment(request);
    switch (result) {
      case Success():
        await load();
      case Failure(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }

  Future<void> editDepartment(int id, DepartmentRequestModel request) async {
    final result = await locationsRepo.editDepartment(id, request);
    switch (result) {
      case Success():
        await load();
      case Failure(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }

  Future<void> deleteDepartment(int id) async {
    final result = await locationsRepo.deleteDepartment(id);
    switch (result) {
      case Success():
        await load();
      case Failure(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }
}
