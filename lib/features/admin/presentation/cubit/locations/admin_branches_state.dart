import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
part 'admin_branches_state.freezed.dart';

@freezed
abstract class AdminBranchesState with _$AdminBranchesState {
  const factory AdminBranchesState.initial() = AdminBranchesInitial;
  const factory AdminBranchesState.loading() = AdminBranchesLoading;
  const factory AdminBranchesState.success(List<BranchModel> branches) =
      AdminBranchesSuccess;
  const factory AdminBranchesState.error(String messageKey) =
      AdminBranchesError;
}
