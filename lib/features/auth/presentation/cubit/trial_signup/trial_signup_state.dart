import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:check_point_v2/features/auth/data/models/trial_signup/trial_signup_model.dart';

part 'trial_signup_state.freezed.dart';

@freezed
abstract class TrialSignupState with _$TrialSignupState {
  const factory TrialSignupState.initial() = TrialSignupInitial;
  const factory TrialSignupState.loading() = TrialSignupLoading;
  const factory TrialSignupState.success(TrialSignupModel signup) =
      TrialSignupSuccess;
  const factory TrialSignupState.error(String messageKey) =
      TrialSignupError;
}
