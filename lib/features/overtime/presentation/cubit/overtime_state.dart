import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/overtime_request_model.dart';

part 'overtime_state.freezed.dart';

@freezed
class OvertimeState with _$OvertimeState {
  const factory OvertimeState.initial() = OvertimeStateInitial;
  const factory OvertimeState.loading() = OvertimeStateLoading;
  const factory OvertimeState.success({
    required List<OvertimeRequestModel> requests,
  }) = OvertimeStateSuccess;
  const factory OvertimeState.error(String messageKey) = OvertimeStateError;
}
