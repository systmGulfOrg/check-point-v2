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
    final locationType =
        (employee.attendanceLocationType ?? 'branch').toLowerCase();

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
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
                label: 'employee.profile.locationType'.tr(context: context),
                value: locationType.toUpperCase(),
                icon: Icons.place_outlined,
              ),
              if (locationType == 'branch')
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.branch'.tr(context: context),
                  value: employee.branchName ?? '-',
                  icon: Icons.location_on_outlined,
                )
              else if (employee.assignedSiteIds != null &&
                  employee.assignedSiteIds!.isNotEmpty)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.site'.tr(context: context),
                  value: employee.assignedSiteIds!.join(', '),
                  icon: Icons.location_city_outlined,
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
              if (employee.remoteWorkPolicyId != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'Work Policy',
                  value:
                      employee.workPolicy?.name ??
                      employee.remoteWorkPolicyId!,
                  icon: Icons.policy_outlined,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.directManager'.tr(context: context),
                value:
                    employee.resolvedDirectManagerName ??
                    'employee.profile.noManager'.tr(context: context),
                icon: Icons.supervisor_account_outlined,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
