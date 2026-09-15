import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/leave_request_body.dart';
import '../../data/repos/leaves_repo_impl.dart';
import 'leaves_state.dart';

class LeavesCubit extends Cubit<LeavesState> {
  LeavesCubit({required this.leavesRepo}) : super(const LeavesState.initial());
  
  final LeavesRepoImpl leavesRepo;

  Future<void> loadLeavesData() async {
    emit(const LeavesState.loading());
    
    final balancesResult = await leavesRepo.getLeaveBalances();
    final typesResult = await leavesRepo.getLeaveTypes();

    balancesResult.when(
      success: (balances) {
        typesResult.when(
          success: (types) => emit(LeavesState.success(balances, types)),
          failure: (f) => emit(LeavesState.error(f.messageKey)),
        );
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
  }

  Future<void> submitLeave(LeaveRequestBody body) async {
    emit(const LeavesState.submitting());
    final result = await leavesRepo.submitLeaveRequest(body);
    result.when(
      success: (_) {
        emit(const LeavesState.submitSuccess());
        loadLeavesData();
      },
      failure: (f) => emit(LeavesState.error(f.messageKey)),
    );
  }
}
