import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class SupervisorAttendanceRowData {
  const SupervisorAttendanceRowData({
    required this.initials,
    required this.nameKey,
    required this.time,
    required this.statusKey,
    required this.statusColor,
    required this.statusBackgroundColor,
  });

  final String initials;
  final String nameKey;
  final String time;
  final String statusKey;
  final Color statusColor;
  final Color statusBackgroundColor;
}

class SupervisorAttendanceListWidget extends StatelessWidget {
  const SupervisorAttendanceListWidget({super.key});

  static const _rows = <SupervisorAttendanceRowData>[
    SupervisorAttendanceRowData(
      initials: 'JM',
      nameKey: 'supervisor.attendance.members.james',
      time: '08:02',
      statusKey: 'supervisor.status.present',
      statusColor: AppColors.success,
      statusBackgroundColor: AppColors.softGreenBackground,
    ),
    SupervisorAttendanceRowData(
      initials: 'PN',
      nameKey: 'supervisor.attendance.members.priya',
      time: '09:15',
      statusKey: 'supervisor.status.late',
      statusColor: AppColors.warningOrange,
      statusBackgroundColor: AppColors.softYellowBackground,
    ),
    SupervisorAttendanceRowData(
      initials: 'DC',
      nameKey: 'supervisor.attendance.members.david',
      time: '--',
      statusKey: 'supervisor.status.absent',
      statusColor: AppColors.error,
      statusBackgroundColor: AppColors.softBrandBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _rows.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final row = _rows[index];
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 19.r,
                backgroundColor: AppColors.softBrandBackground,
                child: Text(
                  row.initials,
                  style: AppTextStyles.font12Bold.copyWith(
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
                      row.nameKey.tr(context: context),
                      style: AppTextStyles.font14SemiBold,
                    ),
                    hSpace(2),
                    Text(
                      'supervisor.attendance.clockIn'.tr(
                        context: context,
                        args: [row.time],
                      ),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.placeholder,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: row.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 6.r,
                      height: 6.r,
                      decoration: BoxDecoration(
                        color: row.statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    vSpace(6),
                    Text(
                      row.statusKey.tr(context: context),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: row.statusColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
