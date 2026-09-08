import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
part 'admin_departments_state.freezed.dart';

@freezed
abstract class AdminDepartmentsState with _$AdminDepartmentsState {
  const factory AdminDepartmentsState.initial() = AdminDepartmentsInitial;
  const factory AdminDepartmentsState.loading() = AdminDepartmentsLoading;
  const factory AdminDepartmentsState.success(
    List<DepartmentModel> departments,
  ) = AdminDepartmentsSuccess;
  const factory AdminDepartmentsState.error(String messageKey) =
      AdminDepartmentsError;
}
