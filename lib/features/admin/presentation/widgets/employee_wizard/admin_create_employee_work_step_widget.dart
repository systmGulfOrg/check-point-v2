import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_work_system_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_wizard_field_widget.dart';

class AdminCreateEmployeeWorkStepWidget extends StatelessWidget {
  const AdminCreateEmployeeWorkStepWidget({
    required this.positionController,
    required this.selectedRoles,
    required this.availableRoles,
    required this.onRoleToggled,
    required this.selectedWorkSystem,
    required this.selectedRemoteWorkPolicyId,
    required this.onWorkSystemChanged,
    required this.onWorkPolicyChanged,
    required this.selectedPermissionsCount,
    required this.onManagePermissionsPressed,
    required this.selectedEmploymentType,
    required this.onEmploymentTypeChanged,
    required this.hireDateController,
    required this.onPickHireDate,
    this.hireDateErrorText,
    this.positionFocusNode,
    this.positionErrorText,
    this.onPositionChanged,
    super.key,
  });

  final TextEditingController positionController;
  final Set<String> selectedRoles;
  final List<String> availableRoles;
  final ValueChanged<String> onRoleToggled;
  final String selectedWorkSystem;
  final String? selectedRemoteWorkPolicyId;
  final ValueChanged<String> onWorkSystemChanged;
  final ValueChanged<String?> onWorkPolicyChanged;
  final int selectedPermissionsCount;
  final VoidCallback onManagePermissionsPressed;
  final String selectedEmploymentType;
  final ValueChanged<String> onEmploymentTypeChanged;
  final TextEditingController hireDateController;
  final VoidCallback onPickHireDate;
  final String? hireDateErrorText;
  final FocusNode? positionFocusNode;
  final String? positionErrorText;
  final ValueChanged<String>? onPositionChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'admin.employeeWizard.workTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(16),

        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.position'.tr(context: context),
          child: CustomTextFormField(
            hintText: 'admin.employeeWizard.positionHint'.tr(context: context),
            controller: positionController,
            focusNode: positionFocusNode,
            errorText: positionErrorText,
            onChanged: onPositionChanged,
            prefixIcon: Icon(
              Icons.work_outline_rounded,
              size: 20.r,
              color: AppColors.placeholder,
            ),
            validator: AppValidators.required(
              message: 'admin.employeeWizard.requiredField'.tr(
                context: context,
              ),
              context: context,
            ),
          ),
        ),

        // Employment Type Selection
        Text(
          'admin.employeeWizard.employmentType'.tr(context: context),
          style: AppTextStyles.font13SemiBold,
        ),
        hSpace(8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => onEmploymentTypeChanged('EMPLOYED'),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: selectedEmploymentType == 'EMPLOYED'
                        ? AppColors.softBlueBackground
                        : AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selectedEmploymentType == 'EMPLOYED'
                          ? AppColors.brandPrimary
                          : AppColors.border,
                      width: selectedEmploymentType == 'EMPLOYED' ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.badge_outlined,
                            size: 18.r,
                            color: selectedEmploymentType == 'EMPLOYED'
                                ? AppColors.brandPrimary
                                : AppColors.placeholder,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Text(
                              'admin.employeeWizard.employed'.tr(context: context),
                              style: AppTextStyles.font13Bold.copyWith(
                                color: selectedEmploymentType == 'EMPLOYED'
                                    ? AppColors.brandPrimary
                                    : AppColors.brandInk,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSpace(4),
                      Text(
                        'admin.employeeWizard.employedDesc'.tr(context: context),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            wSpace(10),
            Expanded(
              child: InkWell(
                onTap: () => onEmploymentTypeChanged('TRAINEE'),
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: selectedEmploymentType == 'TRAINEE'
                        ? AppColors.softBlueBackground
                        : AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: selectedEmploymentType == 'TRAINEE'
                          ? AppColors.brandPrimary
                          : AppColors.border,
                      width: selectedEmploymentType == 'TRAINEE' ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 18.r,
                            color: selectedEmploymentType == 'TRAINEE'
                                ? AppColors.brandPrimary
                                : AppColors.placeholder,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Text(
                              'admin.employeeWizard.trainee'.tr(context: context),
                              style: AppTextStyles.font13Bold.copyWith(
                                color: selectedEmploymentType == 'TRAINEE'
                                    ? AppColors.brandPrimary
                                    : AppColors.brandInk,
                              ),
                            ),
                          ),
                        ],
                      ),
                      hSpace(4),
                      Text(
                        'admin.employeeWizard.traineeDesc'.tr(context: context),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        hSpace(16),

        // Hire Date Field
        AdminWizardFieldWidget(
          label: 'admin.employeeWizard.hireDate'.tr(context: context),
          child: InkWell(
            onTap: onPickHireDate,
            child: IgnorePointer(
              child: CustomTextFormField(
                hintText: 'YYYY-MM-DD',
                controller: hireDateController,
                errorText: hireDateErrorText,
                prefixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: 18.r,
                  color: AppColors.placeholder,
                ),
                validator: AppValidators.required(
                  message: 'admin.employeeWizard.hireDateRequired'.tr(
                    context: context,
                  ),
                  context: context,
                ),
              ),
            ),
          ),
        ),
        hSpace(16),

        Text(
          'admin.employeeWizard.roles'.tr(context: context),
          style: AppTextStyles.font13SemiBold,
        ),
        hSpace(10),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: availableRoles.map((r) {
            final isSelected = selectedRoles.contains(r);
            return FilterChip(
              label: Text(
                switch (r) {
                  'Supervisor' => 'admin.roles.supervisor'.tr(context: context),
                  'Admin' => 'admin.roles.admin'.tr(context: context),
                  _ => 'admin.roles.employee'.tr(context: context),
                },
                style: AppTextStyles.font12Medium.copyWith(
                  color: isSelected ? AppColors.white : AppColors.brandInk,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.brandPrimary,
              backgroundColor: AppColors.pageBackground,
              checkmarkColor: AppColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
                side: BorderSide(
                  color: isSelected ? AppColors.brandPrimary : AppColors.border,
                ),
              ),
              onSelected: (_) => onRoleToggled(r),
            );
          }).toList(),
        ),
        hSpace(16),

        AdminEmployeeWorkSystemWidget(
          selectedSystem: selectedWorkSystem,
          selectedPolicyId: selectedRemoteWorkPolicyId,
          onSystemChanged: onWorkSystemChanged,
          onPolicyChanged: onWorkPolicyChanged,
        ),
        hSpace(20),

        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: AppColors.pageBackground,
            borderRadius: BorderRadius.circular(14.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(6.r),
                        decoration: BoxDecoration(
                          color: AppColors.softBlueBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.security_rounded,
                          color: AppColors.brandPrimary,
                          size: 18.r,
                        ),
                      ),
                      vSpace(10),
                      Text(
                        'admin.employeeWizard.permissionsSection'.tr(
                          context: context,
                        ),
                        style: AppTextStyles.font14Bold,
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: selectedPermissionsCount > 0
                          ? AppColors.softBlueBackground
                          : AppColors.border.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      '$selectedPermissionsCount ${'admin.employeeWizard.permissionsSelectedCount'.tr(context: context)}',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: selectedPermissionsCount > 0
                            ? AppColors.brandPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(8),
              Text(
                'admin.employeeWizard.permissionsHelpNote'.tr(context: context),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              hSpace(14),
              OutlinedButton.icon(
                onPressed: onManagePermissionsPressed,
                icon: Icon(Icons.tune_rounded, size: 18.r),
                label: Text(
                  'admin.employeeWizard.managePermissions'.tr(context: context),
                  style: AppTextStyles.font13Bold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 11.h),
                  side: const BorderSide(
                    color: AppColors.brandPrimary,
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
