import 'package:check_point_v2/core/bloc/safe_cubit.dart';

import '../../data/models/short_leave_request_body.dart';
import '../../domain/repos/leaves_repo.dart';
import 'permit_state.dart';

class PermitCubit extends SafeCubit<PermitState> {
  PermitCubit({required this.leavesRepo}) : super(const PermitState.initial());

  final LeavesRepo leavesRepo;

  Future<bool> submit(ShortLeaveRequestBody body) async {
    emit(const PermitState.submitting());
    final result = await leavesRepo.submitShortLeaveRequest(body);
    return result.when(
      success: (_) {
        safeEmit(const PermitState.success());
        return true;
      },
      failure: (failure) {
        safeEmit(PermitState.error(failure.messageKey));
        return false;
      },
    );
  }
}
