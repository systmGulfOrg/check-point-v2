import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_account_state.freezed.dart';

@freezed
abstract class RequestAccountState with _$RequestAccountState {
  const factory RequestAccountState.initial() = RequestAccountInitial;
  const factory RequestAccountState.loading() = RequestAccountLoading;
  const factory RequestAccountState.success() = RequestAccountSuccess;
  const factory RequestAccountState.error(String messageKey) =
      RequestAccountError;
}
