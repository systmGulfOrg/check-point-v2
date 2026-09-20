import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/police_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_create_task_field_widget.dart';

class AdminNewPolicySheetWidget extends StatefulWidget {
  const AdminNewPolicySheetWidget({this.shiftId, super.key});

  final int? shiftId;

  @override
  State<AdminNewPolicySheetWidget> createState() =>
      _AdminNewPolicySheetWidgetState();
}

class _AdminNewPolicySheetWidgetState extends State<AdminNewPolicySheetWidget> {
  final policyNameController = TextEditingController();
  final timeInController = TextEditingController();
  final timeOutController = TextEditingController();
  final graceController = TextEditingController();
  int? _selectedShiftId;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _selectedShiftId = widget.shiftId;
    timeInController.text = '09:00';
    timeOutController.text = '17:00';
    graceController.text = '15';
  }

  @override
  void dispose() {
    policyNameController.dispose();
    timeInController.dispose();
    timeOutController.dispose();
    graceController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final effectiveShiftId = _selectedShiftId ?? widget.shiftId;
    if (effectiveShiftId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('admin.shifts.selectShift'.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final name = policyNameController.text.trim();
    final timeIn = timeInController.text.trim();
    final timeOut = timeOutController.text.trim();
    final grace = int.tryParse(graceController.text.trim()) ?? 0;

    if (timeIn.isEmpty || timeOut.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errors.unknown'.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final body = AddPoliceRequestBody(
      shiftId: effectiveShiftId,
      policyName: name.isEmpty ? 'Policy' : name,
      workDays: const [],
      startTime: timeIn,
      endTime: timeOut,
      allowedDelayTime: grace,
      allowedEarlyLeaveTime: 0,
    );

    final success = await context.read<AdminShiftsPoliciesCubit>().addPolicy(
      body,
    );

    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'admin.shifts.policies.createSuccess'.tr(context: context),
          ),
          backgroundColor: AppColors.success,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('errors.adminActionFailed'.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
    }
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
              if (widget.shiftId == null) ...[
                BlocBuilder<AdminShiftsPoliciesCubit, AdminShiftsPoliciesState>(
                  builder: (context, state) {
                    final shifts = state.maybeWhen(
                      success: (shifts, _) => shifts,
                      orElse: () => const [],
                    );
                    if (shifts.isEmpty) return const SizedBox.shrink();
                    if (_selectedShiftId == null && shifts.isNotEmpty) {
                      _selectedShiftId = shifts.first.id;
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.shifts.title'.tr(context: context),
                          style: AppTextStyles.font12Medium,
                        ),
                        hSpace(6),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.border),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              value: _selectedShiftId,
                              isExpanded: true,
                              items: shifts
                                  .where((s) => s.id != null)
                                  .map(
                                    (s) => DropdownMenuItem<int>(
                                      value: s.id,
                                      child: Text(s.name ?? 'Shift #${s.id}'),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _selectedShiftId = val);
                                }
                              },
                            ),
                          ),
                        ),
                        hSpace(14),
                      ],
                    );
                  },
                ),
              ],
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
                          initialTime: const TimeOfDay(hour: 9, minute: 0),
                        );
                        if (time != null && context.mounted) {
                          final h = time.hour.toString().padLeft(2, '0');
                          final m = time.minute.toString().padLeft(2, '0');
                          timeInController.text = '$h:$m';
                        }
                      },
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: SupervisorCreateTaskFieldWidget(
                      labelKey: 'admin.shifts.policies.timeOutLabel',
                      hintKey: 'supervisor.plans.create.timeHint',
                      controller: timeOutController,
                      readOnly: true,
                      onTap: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: const TimeOfDay(hour: 17, minute: 0),
                        );
                        if (time != null && context.mounted) {
                          final h = time.hour.toString().padLeft(2, '0');
                          final m = time.minute.toString().padLeft(2, '0');
                          timeOutController.text = '$h:$m';
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
              hSpace(20),
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
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: _isSubmitting
                          ? 'admin.locations.create.saving'.tr(context: context)
                          : 'admin.locations.create.save'.tr(context: context),
                      isLoading: _isSubmitting,
                      onTap: _submit,
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
