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
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColors.softGreenBackground,
                child: Text(
                  record.initials,
                  style: AppTextStyles.font14Bold.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
              wSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      record.name,
                      style: AppTextStyles.font14SemiBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    hSpace(3),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 13.r,
                          color: AppColors.placeholder,
                        ),
                        wSpace(3),
                        Expanded(
                          child: Text(
                            record.area.isNotEmpty ? record.area : '-',
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.placeholder,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              wSpace(8),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 4.h,
                ),
                decoration: BoxDecoration(
                  color: record.statusBackgroundColor,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  record.statusKey.tr(context: context),
                  style: AppTextStyles.font11Medium.copyWith(
                    color: record.statusColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (onEdit != null) ...[
                wSpace(6),
                InkWell(
                  onTap: onEdit,
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBlueBackground,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Text(
                      'admin.attendance.edit'.tr(context: context),
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.info,
                      ),
                    ),
                  ),
                ),
              ],
              if (onDelete != null) ...[
                wSpace(6),
                InkWell(
                  onTap: onDelete,
                  borderRadius: BorderRadius.circular(6.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(6.r),
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
            ],
          ),
          hSpace(12),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColors.pageBackground,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 13.r,
                            color: AppColors.placeholder,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'admin.attendance.date'.tr(context: context),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.placeholder,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                hSpace(2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    record.date,
                                    style: AppTextStyles.font13SemiBold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 26.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      color: AppColors.border,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 14.r,
                            color: AppColors.brandPrimary,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'admin.attendance.totalHours'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.placeholder,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                hSpace(2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    record.totalHours.isNotEmpty
                                        ? record.totalHours
                                        : '--',
                                    style: AppTextStyles.font13SemiBold
                                        .copyWith(
                                          color:
                                              (record.totalHours.isNotEmpty &&
                                                      record.totalHours != '--')
                                                  ? AppColors.brandPrimary
                                                  : AppColors.placeholder,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                Container(
                  height: 1.h,
                  color: AppColors.border,
                ),
                hSpace(8),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.login_rounded,
                            size: 14.r,
                            color: AppColors.success,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'admin.attendance.checkIn'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.placeholder,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                hSpace(2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    record.checkIn,
                                    style: AppTextStyles.font13SemiBold
                                        .copyWith(
                                          color: record.checkIn != '--:--'
                                              ? AppColors.textPrimary
                                              : AppColors.placeholder,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1.w,
                      height: 26.h,
                      margin: EdgeInsets.symmetric(horizontal: 8.w),
                      color: AppColors.border,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.logout_rounded,
                            size: 14.r,
                            color: AppColors.warning,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'admin.attendance.checkOut'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.placeholder,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                hSpace(2),
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    record.checkOut,
                                    style: AppTextStyles.font13SemiBold
                                        .copyWith(
                                          color: record.checkOut != '--:--'
                                              ? AppColors.textPrimary
                                              : AppColors.placeholder,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
