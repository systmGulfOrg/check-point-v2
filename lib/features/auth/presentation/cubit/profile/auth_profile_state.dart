import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_profile_state.freezed.dart';

@freezed
abstract class AuthProfileState with _$AuthProfileState {
  const factory AuthProfileState.initial() = AuthProfileInitial;
  const factory AuthProfileState.loading() = AuthProfileLoading;
  const factory AuthProfileState.success({
    required String name,
    required String userId,
    required String role,
    required String username,
  }) = AuthProfileSuccess;
  const factory AuthProfileState.error(String messageKey) = AuthProfileError;
}
