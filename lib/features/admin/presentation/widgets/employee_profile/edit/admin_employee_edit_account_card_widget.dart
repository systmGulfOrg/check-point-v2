import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../admin_employee_profile_info_card_widget.dart';

class AdminEmployeeEditAccountCardWidget extends StatelessWidget {
  const AdminEmployeeEditAccountCardWidget({
    required this.userNameController,
    required this.passwordController,
    required this.leaveBalanceController,
    required this.selectedRoles,
    required this.onRoleToggled,
    this.canAddAttendance,
    this.canAddPlan,
    this.onCanAddAttendanceChanged,
    this.onCanAddPlanChanged,
    super.key,
  });

  final TextEditingController userNameController;
  final TextEditingController passwordController;
  final TextEditingController leaveBalanceController;
  final Set<String> selectedRoles;
  final bool? canAddAttendance;
  final bool? canAddPlan;
  final ValueChanged<String> onRoleToggled;
  final ValueChanged<bool>? onCanAddAttendanceChanged;
  final ValueChanged<bool>? onCanAddPlanChanged;

  static const List<String> _roles = ['Employee', 'Supervisor', 'Admin'];

  @override
  Widget build(BuildContext context) {
    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionRBAC'.tr(context: context),
      icon: Icons.admin_panel_settings_outlined,
      children: [
        CustomTextFormField(
          controller: userNameController,
          hintText: 'Username (اسم المستخدم)',
          prefixIcon: const Icon(
            Icons.account_circle_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: passwordController,
          hintText: 'New Password - Optional (كلمة مرور جديدة)',
          obscureText: true,
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(10),
        CustomTextFormField(
          controller: leaveBalanceController,
          hintText: 'Annual Leave Balance (رصيد الإجازات السنوي)',
          keyboardType: TextInputType.number,
          prefixIcon: const Icon(
            Icons.calendar_month_outlined,
            color: AppColors.brandPrimary,
          ),
        ),
        hSpace(14),
        Text(
          'employee.profile.assignedRoles'.tr(context: context),
          style: AppTextStyles.font13Medium.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        hSpace(8),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: _roles.map((role) {
            final isSelected = selectedRoles.contains(role);
            return FilterChip(
              label: Text(role),
              selected: isSelected,
              onSelected: (_) => onRoleToggled(role),
              selectedColor: AppColors.brandPrimary.withValues(alpha: 0.15),
              checkmarkColor: AppColors.brandPrimary,
              labelStyle: AppTextStyles.font13Medium.copyWith(
                color: isSelected
                    ? AppColors.brandPrimary
                    : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
              side: BorderSide(
                color: isSelected ? AppColors.brandPrimary : AppColors.border,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            );
          }).toList(),
        ),
        hSpace(8),
      ],
    );
  }
}
