import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/short_leave_request_body.dart';
import '../../domain/repos/leaves_repo.dart';
import 'permit_state.dart';

class PermitCubit extends Cubit<PermitState> {
  PermitCubit({required this.leavesRepo}) : super(const PermitState.initial());

  final LeavesRepo leavesRepo;

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
