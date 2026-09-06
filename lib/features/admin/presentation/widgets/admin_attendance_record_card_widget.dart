import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import 'admin_attendance_record_data.dart';

class AdminAttendanceRecordCardWidget extends StatelessWidget {
  const AdminAttendanceRecordCardWidget({
    required this.record,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final AdminAttendanceRecordData record;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColors.softGreenBackground,
            child: Text(
              record.initials,
              style: AppTextStyles.font12Bold.copyWith(
                color: AppColors.success,
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
                        record.nameKey.tr(context: context),
                        style: AppTextStyles.font14SemiBold,
                      ),
                    ),
                    vSpace(6),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: record.statusBackgroundColor,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        record.statusKey.tr(context: context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: record.statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(3),
                Text(record.time, style: AppTextStyles.font12Regular),
                hSpace(2),
                Text(
                  record.branch,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              if (onEdit != null)
                SizedBox(
                  width: 36.w,
                  height: 28.h,
                  child: TextButton(
                    onPressed: onEdit,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.softBlueBackground,
                      foregroundColor: AppColors.info,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'admin.attendance.edit'.tr(context: context),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ),
              if (onEdit != null && onDelete != null) hSpace(4),
              if (onDelete != null)
                SizedBox(
                  width: 36.w,
                  height: 28.h,
                  child: TextButton(
                    onPressed: onDelete,
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: AppColors.softBrandBackground,
                      foregroundColor: AppColors.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                    child: Text(
                      'admin.attendance.delete'.tr(context: context),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.error,
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
