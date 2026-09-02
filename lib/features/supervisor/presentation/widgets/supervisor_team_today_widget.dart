import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorTeamMemberRowData {
  const SupervisorTeamMemberRowData({
    required this.initials,
    required this.name,
    required this.department,
    required this.statusKey,
    required this.statusColor,
    required this.statusBgColor,
  });

  final String initials;
  final String name;
  final String department;
  final String statusKey;
  final Color statusColor;
  final Color statusBgColor;
}

class SupervisorTeamTodayWidget extends StatelessWidget {
  const SupervisorTeamTodayWidget({super.key});

  static const _members = <SupervisorTeamMemberRowData>[
    SupervisorTeamMemberRowData(
      initials: 'JM',
      name: 'James Martinez',
      department: 'Operations',
      statusKey: 'supervisor.status.present',
      statusColor: AppColors.success,
      statusBgColor: AppColors.softGreenBackground,
    ),
    SupervisorTeamMemberRowData(
      initials: 'PN',
      name: 'Priya Nair',
      department: 'Information Technology',
      statusKey: 'supervisor.status.late',
      statusColor: AppColors.warningOrange,
      statusBgColor: AppColors.softYellowBackground,
    ),
    SupervisorTeamMemberRowData(
      initials: 'DC',
      name: 'David Chen',
      department: 'Finance',
      statusKey: 'supervisor.status.absent',
      statusColor: AppColors.error,
      statusBgColor: AppColors.softBrandBackground,
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
                  'supervisor.dashboard.teamToday'.tr(context: context),
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
          for (int i = 0; i < _members.length; i++) ...[
            const Divider(color: AppColors.border, height: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: AppColors.softBrandBackground,
                    child: Text(
                      _members[i].initials,
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _members[i].name,
                          style: AppTextStyles.font14SemiBold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        hSpace(2),
                        Text(
                          _members[i].department,
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: _members[i].statusBgColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 6.r,
                          height: 6.r,
                          decoration: BoxDecoration(
                            color: _members[i].statusColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        vSpace(6),
                        Text(
                          _members[i].statusKey.tr(context: context),
                          style: AppTextStyles.font12Bold.copyWith(
                            color: _members[i].statusColor,
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
