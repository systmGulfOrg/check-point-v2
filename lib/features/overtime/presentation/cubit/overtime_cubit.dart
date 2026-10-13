import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/overtime_repo.dart';
import '../../data/models/overtime_request_model.dart';
import 'overtime_state.dart';

class OvertimeCubit extends Cubit<OvertimeState> {
  OvertimeCubit({required this.repo}) : super(const OvertimeState.initial());
  final OvertimeRepo repo;
  List<OvertimeRequestModel> requests = const [];

  Future<void> load() async {
    if (isClosed) return;
    emit(const OvertimeState.loading());
    final result = await repo.getRequests();
    if (isClosed) return;
    result.when(
      success: (data) {
        requests = data;
        emit(OvertimeState.success(requests: data));
      },
      failure: (failure) => emit(OvertimeState.error(failure.messageKey)),
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
        if (!isClosed) emit(OvertimeState.error(failure.messageKey));
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
        if (!isClosed) emit(OvertimeState.error(failure.messageKey));
        return false;
      },
    );
  }
}
