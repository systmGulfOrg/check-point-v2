import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permit_rules_number_field_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permit_rules_section_header_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_permit_rules_switch_card_widget.dart';

class AdminPermitRulesContentWidget extends StatelessWidget {
  const AdminPermitRulesContentWidget({
    required this.isUpdating,
    required this.lateNoticeController,
    required this.earlyPercentController,
    required this.enforceLateNotice,
    required this.enforceGracePeriod,
    required this.enforceEarlyDeparture,
    required this.allowWeekends,
    required this.allowHolidays,
    required this.forceCasualSameDay,
    required this.onLateNoticeChanged,
    required this.onGracePeriodChanged,
    required this.onEarlyDepartureChanged,
    required this.onAllowWeekendsChanged,
    required this.onAllowHolidaysChanged,
    required this.onForceCasualSameDayChanged,
    required this.onSave,
    super.key,
  });

  final bool isUpdating;
  final TextEditingController lateNoticeController;
  final TextEditingController earlyPercentController;
  final bool enforceLateNotice;
  final bool enforceGracePeriod;
  final bool enforceEarlyDeparture;
  final bool allowWeekends;
  final bool allowHolidays;
  final bool forceCasualSameDay;
  final ValueChanged<bool> onLateNoticeChanged;
  final ValueChanged<bool> onGracePeriodChanged;
  final ValueChanged<bool> onEarlyDepartureChanged;
  final ValueChanged<bool> onAllowWeekendsChanged;
  final ValueChanged<bool> onAllowHolidaysChanged;
  final ValueChanged<bool> onForceCasualSameDayChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
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
          AdminPermitRulesSectionHeaderWidget(
            title: 'admin.rules.lateArrivalHeader'.tr(),
          ),
          hSpace(8),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.lateArrivalNoticeTitle'.tr(),
            subtitle: 'admin.rules.lateArrivalNoticeSubtitle'.tr(),
            value: enforceLateNotice,
            onChanged: isUpdating ? null : onLateNoticeChanged,
          ),
          if (enforceLateNotice) ...[
            hSpace(8),
            AdminPermitRulesNumberFieldWidget(
              controller: lateNoticeController,
              label: 'admin.rules.noticeMinutesLabel'.tr(),
              suffix: 'common.minutes'.tr(),
              enabled: !isUpdating,
            ),
          ],
          hSpace(10),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.graceLimitTitle'.tr(),
            subtitle: 'admin.rules.graceLimitSubtitle'.tr(),
            value: enforceGracePeriod,
            onChanged: isUpdating ? null : onGracePeriodChanged,
          ),
          hSpace(20),

          // Section 2: Early Departure Rules
          AdminPermitRulesSectionHeaderWidget(
            title: 'admin.rules.earlyDepartureHeader'.tr(),
          ),
          hSpace(8),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.earlyDepartureRatioTitle'.tr(),
            subtitle: 'admin.rules.earlyDepartureRatioSubtitle'.tr(),
            value: enforceEarlyDeparture,
            onChanged: isUpdating ? null : onEarlyDepartureChanged,
          ),
          if (enforceEarlyDeparture) ...[
            hSpace(8),
            AdminPermitRulesNumberFieldWidget(
              controller: earlyPercentController,
              label: 'admin.rules.ratioPercentLabel'.tr(),
              suffix: '%',
              enabled: !isUpdating,
            ),
          ],
          hSpace(20),

          // Section 3: Holidays & Days Off
          AdminPermitRulesSectionHeaderWidget(
            title: 'admin.rules.workingDaysHeader'.tr(),
          ),
          hSpace(8),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.allowWeekendsTitle'.tr(),
            subtitle: 'admin.rules.allowWeekendsSubtitle'.tr(),
            value: allowWeekends,
            onChanged: isUpdating ? null : onAllowWeekendsChanged,
          ),
          hSpace(10),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.allowHolidaysTitle'.tr(),
            subtitle: 'admin.rules.allowHolidaysSubtitle'.tr(),
            value: allowHolidays,
            onChanged: isUpdating ? null : onAllowHolidaysChanged,
          ),
          hSpace(20),

          // Section 4: Leaves
          AdminPermitRulesSectionHeaderWidget(
            title: 'admin.rules.leavesHeader'.tr(),
          ),
          hSpace(8),
          AdminPermitRulesSwitchCardWidget(
            title: 'admin.rules.forceSameDayCasualTitle'.tr(),
            subtitle: 'admin.rules.forceSameDayCasualSubtitle'.tr(),
            value: forceCasualSameDay,
            onChanged: isUpdating ? null : onForceCasualSameDayChanged,
          ),
          hSpace(24),

          // Save button
          ElevatedButton(
            onPressed: isUpdating ? null : onSave,
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
}
