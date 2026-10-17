import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import '../../data/repos/overtime_repo.dart';
import '../../data/models/overtime_request_model.dart';
import 'overtime_state.dart';

class OvertimeCubit extends SafeCubit<OvertimeState> {
  OvertimeCubit({required this.repo}) : super(const OvertimeState.initial());
  final OvertimeRepo repo;
  List<OvertimeRequestModel> requests = const [];

  Future<void> load() async {
    emit(const OvertimeState.loading());
    final result = await repo.getRequests();
    if (isClosed) return;
    result.when(
      success: (data) {
        requests = data;
        safeEmit(OvertimeState.success(requests: data));
      },
      failure: (failure) => safeEmit(OvertimeState.error(failure.messageKey)),
    );
  }

  Future<bool> create({
    required String requestDate,
    required String startTime,
    required String endTime,
    String? reason,
  }) async {
    final result = await repo.createRequest(
      requestDate: requestDate,
      startTime: startTime,
      endTime: endTime,
      reason: reason,
    );
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(OvertimeState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> review({
    required String id,
    required String status,
    String? reviewNote,
  }) async {
    final result = await repo.updateStatus(
      id: id,
      status: status,
      reviewNote: reviewNote,
    );
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(OvertimeState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteRequest({required String id}) async {
    final result = await repo.deleteRequest(id: id);
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        safeEmit(OvertimeState.error(failure.messageKey));
        return false;
      },
    );
  }
}
