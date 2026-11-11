import 'package:check_point_v2/core/bloc/safe_cubit.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/company_approval_config_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_shifts_policies_repo.dart';
import 'admin_company_rules_state.dart';

class AdminCompanyRulesCubit extends SafeCubit<AdminCompanyRulesState> {
  AdminCompanyRulesCubit({
    required this.shiftsPoliciesRepo,
  }) : super(const AdminCompanyRulesState.initial());

  final AdminShiftsPoliciesRepo shiftsPoliciesRepo;

  Future<void> load() async {
    emit(const AdminCompanyRulesState.loading());
    final result = await shiftsPoliciesRepo.getApprovalConfig();
    result.when(
      success: (config) => safeEmit(AdminCompanyRulesState.success(config)),
      failure: (failure) =>
          safeEmit(AdminCompanyRulesState.error(failure.messageKey)),
    );
  }

  Future<bool> updateRules(CompanyApprovalConfigModel newConfig) async {
    final current = state.maybeWhen(
      success: (c) => c,
      orElse: () => newConfig,
    );
    safeEmit(AdminCompanyRulesState.updating(current));
    final result = await shiftsPoliciesRepo.updateApprovalConfig(newConfig);
    return result.when(
      success: (savedConfig) {
        safeEmit(AdminCompanyRulesState.success(savedConfig));
        return true;
      },
      failure: (failure) {
        safeEmit(AdminCompanyRulesState.error(failure.messageKey));
        return false;
      },
    );
  }
}
