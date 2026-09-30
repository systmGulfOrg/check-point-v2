import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_profile_quick_action_widget.dart';

class AdminEmployeeProfileHeaderWidget extends StatelessWidget {
  const AdminEmployeeProfileHeaderWidget({
    required this.employee,
    super.key,
  });

  final EmployeeModel employee;

  @override
  Widget build(BuildContext context) {
    final initials = _getInitials(employee.name);
    final status = employee.resolvedContractStatus;
    final isActive = status.toLowerCase() == 'active';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 36.r,
                    backgroundColor: AppColors.softBrandBackground,
                    backgroundImage: employee.imageUrl != null &&
                            employee.imageUrl!.isNotEmpty
                        ? NetworkImage(employee.imageUrl!)
                        : null,
                    child: (employee.imageUrl == null ||
                            employee.imageUrl!.isEmpty)
                        ? Text(
                            initials,
                            style: AppTextStyles.font24Bold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          )
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(4.r),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.shadow,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.verified_rounded,
                        size: 16.r,
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              wSpace(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.resolvedNameAr,
                      style: AppTextStyles.font18Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (employee.resolvedNameEn != employee.resolvedNameAr) ...[
                      hSpace(2),
                      Text(
                        employee.resolvedNameEn,
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    hSpace(4),
                    Text(
                      employee.position ?? 'employee.profile.defaultPosition'.tr(context: context),
                      style: AppTextStyles.font13Medium.copyWith(
                        color: AppColors.brandPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    hSpace(6),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.softGreenBackground
                                : AppColors.softYellowBackground,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 6.r,
                                height: 6.r,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? AppColors.success
                                      : AppColors.warningOrange,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              wSpace(4),
                              Text(
                                status,
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: isActive
                                      ? AppColors.success
                                      : AppColors.warningOrange,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        wSpace(8),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              final code = employee.employeeCode ?? employee.id ?? '';
                              if (code.isNotEmpty) {
                                Clipboard.setData(ClipboardData(text: code));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('employee.profile.codeCopied'.tr(context: context)),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                              }
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.badge_outlined,
                                  size: 14.r,
                                  color: AppColors.placeholder,
                                ),
                                wSpace(4),
                                Flexible(
                                  child: Text(
                                    employee.employeeCode ?? employee.id ?? '-',
                                    style: AppTextStyles.font12Medium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(14),
          const Divider(height: 1, color: AppColors.border),
          hSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdminEmployeeProfileQuickActionWidget(
                icon: Icons.phone_outlined,
                label: 'employee.profile.call'.tr(context: context),
                color: (employee.phone != null && employee.phone!.trim().isNotEmpty)
                    ? AppColors.success
                    : AppColors.placeholder,
                onTap: (employee.phone != null && employee.phone!.trim().isNotEmpty)
                    ? () {
                        Clipboard.setData(ClipboardData(text: employee.phone!.trim()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('employee.profile.phoneCopied'.tr(context: context))),
                        );
                      }
                    : null,
              ),
              AdminEmployeeProfileQuickActionWidget(
                icon: Icons.email_outlined,
                label: 'employee.profile.emailAction'.tr(context: context),
                color: (employee.email != null && employee.email!.trim().isNotEmpty)
                    ? AppColors.brandPrimary
                    : AppColors.placeholder,
                onTap: (employee.email != null && employee.email!.trim().isNotEmpty)
                    ? () {
                        Clipboard.setData(ClipboardData(text: employee.email!.trim()));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('employee.profile.emailCopied'.tr(context: context))),
                        );
                      }
                    : null,
              ),
              AdminEmployeeProfileQuickActionWidget(
                icon: Icons.shield_outlined,
                label: employee.role ?? 'Employee',
                color: AppColors.brandSecondary,
                onTap: null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _getInitials(String? name) {
    final parts = (name ?? '').trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((part) => part.isNotEmpty)
        .take(2)
        .map((part) => part[0].toUpperCase())
        .join();
    return initials.isEmpty ? '?' : initials;
  }
}
