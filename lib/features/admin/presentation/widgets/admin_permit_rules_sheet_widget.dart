import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/company_approval_config_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/company_rules/admin_company_rules_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/company_rules/admin_company_rules_state.dart';

class AdminPermitRulesSheetWidget extends StatefulWidget {
  const AdminPermitRulesSheetWidget({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider<AdminCompanyRulesCubit>(
        create: (_) => sl<AdminCompanyRulesCubit>()..load(),
        child: const AdminPermitRulesSheetWidget(),
      ),
    );
  }

  @override
  State<AdminPermitRulesSheetWidget> createState() =>
      _AdminPermitRulesSheetWidgetState();
}

class _AdminPermitRulesSheetWidgetState
    extends State<AdminPermitRulesSheetWidget> {
  late final TextEditingController _lateNoticeController;
  late final TextEditingController _earlyPercentController;

  bool _enforceLateNotice = false;
  bool _enforceGracePeriod = false;
  bool _enforceEarlyDeparture = false;
  bool _allowWeekends = true;
  bool _allowHolidays = true;
  bool _forceCasualSameDay = false;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _lateNoticeController = TextEditingController(text: '60');
    _earlyPercentController = TextEditingController(text: '50');
  }

  @override
  void dispose() {
    _lateNoticeController.dispose();
    _earlyPercentController.dispose();
    super.dispose();
  }

  void _populateFromConfig(CompanyApprovalConfigModel config) {
    if (_initialized) return;
    _initialized = true;
    _enforceLateNotice = config.enforceLateArrivalNoticeDeadline;
    _lateNoticeController.text = config.lateArrivalNoticeMinutes.toString();
    _enforceGracePeriod = config.enforceGracePeriodForLateArrival;
    _enforceEarlyDeparture = config.enforceEarlyDepartureDeadline;
    _earlyPercentController.text =
        config.earlyDepartureDeadlinePercent.toString();
    _allowWeekends = config.allowPermitsOnWeekends;
    _allowHolidays = config.allowPermitsOnHolidays;
    _forceCasualSameDay = config.forceSameDayCasualLeave;
  }

  Future<void> _save(CompanyApprovalConfigModel currentConfig) async {
    final cubit = context.read<AdminCompanyRulesCubit>();
    final lateNoticeMins = int.tryParse(_lateNoticeController.text) ?? 60;
    final earlyPercent = int.tryParse(_earlyPercentController.text) ?? 50;

    final updated = currentConfig.copyWith(
      enforceLateArrivalNoticeDeadline: _enforceLateNotice,
      lateArrivalNoticeMinutes: lateNoticeMins > 0 ? lateNoticeMins : 60,
      enforceGracePeriodForLateArrival: _enforceGracePeriod,
      enforceEarlyDepartureDeadline: _enforceEarlyDeparture,
      earlyDepartureDeadlinePercent:
          earlyPercent > 0 && earlyPercent <= 100 ? earlyPercent : 50,
      allowPermitsOnWeekends: _allowWeekends,
      allowPermitsOnHolidays: _allowHolidays,
      forceSameDayCasualLeave: _forceCasualSameDay,
    );

    final success = await cubit.updateRules(updated);
    if (success && mounted) {
      CustomSnackBar.showSuccess(
        context,
        message: 'admin.rules.savedSuccess'.tr(),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.88,
      ),
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: BlocConsumer<AdminCompanyRulesCubit, AdminCompanyRulesState>(
        listener: (context, state) {
          state.whenOrNull(
            error: (messageKey) {
              CustomSnackBar.showError(
                context,
                message: messageKey.tr(),
              );
            },
          );
        },
        builder: (context, state) {
          return state.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
            success: (config) =>
                _buildContent(context, config, isUpdating: false),
            updating: (currentConfig) =>
                _buildContent(context, currentConfig, isUpdating: true),
            error: (messageKey) => Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline_rounded,
                      color: AppColors.error, size: 40.r),
                  hSpace(12),
                  Text(
                    messageKey.tr(),
                    style: AppTextStyles.font14Regular,
                    textAlign: TextAlign.center,
                  ),
                  hSpace(16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<AdminCompanyRulesCubit>().load(),
                    child: Text('common.retry'.tr()),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    CompanyApprovalConfigModel config, {
    required bool isUpdating,
  }) {
    _populateFromConfig(config);

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.tune_rounded,
                  color: AppColors.brandPrimary,
                  size: 24.r,
                ),
              ),
              wSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'admin.rules.title'.tr(),
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      'admin.rules.subtitle'.tr(),
                      style: AppTextStyles.font11Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
                color: AppColors.textSecondary,
              ),
            ],
          ),
          hSpace(20),

          // Section 1: Late Arrival Rules
          _buildSectionHeader('admin.rules.lateArrivalHeader'.tr()),
          hSpace(8),
          _buildSwitchCard(
            title: 'admin.rules.lateArrivalNoticeTitle'.tr(),
            subtitle: 'admin.rules.lateArrivalNoticeSubtitle'.tr(),
            value: _enforceLateNotice,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _enforceLateNotice = v),
          ),
          if (_enforceLateNotice) ...[
            hSpace(8),
            _buildNumberField(
              controller: _lateNoticeController,
              label: 'admin.rules.noticeMinutesLabel'.tr(),
              suffix: 'common.minutes'.tr(),
              enabled: !isUpdating,
            ),
          ],
          hSpace(10),
          _buildSwitchCard(
            title: 'admin.rules.graceLimitTitle'.tr(),
            subtitle: 'admin.rules.graceLimitSubtitle'.tr(),
            value: _enforceGracePeriod,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _enforceGracePeriod = v),
          ),
          hSpace(20),

          // Section 2: Early Departure Rules
          _buildSectionHeader('admin.rules.earlyDepartureHeader'.tr()),
          hSpace(8),
          _buildSwitchCard(
            title: 'admin.rules.earlyDepartureRatioTitle'.tr(),
            subtitle: 'admin.rules.earlyDepartureRatioSubtitle'.tr(),
            value: _enforceEarlyDeparture,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _enforceEarlyDeparture = v),
          ),
          if (_enforceEarlyDeparture) ...[
            hSpace(8),
            _buildNumberField(
              controller: _earlyPercentController,
              label: 'admin.rules.ratioPercentLabel'.tr(),
              suffix: '%',
              enabled: !isUpdating,
            ),
          ],
          hSpace(20),

          // Section 3: Holidays & Days Off
          _buildSectionHeader('admin.rules.workingDaysHeader'.tr()),
          hSpace(8),
          _buildSwitchCard(
            title: 'admin.rules.allowWeekendsTitle'.tr(),
            subtitle: 'admin.rules.allowWeekendsSubtitle'.tr(),
            value: _allowWeekends,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _allowWeekends = v),
          ),
          hSpace(10),
          _buildSwitchCard(
            title: 'admin.rules.allowHolidaysTitle'.tr(),
            subtitle: 'admin.rules.allowHolidaysSubtitle'.tr(),
            value: _allowHolidays,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _allowHolidays = v),
          ),
          hSpace(20),

          // Section 4: Leaves
          _buildSectionHeader('admin.rules.leavesHeader'.tr()),
          hSpace(8),
          _buildSwitchCard(
            title: 'admin.rules.forceSameDayCasualTitle'.tr(),
            subtitle: 'admin.rules.forceSameDayCasualSubtitle'.tr(),
            value: _forceCasualSameDay,
            onChanged: isUpdating
                ? null
                : (v) => setState(() => _forceCasualSameDay = v),
          ),
          hSpace(24),

          // Save button
          ElevatedButton(
            onPressed: isUpdating ? null : () => _save(config),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.brandPrimary,
              foregroundColor: AppColors.white,
              padding: EdgeInsets.symmetric(vertical: 14.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isUpdating
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.white),
                    ),
                  )
                : Text(
                    'admin.rules.saveButton'.tr(),
                    style: AppTextStyles.font14Bold.copyWith(
                      color: AppColors.white,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppTextStyles.font13SemiBold.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildSwitchCard({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool>? onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.font13Medium.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                hSpace(2),
                Text(
                  subtitle,
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          wSpace(12),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeTrackColor: AppColors.brandPrimary,
            activeThumbColor: AppColors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildNumberField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required bool enabled,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.font12Medium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          wSpace(12),
          SizedBox(
            width: 70.w,
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: AppTextStyles.font13SemiBold,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                suffixText: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
