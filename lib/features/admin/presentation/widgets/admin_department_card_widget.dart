import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/department_response_model.dart';

class AdminDepartmentCardWidget extends StatelessWidget {
  const AdminDepartmentCardWidget({
    required this.department,
    required this.onViewEmployees,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final DepartmentModel department;
  final VoidCallback onViewEmployees;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onViewEmployees,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Padding(
              padding: EdgeInsets.all(14.r),
              child: Row(
                children: [
                  Container(
                    width: 44.r,
                    height: 44.r,
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.corporate_fare_outlined,
                      color: AppColors.brandPrimary,
                      size: 24.r,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          department.departmentName ?? '-',
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        hSpace(4),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 6.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.softBlueBackground,
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                              child: Text(
                                'ID: #${department.id ?? '-'}',
                                style: AppTextStyles.font11Medium.copyWith(
                                  color: AppColors.info,
                                ),
                              ),
                            ),
                            vSpace(8),
                            Text(
                              'admin.locations.status.active'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font11Medium.copyWith(
                                color: AppColors.success,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.placeholder,
                    size: 22.r,
                  ),
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: AppColors.border),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onViewEmployees,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.group_outlined,
                          size: 16.r,
                          color: AppColors.brandPrimary,
                        ),
                        vSpace(6),
                        Text(
                          'admin.departments.viewEmployees'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 1, height: 24.h, color: AppColors.border),
              Expanded(
                child: InkWell(
                  onTap: onEdit,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 15.r,
                          color: AppColors.textSecondary,
                        ),
                        vSpace(4),
                        Text(
                          'admin.locations.edit'.tr(context: context),
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(width: 1, height: 24.h, color: AppColors.border),
              Expanded(
                child: InkWell(
                  onTap: onDelete,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 15.r,
                          color: AppColors.error,
                        ),
                        vSpace(4),
                        Text(
                          'admin.locations.delete'.tr(context: context),
                          style: AppTextStyles.font13SemiBold.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
