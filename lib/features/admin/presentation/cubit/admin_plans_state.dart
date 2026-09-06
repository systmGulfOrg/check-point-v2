import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/admin_plan_model.dart';

part 'admin_plans_state.freezed.dart';

@freezed
abstract class AdminPlansState with _$AdminPlansState {
  const factory AdminPlansState.initial() = _Initial;
  const factory AdminPlansState.loading() = _Loading;
  const factory AdminPlansState.success(List<AdminPlanModel> plans) = _Success;
  const factory AdminPlansState.actionSuccess(String message) = _ActionSuccess;
  const factory AdminPlansState.error(String messageKey) = _Error;
}
