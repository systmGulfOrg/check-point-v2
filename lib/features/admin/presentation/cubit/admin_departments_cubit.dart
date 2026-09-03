import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/department_response_model.dart';
import '../../data/repos/admin_locations_repo.dart';
import 'admin_departments_state.dart';

class AdminDepartmentsCubit extends Cubit<AdminDepartmentsState> {
  AdminDepartmentsCubit({required this.locationsRepo})
    : super(const AdminDepartmentsState.initial());
  final AdminLocationsRepo locationsRepo;

  Future<void> load() async {
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.getDepartments();
    switch (result) {
      case Success<List<DepartmentModel>>(:final data):
        emit(AdminDepartmentsState.success(data));
      case Failure<List<DepartmentModel>>(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty) return load();
    emit(const AdminDepartmentsState.loading());
    final result = await locationsRepo.searchDepartments(query.trim());
    switch (result) {
      case Success<List<DepartmentModel>>(:final data):
        emit(AdminDepartmentsState.success(data));
      case Failure<List<DepartmentModel>>(:final failure):
        emit(AdminDepartmentsState.error(failure.messageKey));
    }
  }
}
