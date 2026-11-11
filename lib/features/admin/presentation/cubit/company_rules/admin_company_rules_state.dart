import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/company_approval_config_model.dart';

part 'admin_company_rules_state.freezed.dart';

@freezed
class AdminCompanyRulesState with _$AdminCompanyRulesState {
  const factory AdminCompanyRulesState.initial() = _Initial;
  const factory AdminCompanyRulesState.loading() = _Loading;
  const factory AdminCompanyRulesState.success(
    CompanyApprovalConfigModel config,
  ) = _Success;
  const factory AdminCompanyRulesState.updating(
    CompanyApprovalConfigModel currentConfig,
  ) = _Updating;
  const factory AdminCompanyRulesState.error(String messageKey) = _Error;
}
