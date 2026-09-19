import 'package:freezed_annotation/freezed_annotation.dart';

part 'permit_state.freezed.dart';

@freezed
class PermitState with _$PermitState {
  const factory PermitState.initial() = PermitInitial;
  const factory PermitState.submitting() = PermitSubmitting;
  const factory PermitState.success() = PermitSuccess;
  const factory PermitState.error(String messageKey) = PermitError;
}
