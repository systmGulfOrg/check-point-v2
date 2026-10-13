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

    final loadedPolicies = policiesResult.when(
      success: (data) => data,
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return null;
      },
    );
    if (loadedPolicies == null) return;

    final loadedRequests = requestsResult.when(
      success: (data) => data,
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return null;
      },
    );
    if (loadedRequests == null) return;

    policies = loadedPolicies;
    requests = loadedRequests;
    emit(RemoteWorkState.success(policies: policies, requests: requests));
  }

  Future<bool> createRequest({
    required String requestDate,
    required String targetWorkSystem,
    String? policyId,
    String? reason,
  }) async {
    final result = await repo.createRequest(
      requestDate: requestDate,
      targetWorkSystem: targetWorkSystem,
      policyId: policyId,
      reason: reason,
    );
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return false;
      },
    );
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
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<bool> deleteRequest({required String id}) async {
    if (isClosed) return false;
    final result = await repo.deleteRequest(id: id);
    if (isClosed) return false;
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        if (!isClosed) emit(RemoteWorkState.error(failure.messageKey));
        return false;
      },
    );
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
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return false;
      },
    );
  }

  Future<void> deactivatePolicy(String id) async {
    final result = await repo.deactivatePolicy(id);
    await result.when(
      success: (_) async {
        await load();
      },
      failure: (failure) async {
        emit(RemoteWorkState.error(failure.messageKey));
      },
    );
  }

  Future<bool> updatePolicy({
    required String id,
    required String name,
    required List<String> allowedDays,
    required String policyType,
    List<String> onsiteDays = const [],
    String? start,
    String? end,
    int? allowedDelayTime,
    int? maxDays,
  }) async {
    final result = await repo.updatePolicy(
      id: id,
      name: name,
      allowedDays: allowedDays,
      policyType: policyType,
      onsiteDays: onsiteDays,
      workingHoursStart: start,
      workingHoursEnd: end,
      allowedDelayTime: allowedDelayTime,
      maxDaysPerWeek: maxDays,
    );
    return result.when(
      success: (_) async {
        await load();
        return true;
      },
      failure: (failure) {
        emit(RemoteWorkState.error(failure.messageKey));
        return false;
      },
    );
  }
}
