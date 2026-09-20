import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/remote_work/data/models/remote_work_policy_model.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class RemoteWorkPolicySheetWidget extends StatefulWidget {
  const RemoteWorkPolicySheetWidget({
    required this.initialPolicyType,
    this.existingPolicy,
    super.key,
  });

  final String initialPolicyType;
  final RemoteWorkPolicyModel? existingPolicy;

  @override
  State<RemoteWorkPolicySheetWidget> createState() =>
      _RemoteWorkPolicySheetWidgetState();
}

class _RemoteWorkPolicySheetWidgetState
    extends State<RemoteWorkPolicySheetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController startController;
  late final TextEditingController endController;
  late final TextEditingController graceController;
  final remoteDays = <String>{};
  final onsiteDays = <String>{};
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
    final p = widget.existingPolicy;
    policyType = p?.effectivePolicyType ?? widget.initialPolicyType;

    nameController = TextEditingController(text: p?.name ?? '');
    startController = TextEditingController(
      text: p?.workingHoursStart ?? '09:00',
    );
    endController = TextEditingController(text: p?.workingHoursEnd ?? '17:00');
    graceController = TextEditingController(
      text: (p?.allowedDelayTime ?? 15).toString(),
    );

    if (p != null) {
      remoteDays.addAll(p.allowedDays);
      onsiteDays.addAll(p.onsiteDays);
    } else {
      if (policyType == 'onsite') {
        onsiteDays.addAll(['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday']);
      } else if (policyType == 'hybrid') {
        remoteDays.addAll(['Sunday', 'Tuesday', 'Thursday']);
        onsiteDays.addAll(['Monday', 'Wednesday']);
      } else {
        remoteDays.addAll(['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday']);
      }
    }
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
    final isEditing = widget.existingPolicy != null;
    final isHybrid = policyType == 'hybrid';
    final isOnsite = policyType == 'onsite';

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
                    isEditing
                        ? 'remoteWork.editPolicy'.tr(context: context)
                        : 'remoteWork.addPolicy'.tr(context: context),
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
                isOnsite
                    ? 'remoteWork.onsitePolicy'.tr(context: context)
                    : (isHybrid
                        ? 'remoteWork.hybridPolicy'.tr(context: context)
                        : 'remoteWork.remotePolicy'.tr(context: context)),
                style: AppTextStyles.font14SemiBold.copyWith(
                  color: isOnsite
                      ? AppColors.brandPrimary
                      : (isHybrid ? AppColors.info : AppColors.brandPrimary),
                ),
              ),
              hSpace(14),
              SupervisorCreateTaskFieldWidget(
                labelKey: 'remoteWork.policyName',
                hintKey: isOnsite
                    ? 'remoteWork.onsitePolicyHint'
                    : (isHybrid
                        ? 'remoteWork.hybridPolicyHint'
                        : 'remoteWork.remotePolicyHint'),
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
              if (!isOnsite) ...[
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
              ],
              if (isHybrid || isOnsite) ...[
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
                        if (!isOnsite && remoteDays.isEmpty) {
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
                        if (isHybrid && onsiteDays.isEmpty) {
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
                        final cubit = context.read<RemoteWorkCubit>();
                        final name = nameController.text.trim().isEmpty
                            ? (isOnsite
                                ? 'remoteWork.onsitePolicy'.tr(context: context)
                                : (isHybrid
                                    ? 'remoteWork.hybridPolicy'.tr(context: context)
                                    : 'remoteWork.remotePolicy'.tr(context: context)))
                            : nameController.text.trim();

                        final defaultDays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday'];
                        final effectiveAllowedDays = isOnsite
                            ? (onsiteDays.isNotEmpty ? onsiteDays.toList() : defaultDays)
                            : remoteDays.toList();
                        final effectiveOnsiteDays = (isOnsite || isHybrid)
                            ? (onsiteDays.isNotEmpty ? onsiteDays.toList() : defaultDays)
                            : <String>[];

                        final bool saved;
                        if (isEditing) {
                          saved = await cubit.updatePolicy(
                            id: widget.existingPolicy!.id,
                            name: name,
                            policyType: policyType,
                            allowedDays: effectiveAllowedDays,
                            onsiteDays: effectiveOnsiteDays,
                            start: startController.text.trim(),
                            end: endController.text.trim(),
                            allowedDelayTime: int.tryParse(
                              graceController.text.trim(),
                            ),
                          );
                        } else {
                          saved = await cubit.createPolicy(
                            name: name,
                            policyType: policyType,
                            allowedDays: effectiveAllowedDays,
                            onsiteDays: effectiveOnsiteDays,
                            start: startController.text.trim(),
                            end: endController.text.trim(),
                            allowedDelayTime: int.tryParse(
                              graceController.text.trim(),
                            ),
                          );
                        }

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
