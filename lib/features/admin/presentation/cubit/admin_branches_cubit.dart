import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api_result.dart';
import '../../data/models/branch_response_model.dart';
import '../../data/models/branch_request_model.dart';
import '../../data/repos/admin_locations_repo.dart';
import 'admin_branches_state.dart';

class AdminBranchesCubit extends Cubit<AdminBranchesState> {
  AdminBranchesCubit({required this.locationsRepo})
    : super(const AdminBranchesState.initial());
  final AdminLocationsRepo locationsRepo;

  Future<void> load() async {
    emit(const AdminBranchesState.loading());
    final result = await locationsRepo.getBranches();
    switch (result) {
      case Success<List<BranchModel>>(:final data):
        emit(AdminBranchesState.success(data));
      case Failure<List<BranchModel>>(:final failure):
        emit(AdminBranchesState.error(failure.messageKey));
    }
  }

  Future<void> delete(int id) async {
    final result = await locationsRepo.deleteBranch(id: id);
    switch (result) {
      case Success<void>():
        await load();
      case Failure<void>(:final failure):
        emit(AdminBranchesState.error(failure.messageKey));
    }
  }

  Future<void> add(BranchRequestModel request) async {
    final result = await locationsRepo.addBranch(request);
    switch (result) {
      case Success<void>():
        await load();
      case Failure<void>(:final failure):
        emit(AdminBranchesState.error(failure.messageKey));
    }
  }

  Future<void> edit({
    required int id,
    required BranchRequestModel request,
  }) async {
    final result = await locationsRepo.editBranch(id: id, request: request);
    switch (result) {
      case Success<void>():
        await load();
      case Failure<void>(:final failure):
        emit(AdminBranchesState.error(failure.messageKey));
    }
  }
}
