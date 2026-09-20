import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/auth/data/models/account_request/account_request_status_model.dart';

part 'request_account_status_state.freezed.dart';

@freezed
abstract class RequestAccountStatusState with _$RequestAccountStatusState {
  const factory RequestAccountStatusState.initial() =
      RequestAccountStatusInitial;
  const factory RequestAccountStatusState.loading() =
      RequestAccountStatusLoading;
  const factory RequestAccountStatusState.success(
    AccountRequestStatusModel? request,
  ) = RequestAccountStatusSuccess;
  const factory RequestAccountStatusState.error(String messageKey) =
      RequestAccountStatusError;
}
