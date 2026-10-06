import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

class SupervisorTeamMemberCardWidget extends StatelessWidget {
  const SupervisorTeamMemberCardWidget({
    required this.employee,
    this.onTap,
    super.key,
  });

  final EmployeeModel employee;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final name = employee.name ?? employee.userName ?? 'Employee';
    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    final role = employee.role ?? 'auth.role.employee';
    final code = employee.userName ?? employee.id ?? '';
    final details = <(IconData, String)>[
      if ((employee.position ?? '').isNotEmpty)
        (Icons.work_outline_rounded, employee.position!),
      if ((employee.departmentName ?? '').isNotEmpty)
        (Icons.business_outlined, employee.departmentName!),
      if ((employee.branchName ?? employee.area ?? '').isNotEmpty)
        (Icons.location_on_outlined, employee.branchName ?? employee.area!),
      if ((employee.shiftName ?? '').isNotEmpty)
        (Icons.schedule_rounded, employee.shiftName!),
    ];

    return AppCardContainerWidget(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AppAvatarWidget(
                  imageUrl: employee.imageUrl,
                  name: name,
                  initials: initials.isEmpty ? 'EM' : initials,
                  subtitle: code,
                  radius: 24.r,
                  enablePreview: true,
                ),
                vSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.font16Bold,
                      ),
                      if (code.isNotEmpty) ...[
                        hSpace(3),
                        Text(
                          code,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(999.r),
                  ),
                  child: Text(
                    role.tr(context: context),
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.brandPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            if (details.isNotEmpty) ...[
              hSpace(12),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final detail in details)
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            detail.$1,
                            size: 14.r,
                            color: AppColors.placeholder,
                          ),
                          wSpace(5),
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 140.w),
                            child: Text(
                              detail.$2,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.font11Medium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
            if (employee.canAddAttendance == true ||
                employee.canAddPlan == true) ...[
              hSpace(12),
              Row(
                children: [
                  if (employee.canAddAttendance == true)
                    SupervisorPermissionChipWidget(
                      icon: Icons.how_to_reg_rounded,
                      label: 'admin.departments.attendancePermission',
                    ),
                  if (employee.canAddPlan == true) ...[
                    wSpace(8),
                    SupervisorPermissionChipWidget(
                      icon: Icons.event_note_outlined,
                      label: 'admin.departments.planPermission',
                    ),
                  ],
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class SupervisorPermissionChipWidget extends StatelessWidget {
  const SupervisorPermissionChipWidget({
    required this.icon,
    required this.label,
    super.key,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 15.r, color: AppColors.success),
          wSpace(4),
          Flexible(
            child: Text(
              label.tr(context: context),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font11Medium.copyWith(
                color: AppColors.success,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
