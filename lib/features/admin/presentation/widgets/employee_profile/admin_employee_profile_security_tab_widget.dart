import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/device/pending_device_model.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_employee_profile_info_card_widget.dart';

class AdminEmployeeProfileSecurityTabWidget extends StatelessWidget {
  const AdminEmployeeProfileSecurityTabWidget({
    required this.employee,
    required this.devices,
    super.key,
  });

  final EmployeeModel employee;
  final List<PendingDeviceModel> devices;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionRBAC'.tr(context: context),
            icon: Icons.admin_panel_settings_outlined,
            children: [
              Text(
                'employee.profile.assignedRoles'.tr(context: context),
                style: AppTextStyles.font12Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(8),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: employee.allRoles.map((r) {
                  return Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.brandPrimary.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.shield_rounded,
                          size: 14.r,
                          color: AppColors.brandPrimary,
                        ),
                        wSpace(6),
                        Text(
                          r,
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              hSpace(14),
              Text(
                'employee.profile.activePermissions'.tr(context: context),
                style: AppTextStyles.font12Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(8),
              if (employee.permissions != null &&
                  employee.permissions!.isNotEmpty)
                Wrap(
                  spacing: 6.w,
                  runSpacing: 6.h,
                  children: employee.permissions!.map((p) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Text(
                        p,
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                )
              else
                Text(
                  'employee.profile.standardPermissions'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),

          AdminEmployeeProfileInfoCardWidget(
            title: 'employee.profile.sectionDevices'.tr(context: context),
            icon: Icons.phone_android_rounded,
            children: [
              if (devices.isEmpty && employee.mobileId == null)
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Text(
                      'employee.profile.noRegisteredDevices'.tr(
                        context: context,
                      ),
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                )
              else if (devices.isNotEmpty)
                ...devices.map((d) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.smartphone_rounded,
                          size: 24.r,
                          color: AppColors.brandPrimary,
                        ),
                        wSpace(12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                d.deviceModel ?? 'Mobile Device',
                                style: AppTextStyles.font13Medium.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              hSpace(2),
                              Text(
                                d.deviceId,
                                style: AppTextStyles.font11Regular.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.softGreenBackground,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'Active',
                            style: AppTextStyles.font11Medium.copyWith(
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                })
              else if (employee.mobileId != null)
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.smartphone_rounded,
                        size: 24.r,
                        color: AppColors.brandPrimary,
                      ),
                      wSpace(12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Primary Registered Device',
                              style: AppTextStyles.font13Medium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            hSpace(2),
                            Text(
                              employee.mobileId!,
                              style: AppTextStyles.font11Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softGreenBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Linked',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
