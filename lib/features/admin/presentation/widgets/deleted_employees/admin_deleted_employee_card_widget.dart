import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'admin_deleted_action_button_widget.dart';

class AdminDeletedEmployeeCardWidget extends StatelessWidget {
  const AdminDeletedEmployeeCardWidget({
    required this.employee,
    required this.onRestore,
    required this.onPermanentDelete,
    super.key,
  });

  final EmployeeModel employee;
  final VoidCallback onRestore;
  final VoidCallback onPermanentDelete;

  @override
  Widget build(BuildContext context) {
    final initials = _initials(employee.name);
    final subText = [
      if (employee.employeeCode != null && employee.employeeCode!.isNotEmpty)
        employee.employeeCode!,
      if (employee.departmentName != null && employee.departmentName!.isNotEmpty)
        employee.departmentName!,
    ].join('  •  ');

    final deletedDate = employee.deletedAt != null
        ? _formatDate(employee.deletedAt!)
        : null;

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
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.softRedBackground,
            child: Text(
              initials,
              style: AppTextStyles.font14Bold.copyWith(color: AppColors.error),
            ),
          ),
          wSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name ?? employee.userName ?? '-',
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (subText.isNotEmpty) ...[
                  hSpace(2),
                  Text(
                    subText,
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (deletedDate != null) ...[
                  hSpace(4),
                  Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        size: 12.r,
                        color: AppColors.error,
                      ),
                      wSpace(4),
                      Text(
                        'admin.deletedEmployees.deletedOn'.tr(
                          args: [deletedDate],
                          context: context,
                        ),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          wSpace(8),
          Column(
            children: [
              AdminDeletedActionButtonWidget(
                icon: Icons.restore_rounded,
                color: AppColors.success,
                background: AppColors.softGreenBackground,
                tooltip: 'admin.deletedEmployees.restore'.tr(context: context),
                onTap: onRestore,
              ),
              hSpace(8),
              AdminDeletedActionButtonWidget(
                icon: Icons.delete_forever_rounded,
                color: AppColors.error,
                background: AppColors.softRedBackground,
                tooltip:
                    'admin.deletedEmployees.permanentDelete'.tr(context: context),
                onTap: onPermanentDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  static String _initials(String? name) {
    final parts = (name ?? '').trim().split(RegExp(r'\s+'));
    final initials = parts
        .where((p) => p.isNotEmpty)
        .take(2)
        .map((p) => p[0].toUpperCase())
        .join();
    return initials.isEmpty ? '?' : initials;
  }

  static String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso).toLocal();
      return '${dt.day}/${dt.month}/${dt.year}';
    } catch (_) {
      return iso;
    }
  }
}
