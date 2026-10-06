import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminCreateEmployeeReviewStepWidget extends StatelessWidget {
  const AdminCreateEmployeeReviewStepWidget({
    required this.name,
    required this.username,
    required this.position,
    required this.mobileId,
    required this.phone,
    required this.email,
    required this.employeeCode,
    required this.roles,
    required this.workSystem,
    required this.workPolicyName,
    required this.departmentName,
    required this.branchName,
    required this.directManagerName,
    required this.selectedPermissionsCount,
    super.key,
  });

  final String name;
  final String username;
  final String position;
  final String mobileId;
  final String phone;
  final String email;
  final String employeeCode;
  final List<String> roles;
  final String workSystem;
  final String? workPolicyName;
  final String? departmentName;
  final String? branchName;
  final String? directManagerName;
  final int selectedPermissionsCount;

  @override
  Widget build(BuildContext context) {
    final localizedWorkSystem = switch (workSystem) {
      'remote' => 'remoteWork.remotePolicy'.tr(context: context),
      'hybrid' => 'remoteWork.hybridPolicy'.tr(context: context),
      _ => 'admin.employeeWizard.workSystemOnsite'.tr(context: context),
    };

    final items = <(String, String)>[
      ('admin.employeeWizard.reviewName'.tr(context: context), name),
      ('admin.employeeWizard.reviewUsername'.tr(context: context), username),
      ('admin.employeeWizard.reviewPosition'.tr(context: context), position),
      ('admin.employeeWizard.reviewMobileId'.tr(context: context), mobileId),
      (
        'admin.employeeWizard.reviewPhone'.tr(context: context),
        phone.isNotEmpty ? phone : '-',
      ),
      (
        'admin.employeeWizard.reviewEmail'.tr(context: context),
        email.isNotEmpty ? email : '-',
      ),
      (
        'admin.employeeWizard.reviewEmployeeCode'.tr(context: context),
        employeeCode.isNotEmpty ? employeeCode : '-',
      ),
      (
        'admin.employeeWizard.reviewRoles'.tr(context: context),
        roles.join(', '),
      ),
      (
        'admin.employeeWizard.reviewWorkSystem'.tr(context: context),
        localizedWorkSystem,
      ),
      if (workPolicyName != null && workPolicyName!.isNotEmpty)
        (
          'admin.employeeWizard.reviewWorkPolicy'.tr(context: context),
          workPolicyName!,
        ),
      (
        'admin.employeeWizard.reviewDepartment'.tr(context: context),
        departmentName ?? '-',
      ),
      (
        'admin.employeeWizard.reviewBranch'.tr(context: context),
        branchName ?? '-',
      ),
      if (directManagerName != null && directManagerName!.isNotEmpty)
        (
          'admin.employeeWizard.reviewDirectManager'.tr(context: context),
          directManagerName!,
        ),
      (
        'admin.employeeWizard.reviewPermissions'.tr(context: context),
        selectedPermissionsCount > 0
            ? '$selectedPermissionsCount ${'admin.employeeWizard.permissionsSelectedCount'.tr(context: context)}'
            : 'admin.employeeWizard.reviewNoPermissions'.tr(context: context),
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'admin.employeeWizard.reviewTitle'.tr(context: context),
          style: AppTextStyles.font16Bold,
        ),
        hSpace(8),
        Text(
          'admin.employeeWizard.reviewDescription'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        hSpace(18),
        ...items.map(
          (item) => Padding(
            padding: EdgeInsets.only(bottom: 13.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$1,
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                vSpace(12),
                Flexible(
                  child: Text(
                    item.$2,
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandInk,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
