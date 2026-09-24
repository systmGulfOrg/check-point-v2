import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_profile_info_card_widget.dart';
import 'admin_employee_profile_info_row_widget.dart';

class AdminEmployeeProfileJobTabWidget extends StatelessWidget {
  const AdminEmployeeProfileJobTabWidget({
    required this.employee,
    super.key,
  });

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
                value: employee.resolvedDirectManagerName ?? 'employee.profile.noManager'.tr(context: context),
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
                  label: 'employee.profile.contractEndDate'.tr(context: context),
                  value: employee.contractEndDate!,
                  icon: Icons.event_busy_outlined,
                ),
            ],
          ),

          // Section 2: Personal & Contact Details
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionPersonal'.tr(context: context),
            icon: Icons.person_outline_rounded,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.nameAr'.tr(context: context),
                value: employee.resolvedNameAr,
                icon: Icons.translate_rounded,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.nameEn'.tr(context: context),
                value: employee.resolvedNameEn,
                icon: Icons.language_rounded,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.officialEmail'.tr(context: context),
                value: employee.email ?? '-',
                icon: Icons.mail_outline_rounded,
                isCopyable: true,
              ),
              if (employee.personalEmail != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.personalEmail'.tr(context: context),
                  value: employee.personalEmail!,
                  icon: Icons.alternate_email_rounded,
                  isCopyable: true,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.primaryPhone'.tr(context: context),
                value: employee.phone ?? '-',
                icon: Icons.phone_android_rounded,
                isCopyable: true,
              ),
              if (employee.secondaryPhone != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.secondaryPhone'.tr(context: context),
                  value: employee.secondaryPhone!,
                  icon: Icons.phone_outlined,
                  isCopyable: true,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.nationalId'.tr(context: context),
                value: employee.resolvedNationalId,
                icon: Icons.credit_card_outlined,
                isCopyable: true,
              ),
              if (employee.idExpiryDate != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.idExpiry'.tr(context: context),
                  value: employee.idExpiryDate!,
                  icon: Icons.date_range_outlined,
                ),
              if (employee.birthDate != null)
                AdminEmployeeProfileInfoRowWidget(
                  label: 'employee.profile.birthDate'.tr(context: context),
                  value: employee.birthDate!,
                  icon: Icons.cake_outlined,
                ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.gender'.tr(context: context),
                value: employee.gender ?? 'employee.profile.notSpecified'.tr(context: context),
                icon: Icons.wc_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.maritalStatus'.tr(context: context),
                value: employee.maritalStatus ?? 'employee.profile.notSpecified'.tr(context: context),
                icon: Icons.favorite_border_rounded,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.address'.tr(context: context),
                value: employee.address ?? employee.city ?? '-',
                icon: Icons.home_outlined,
              ),
            ],
          ),

          // Section 3: Emergency Contact
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionEmergency'.tr(context: context),
            icon: Icons.emergency_outlined,
            children: [
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.emergencyName'.tr(context: context),
                value: employee.resolvedEmergencyName,
                icon: Icons.person_pin_circle_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.emergencyRelation'.tr(context: context),
                value: employee.resolvedEmergencyRelation,
                icon: Icons.family_restroom_outlined,
              ),
              AdminEmployeeProfileInfoRowWidget(
                label: 'employee.profile.emergencyPhone'.tr(context: context),
                value: employee.resolvedEmergencyPhone,
                icon: Icons.phone_in_talk_outlined,
                isCopyable: true,
                valueColor: AppColors.error,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
