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
          // Section 1: Employment & Organization Details
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
                label: 'employee.profile.department'.tr(context: context),
                value: employee.departmentName ?? '-',
                icon: Icons.business_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.branch'.tr(context: context),
                value: employee.branchName ?? '-',
                icon: Icons.location_on_outlined,
              ),
              if (employee.shiftName != null && employee.shiftName!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.shift'.tr(context: context),
                  value: employee.shiftName!,
                  icon: Icons.schedule_outlined,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.workSystem'.tr(context: context),
                value: employee.workSystem?.toUpperCase() ?? 'ONSITE',
                icon: Icons.devices_other_outlined,
                valueColor: AppColors.brandPrimary,
              ),
              if (employee.workPolicy?.name != null &&
                  employee.workPolicy!.name!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'admin.policies.title'.tr(context: context),
                  value: employee.workPolicy!.name!,
                  icon: Icons.policy_outlined,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.directManager'.tr(context: context),
                value:
                    employee.resolvedDirectManagerName ??
                    'employee.profile.noManager'.tr(context: context),
                icon: Icons.supervisor_account_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.assignedRoles'.tr(context: context),
                value: employee.allRoles.join(', '),
                icon: Icons.shield_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.joinDate'.tr(context: context),
                value: employee.resolvedJoinDate,
                icon: Icons.event_available_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.sectionBalances'.tr(context: context),
                value: '${employee.leaveBalance ?? 21} ${'employee.profile.days'.tr(context: context)}',
                icon: Icons.beach_access_outlined,
              ),
            ],
          ),

          // Section 2: Personal & Contact Details
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionPersonal'.tr(context: context),
            icon: Icons.person_outline_rounded,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'admin.createEmployee.fullName'.tr(context: context),
                value: employee.name ?? '-',
                icon: Icons.person_outline,
              ),
              if (employee.userName != null && employee.userName!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'admin.createEmployee.userName'.tr(context: context),
                  value: employee.userName!,
                  icon: Icons.alternate_email_rounded,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.officialEmail'.tr(context: context),
                value: employee.email ?? '-',
                icon: Icons.mail_outline_rounded,
                isCopyable: employee.email != null && employee.email!.isNotEmpty,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.primaryPhone'.tr(context: context),
                value: employee.phone ?? '-',
                icon: Icons.phone_android_rounded,
                isCopyable: employee.phone != null && employee.phone!.isNotEmpty,
              ),
              if (employee.mobileId != null && employee.mobileId!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'admin.createEmployee.mobileId'.tr(context: context),
                  value: employee.mobileId!,
                  icon: Icons.smartphone_rounded,
                  isCopyable: true,
                ),
              if (employee.nationalId != null && employee.nationalId!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.nationalId'.tr(context: context),
                  value: employee.nationalId!,
                  icon: Icons.credit_card_outlined,
                  isCopyable: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
