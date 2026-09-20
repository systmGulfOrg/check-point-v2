import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:check_point_v2/core/network/api_result.dart';
import '../../data/repos/remote_work_repo.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/models/remote_work_request_model.dart';
import 'remote_work_state.dart';

class RemoteWorkCubit extends Cubit<RemoteWorkState> {
  RemoteWorkCubit({required this.repo})
    : super(const RemoteWorkState.initial());

  final RemoteWorkRepo repo;
  List<RemoteWorkPolicyModel> policies = const [];
  List<RemoteWorkRequestModel> requests = const [];

  Future<void> load() async {
    emit(const RemoteWorkState.loading());
    final results = await Future.wait([repo.getPolicies(), repo.getRequests()]);
    final policiesResult = results[0] as ApiResult<List<RemoteWorkPolicyModel>>;
    final requestsResult =
        results[1] as ApiResult<List<RemoteWorkRequestModel>>;
    if (policiesResult case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return;
    }
    if (requestsResult case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return;
    }
    policies = (policiesResult as Success<List<RemoteWorkPolicyModel>>).data;
    requests = (requestsResult as Success<List<RemoteWorkRequestModel>>).data;
    emit(RemoteWorkState.success(policies: policies, requests: requests));
  }

  Future<bool> createRequest({
    required String requestDate,
    String? policyId,
    String? reason,
  }) async {
    final result = await repo.createRequest(
      requestDate: requestDate,
      policyId: policyId,
      reason: reason,
    );
    if (result case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return false;
    }
    await load();
    return true;
  }

  Future<bool> updateStatus({
    required String id,
    required String status,
    String? reviewNote,
  }) async {
    final result = await repo.updateRequestStatus(
      id: id,
      status: status,
      reviewNote: reviewNote,
    );
    if (result case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return false;
    }
    await load();
    return true;
  }

  Future<bool> createPolicy({
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? start,
    String? end,
    int? allowedDelayTime,
    int? maxDays,
  }) async {
    final result = await repo.createPolicy(
      name: name,
      allowedDays: allowedDays,
      policyType: policyType,
      onsiteDays: onsiteDays,
      workingHoursStart: start,
      workingHoursEnd: end,
      allowedDelayTime: allowedDelayTime,
      maxDaysPerWeek: maxDays,
    );
    if (result case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return false;
    }
    await load();
    return true;
  }

  Future<void> deactivatePolicy(String id) async {
    final result = await repo.deactivatePolicy(id);
    if (result case Failure(:final failure)) {
      emit(RemoteWorkState.error(failure.messageKey));
      return;
    }
    await load();
  }
}
