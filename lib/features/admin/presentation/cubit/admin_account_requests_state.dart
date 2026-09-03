import 'package:freezed_annotation/freezed_annotation.dart';

import '../../data/models/account_requests_response_model.dart';

part 'admin_account_requests_state.freezed.dart';

@freezed
abstract class AdminAccountRequestsState with _$AdminAccountRequestsState {
  const factory AdminAccountRequestsState.initial() =
      AdminAccountRequestsStateInitial;
  const factory AdminAccountRequestsState.loading() =
      AdminAccountRequestsStateLoading;
  const factory AdminAccountRequestsState.success(
    List<AccountRequestModel> requests,
  ) = AdminAccountRequestsStateSuccess;
  const factory AdminAccountRequestsState.error(String messageKey) =
      AdminAccountRequestsStateError;
}
