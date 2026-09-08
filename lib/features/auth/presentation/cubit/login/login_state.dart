import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/auth/data/models/login/login_response_model.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;
  const factory LoginState.loading() = LoginLoading;
  const factory LoginState.success(LoginResponseModel user) = LoginSuccess;
  const factory LoginState.error(String messageKey) = LoginError;
}
