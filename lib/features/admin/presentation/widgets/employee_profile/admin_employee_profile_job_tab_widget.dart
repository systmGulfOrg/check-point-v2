import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_profile_info_card_widget.dart';
import 'admin_employee_profile_info_row_widget.dart';

class AdminEmployeeProfileJobTabWidget extends StatelessWidget {
  const AdminEmployeeProfileJobTabWidget({required this.employee, super.key});

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Section 1: Employment Details
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionJob'.tr(context: context),
            icon: Icons.work_outline_rounded,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.code'.tr(context: context),
                value: employee.employeeCode ?? employee.id ?? '-',
                icon: Icons.tag_rounded,
                isCopyable: true,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.position'.tr(context: context),
                value: employee.position ?? '-',
                icon: Icons.badge_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.grade'.tr(context: context),
                value: employee.resolvedGrade,
                icon: Icons.military_tech_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.department'.tr(context: context),
                value: employee.departmentName ?? '-',
                icon: Icons.business_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.division'.tr(context: context),
                value: employee.resolvedDivision,
                icon: Icons.account_tree_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.branch'.tr(context: context),
                value: employee.branchName ?? '-',
                icon: Icons.location_on_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.shift'.tr(context: context),
                value: employee.shiftName ?? '-',
                icon: Icons.schedule_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.workSystem'.tr(context: context),
                value: employee.workSystem?.toUpperCase() ?? 'ONSITE',
                icon: Icons.devices_other_outlined,
                valueColor: AppColors.brandPrimary,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.directManager'.tr(context: context),
                value:
                    employee.resolvedDirectManagerName ??
                    'employee.profile.noManager'.tr(context: context),
                icon: Icons.supervisor_account_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.contractType'.tr(context: context),
                value: employee.resolvedContractType,
                icon: Icons.assignment_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.joinDate'.tr(context: context),
                value: employee.resolvedJoinDate,
                icon: Icons.event_available_outlined,
              ),
              if (employee.contractEndDate != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.contractEndDate'.tr(
                    context: context,
                  ),
                  value: employee.contractEndDate!,
                  icon: Icons.event_busy_outlined,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
