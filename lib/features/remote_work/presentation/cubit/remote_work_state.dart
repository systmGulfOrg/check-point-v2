import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/models/remote_work_request_model.dart';

part 'remote_work_state.freezed.dart';

@freezed
class RemoteWorkState with _$RemoteWorkState {
  const factory RemoteWorkState.initial() = _Initial;
  const factory RemoteWorkState.loading() = _Loading;
  const factory RemoteWorkState.success({
    required List<RemoteWorkPolicyModel> policies,
    required List<RemoteWorkRequestModel> requests,
  }) = _Success;
  const factory RemoteWorkState.error(String messageKey) = _Error;
}
