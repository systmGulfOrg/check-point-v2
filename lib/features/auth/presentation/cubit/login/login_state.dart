import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(
    LoginResponseModel user, {
    String? selectedRole,
  }) = LoginSuccess;
  const factory LoginState.error(String messageKey) = LoginError;
  const factory LoginState.deviceTransferRequired() =
      LoginDeviceTransferRequired;
  const factory LoginState.accountLocked({
    @Default(15) int lockoutMinutes,
    @Default('errors.accountLocked') String messageKey,
  }) = LoginAccountLocked;
  const factory LoginState.outsideZone({
    @Default('auth.login.outsideZoneMessage') String messageKey,
    String? siteName,
    String? rawMessage,
  }) = LoginOutsideZone;
}
