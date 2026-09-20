import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class RemoteWorkPolicySheetWidget extends StatefulWidget {
  const RemoteWorkPolicySheetWidget({
    required this.initialPolicyType,
    super.key,
  });

  final String initialPolicyType;

  @override
  State<RemoteWorkPolicySheetWidget> createState() =>
      _RemoteWorkPolicySheetWidgetState();
}

class _RemoteWorkPolicySheetWidgetState
    extends State<RemoteWorkPolicySheetWidget> {
  final nameController = TextEditingController();
  final startController = TextEditingController(text: '09:00');
  final endController = TextEditingController(text: '17:00');
  final graceController = TextEditingController(text: '15');
  final remoteDays = <String>{
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  };
  final onsiteDays = <String>{'Friday', 'Saturday'};
  late String policyType;
  bool isSubmitting = false;

  static const dayKeys = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
  ];

  static const dayTranslationKeys = {
    'Sunday': 'sun',
    'Monday': 'mon',
    'Tuesday': 'tue',
    'Wednesday': 'wed',
    'Thursday': 'thu',
    'Friday': 'fri',
    'Saturday': 'sat',
  };

  @override
  void initState() {
    super.initState();
    policyType = widget.initialPolicyType;
  }

  @override
  void dispose() {
    nameController.dispose();
    startController.dispose();
    endController.dispose();
    graceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isHybrid = policyType == 'hybrid';
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
                    'remoteWork.addPolicy'.tr(context: context),
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
              Text(
                (isHybrid
                        ? 'remoteWork.hybridPolicy'
                        : 'remoteWork.remotePolicy')
                    .tr(context: context),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: isHybrid ? AppColors.info : AppColors.brandPrimary,
                ),
              ),
              hSpace(14),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'remoteWork.policyName',
                hintKey: isHybrid
                    ? 'remoteWork.hybridPolicyHint'
                    : 'remoteWork.remotePolicyHint',
                controller: nameController,
              ),
              hSpace(16),
              Row(
                children: [
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.shifts.policies.timeInLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: startController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 9, minute: 0),
                        );
                        if (time != null && context.mounted) {
                          startController.text =
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                        }
                      },
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.shifts.policies.timeOutLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: endController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 17, minute: 0),
                        );
                        if (time != null && context.mounted) {
                          endController.text =
                              '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
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
                'remoteWork.remoteDays'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              hSpace(8),
              Wrap(
                spacing: 6.w,
                runSpacing: 6.h,
                children: [
                  for (final day in dayKeys)
                    InkWell(
                      onTap: () => setState(() {
                        if (remoteDays.contains(day)) {
                          remoteDays.remove(day);
                        } else {
                          remoteDays.add(day);
                        }
                      }),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: remoteDays.contains(day)
                              ? AppColors.brandPrimary
                              : AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'admin.shifts.days.${dayTranslationKeys[day]}'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font11Medium.copyWith(
                            color: remoteDays.contains(day)
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              if (isHybrid) ...[
                hSpace(16),
                Text(
                  'remoteWork.onsiteDays'.tr(context: context),
                  style: AppTextStyles.font12Medium,
                ),
                hSpace(8),
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: [
                    for (final day in dayKeys)
                      InkWell(
                        onTap: () => setState(() {
                          if (onsiteDays.contains(day)) {
                            onsiteDays.remove(day);
                          } else {
                            onsiteDays.add(day);
                          }
                        }),
                        borderRadius: BorderRadius.circular(8.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 7.h,
                          ),
                          decoration: BoxDecoration(
                            color: onsiteDays.contains(day)
                                ? AppColors.info
                                : AppColors.pageBackground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'admin.shifts.days.${dayTranslationKeys[day]}'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font11Medium.copyWith(
                              color: onsiteDays.contains(day)
                                  ? AppColors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'common.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(context),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'common.save'.tr(context: context),
                      isLoading: isSubmitting,
                      onTap: () async {
                        if (remoteDays.isEmpty ||
                            (isHybrid && onsiteDays.isEmpty)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'remoteWork.daysRequired'.tr(context: context),
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }
                        setState(() => isSubmitting = true);
                        final saved = await context
                            .read<RemoteWorkCubit>()
                            .createPolicy(
                              name: nameController.text.trim().isEmpty
                                  ? (isHybrid
                                        ? 'remoteWork.hybridPolicy'.tr(
                                            context: context,
                                          )
                                        : 'remoteWork.remotePolicy'.tr(
                                            context: context,
                                          ))
                                  : nameController.text.trim(),
                              policyType: policyType,
                              allowedDays: remoteDays.toList(),
                              onsiteDays: isHybrid
                                  ? onsiteDays.toList()
                                  : const [],
                              start: startController.text.trim(),
                              end: endController.text.trim(),
                              allowedDelayTime: int.tryParse(
                                graceController.text.trim(),
                              ),
                            );
                        if (!context.mounted) return;
                        if (saved) Navigator.pop(context);
                        setState(() => isSubmitting = false);
                      },
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
