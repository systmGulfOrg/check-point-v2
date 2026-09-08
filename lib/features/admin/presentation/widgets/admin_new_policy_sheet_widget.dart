import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminNewPolicySheetWidget extends StatefulWidget {
  const AdminNewPolicySheetWidget({super.key});

  @override
  State<AdminNewPolicySheetWidget> createState() =>
      _AdminNewPolicySheetWidgetState();
}

class _AdminNewPolicySheetWidgetState extends State<AdminNewPolicySheetWidget> {
  final policyNameController = TextEditingController();
  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();
  final graceController = TextEditingController();
  final selectedDays = <String>{'sun', 'mon', 'tue', 'wed', 'thu'};

  @override
  void dispose() {
    policyNameController.dispose();
    timeInController.dispose();
    timeOutController.dispose();
    graceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin.shifts.policies.newPolicy'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 20.r),
                  ),
                ],
              ),
              const Divider(color: AppColors.border),
              hSpace(14),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'admin.shifts.policies.nameLabel',
                hintKey: 'admin.shifts.policies.nameHint',
                controller: policyNameController,
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.shifts.policies.timeInLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: timeInController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          timeInController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.shifts.policies.timeOutLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: timeOutController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (time != null && context.mounted) {
                          timeOutController.text = time.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              hSpace(16),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'admin.shifts.policies.graceLabel',
                hintKey: 'admin.shifts.policies.graceHint',
                controller: graceController,
              ),
              hSpace(16),
              Text(
                'admin.shifts.policies.workingDays'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: [
                  for (final day in const [
                    'sun',
                    'mon',
                    'tue',
                    'wed',
                    'thu',
                    'fri',
                    'sat',
                  ])
                    InkWell(
                      onTap: () => setState(() {
                        if (selectedDays.contains(day)) {
                          selectedDays.remove(day);
                        } else {
                          selectedDays.add(day);
                        }
                      }),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: selectedDays.contains(day)
                              ? AppColors.brandPrimary
                              : AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'admin.shifts.days.$day'.tr(context: context),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: selectedDays.contains(day)
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.create.cancel'.tr(
                        context: context,
                      ),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.locations.create.save'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
