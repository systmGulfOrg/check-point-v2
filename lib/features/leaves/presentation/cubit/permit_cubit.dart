import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/short_leave_request_body.dart';
import '../../data/repos/leaves_repo_impl.dart';
import 'permit_state.dart';

class PermitCubit extends Cubit<PermitState> {
  PermitCubit({required this.leavesRepo}) : super(const PermitState.initial());

  final LeavesRepoImpl leavesRepo;

  Future<bool> submit(ShortLeaveRequestBody body) async {
    emit(const PermitState.submitting());
    final result = await leavesRepo.submitShortLeaveRequest(body);
    return result.when(
      success: (_) {
        emit(const PermitState.success());
        return true;
      },
      failure: (failure) {
        emit(PermitState.error(failure.messageKey));
        return false;
      },
    );
  }
}
