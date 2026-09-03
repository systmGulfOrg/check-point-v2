import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_session_state.freezed.dart';

@freezed
abstract class AuthSessionState with _$AuthSessionState {
  const factory AuthSessionState.initial() = AuthSessionInitial;
  const factory AuthSessionState.loading() = AuthSessionLoading;
  const factory AuthSessionState.success() = AuthSessionSuccess;
  const factory AuthSessionState.error(String messageKey) = AuthSessionError;
}
