import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorTaskRowData {
  const SupervisorTaskRowData({
    required this.title,
    required this.assigneeAndDue,
    required this.statusKey,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String title;
  final String assigneeAndDue;
  final String statusKey;
  final Color statusColor;
  final Color statusBgColor;
}

class SupervisorActiveTasksWidget extends StatelessWidget {
  const SupervisorActiveTasksWidget({super.key});

  static const _tasks = <SupervisorTaskRowData>[
    SupervisorTaskRowData(
      title: 'Onboard New Contractors',
      assigneeAndDue: 'James Martinez · Due 2026-08-30',
      statusKey: 'supervisor.taskStatus.overdue',
      statusColor: AppColors.error,
      statusBgColor: AppColors.softBrandBackground,
    ),
    SupervisorTaskRowData(
      title: 'Update Security Protocols',
      assigneeAndDue: 'Priya Nair · Due 2026-09-08',
      statusKey: 'supervisor.taskStatus.toDo',
      statusColor: AppColors.textSecondary,
      statusBgColor: AppColors.pageBackground,
    ),
    SupervisorTaskRowData(
      title: 'Complete Q3 Report',
      assigneeAndDue: 'James Martinez · Due 2026-09-05',
      statusKey: 'supervisor.taskStatus.inProgress',
      statusColor: AppColors.info,
      statusBgColor: AppColors.softBlueBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'supervisor.dashboard.activeTasks'.tr(context: context),
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'supervisor.dashboard.viewAll'.tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          for (int i = 0; i < _tasks.length; i++) ...[
            const Divider(color: AppColors.border, height: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _tasks[i].title,
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        hSpace(4),
                        Text(
                          _tasks[i].assigneeAndDue,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.placeholder,
                          ),
                        ),
                      ],
                    ),
                  ),
                  vSpace(8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _tasks[i].statusBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.border,
                        width: 0.5,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: BoxDecoration(
                            color: _tasks[i].statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        vSpace(6),
                        Text(
                          _tasks[i].statusKey.tr(context: context),
                          style: AppTextStyles.font12Bold.copyWith(
                            color: _tasks[i].statusColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
