import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_request_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'admin_branches_state.dart';

class AdminBranchesCubit extends SafeCubit<AdminBranchesState> {
  AdminBranchesCubit({required this.locationsRepo})
    : super(const AdminBranchesState.initial());
  final AdminLocationsRepo locationsRepo;

  Future<void> load() async {
    emit(const AdminBranchesState.loading());
    final result = await locationsRepo.getBranches();
    result.when(
      success: (data) => safeEmit(AdminBranchesState.success(data)),
      failure: (failure) =>
          safeEmit(AdminBranchesState.error(failure.messageKey)),
    );
  }

  Future<void> delete(int id) async {
    final result = await locationsRepo.deleteBranch(id);
    await result.when(
      success: (_) async => await load(),
      failure: (failure) async =>
          safeEmit(AdminBranchesState.error(failure.messageKey)),
    );
  }

  Future<bool> add(BranchRequestModel request) async {
    final result = await locationsRepo.addBranch(request);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminBranchesState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> edit({
    required int id,
    required BranchRequestModel request,
  }) async {
    final result = await locationsRepo.editBranch(id, request);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(AdminBranchesState.error(failure.messageKey));
        return false;
      },
    );
  }
}
