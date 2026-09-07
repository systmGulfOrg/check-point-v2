import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/employee_model.dart';
import 'admin_employee_permissions_row_widget.dart';
import 'admin_employee_role_badge_widget.dart';

class AdminDepartmentEmployeeCardWidget extends StatelessWidget {
  const AdminDepartmentEmployeeCardWidget({required this.employee, super.key});

  final EmployeeModel employee;

  String get _initials {
    final name = employee.name?.trim() ?? '';
    if (name.isEmpty) return 'EM';
    final parts = name.split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final role = employee.role ?? 'Employee';
    final position = employee.position;
    final branchName = employee.branchName;
    final email = employee.userName ?? '-';
    final mobileId = employee.mobileId;

    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.r,
                backgroundColor: AppColors.softBrandBackground,
                child: Text(
                  _initials,
                  style: AppTextStyles.font13SemiBold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
              vSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            employee.name ?? '-',
                            style: AppTextStyles.font16Bold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        vSpace(8),
                        AdminEmployeeRoleBadgeWidget(role: role),
                      ],
                    ),
                    if (position != null && position.isNotEmpty) ...[
                      hSpace(3),
                      Text(
                        position,
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                    if (branchName != null && branchName.isNotEmpty) ...[
                      hSpace(2),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: 13.r,
                            color: AppColors.placeholder,
                          ),
                          vSpace(4),
                          Text(
                            branchName,
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.placeholder,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                width: 8.r,
                height: 8.r,
                margin: EdgeInsets.only(top: 4.h),
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          hSpace(10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.selectedBackground,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.mail_outline_rounded,
                      size: 14.r,
                      color: AppColors.textSecondary,
                    ),
                    vSpace(6),
                    Expanded(
                      child: Text(
                        email,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (mobileId != null && mobileId.isNotEmpty) ...[
                  hSpace(4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android_outlined,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      vSpace(6),
                      Text(
                        mobileId,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          if ((employee.canAddAttendance ?? false) ||
              (employee.canAddPlan ?? false)) ...[
            hSpace(8),
            AdminEmployeePermissionsRowWidget(
              canAddAttendance: employee.canAddAttendance ?? false,
              canAddPlan: employee.canAddPlan ?? false,
            ),
          ],
        ],
      ),
    );
  }
}
