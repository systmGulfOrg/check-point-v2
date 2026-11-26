import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/company_approval_config_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/company_rules/admin_company_rules_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/company_rules/admin_company_rules_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permit_rules_content_widget.dart';

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
            success: (config) {
              _populateFromConfig(config);
              return AdminPermitRulesContentWidget(
                isUpdating: false,
                lateNoticeController: _lateNoticeController,
                earlyPercentController: _earlyPercentController,
                enforceLateNotice: _enforceLateNotice,
                enforceGracePeriod: _enforceGracePeriod,
                enforceEarlyDeparture: _enforceEarlyDeparture,
                allowWeekends: _allowWeekends,
                allowHolidays: _allowHolidays,
                forceCasualSameDay: _forceCasualSameDay,
                onLateNoticeChanged: (v) =>
                    setState(() => _enforceLateNotice = v),
                onGracePeriodChanged: (v) =>
                    setState(() => _enforceGracePeriod = v),
                onEarlyDepartureChanged: (v) =>
                    setState(() => _enforceEarlyDeparture = v),
                onAllowWeekendsChanged: (v) =>
                    setState(() => _allowWeekends = v),
                onAllowHolidaysChanged: (v) =>
                    setState(() => _allowHolidays = v),
                onForceCasualSameDayChanged: (v) =>
                    setState(() => _forceCasualSameDay = v),
                onSave: () => _save(config),
              );
            },
            updating: (currentConfig) {
              _populateFromConfig(currentConfig);
              return AdminPermitRulesContentWidget(
                isUpdating: true,
                lateNoticeController: _lateNoticeController,
                earlyPercentController: _earlyPercentController,
                enforceLateNotice: _enforceLateNotice,
                enforceGracePeriod: _enforceGracePeriod,
                enforceEarlyDeparture: _enforceEarlyDeparture,
                allowWeekends: _allowWeekends,
                allowHolidays: _allowHolidays,
                forceCasualSameDay: _forceCasualSameDay,
                onLateNoticeChanged: (v) =>
                    setState(() => _enforceLateNotice = v),
                onGracePeriodChanged: (v) =>
                    setState(() => _enforceGracePeriod = v),
                onEarlyDepartureChanged: (v) =>
                    setState(() => _enforceEarlyDeparture = v),
                onAllowWeekendsChanged: (v) =>
                    setState(() => _allowWeekends = v),
                onAllowHolidaysChanged: (v) =>
                    setState(() => _allowHolidays = v),
                onForceCasualSameDayChanged: (v) =>
                    setState(() => _forceCasualSameDay = v),
                onSave: () => _save(currentConfig),
              );
            },
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
}
