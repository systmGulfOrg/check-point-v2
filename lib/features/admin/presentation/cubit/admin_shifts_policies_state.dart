import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/police_model.dart';
import '../../data/models/shift_model.dart';

part 'admin_shifts_policies_state.freezed.dart';

@freezed
abstract class AdminShiftsPoliciesState with _$AdminShiftsPoliciesState {
  const factory AdminShiftsPoliciesState.initial() = _Initial;
  const factory AdminShiftsPoliciesState.loading() = _Loading;
  const factory AdminShiftsPoliciesState.success({
    required List<ShiftModel> shifts,
    required List<PoliceModel> policies,
  }) = _Success;
  const factory AdminShiftsPoliciesState.actionSuccess(String message) =
      _ActionSuccess;
  const factory AdminShiftsPoliciesState.error(String messageKey) = _Error;
}
