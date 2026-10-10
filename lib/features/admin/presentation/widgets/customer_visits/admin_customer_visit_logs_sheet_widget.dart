import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

class AdminCustomerVisitLogsSheetWidget extends StatelessWidget {
  const AdminCustomerVisitLogsSheetWidget({
    required this.visit,
    super.key,
  });

  final CustomerVisitModel visit;

  String _formatTimestamp(String? iso) {
    if (iso == null || iso.isEmpty) return '';
    try {
      final dt = DateTime.parse(iso).toLocal();
      final dateStr = AppDateFormatter.formatDate(dt, pattern: 'yyyy-MM-dd');
      final timeStr = AppDateFormatter.formatTime(dt, isArabic: true, fullPeriod: true);
      return '$dateStr • $timeStr';
    } catch (_) {
      return iso;
    }
  }

  String _formatLogDetails(VisitChangeLogModel log) {
    if (log.details == null || log.details!.isEmpty) return '';
    final details = log.details!;
    if (details.startsWith('تم تعديل موعد الزيارة إلى')) {
      final formattedNewSchedule = AppDateFormatter.formatScheduleDateTime(
        log.newDate,
        log.newTime,
      );
      return 'تم تعديل موعد الزيارة إلى $formattedNewSchedule';
    }
    return details;
  }

  Widget _buildActionBadge(BuildContext context, String action) {
    Color bg;
    Color fg;
    String label;
    IconData icon;

    switch (action.toLowerCase()) {
      case 'created':
        bg = AppColors.softBlueBackground;
        fg = AppColors.info;
        label = 'إنشاء الزيارة';
        icon = Icons.add_circle_outline_rounded;
      case 'rescheduled':
        bg = AppColors.softYellowBackground;
        fg = AppColors.amberStatus;
        label = 'تعديل الموعد';
        icon = Icons.edit_calendar_rounded;
      case 'visited':
        bg = AppColors.softGreenBackground;
        fg = AppColors.success;
        label = 'تسجيل الحضور';
        icon = Icons.location_on_rounded;
      case 'completed':
        bg = AppColors.softGreenBackground;
        fg = AppColors.success;
        label = 'تسجيل التقرير';
        icon = Icons.assignment_turned_in_rounded;
      case 'cancelled':
        bg = AppColors.softRedBackground;
        fg = AppColors.error;
        label = 'إلغاء الزيارة';
        icon = Icons.cancel_outlined;
      default:
        bg = AppColors.pageBackground;
        fg = AppColors.textSecondary;
        label = 'تحديث البيانات';
        icon = Icons.history_rounded;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: fg.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.r, color: fg),
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyles.font12Bold.copyWith(color: fg),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logs = visit.logs;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: AppColors.brandPrimary,
                  size: 22.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'سجل نشاط وتغييرات الزيارة',
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    if (visit.customerName != null) ...[
                      SizedBox(height: 2.h),
                      Text(
                        visit.customerName!,
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary,
                  size: 20.r,
                ),
              ),
            ],
          ),
          Divider(height: 24.h, color: AppColors.border),

          if (logs.isEmpty) ...[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.history_toggle_off_rounded,
                      size: 40.r,
                      color: AppColors.textSecondary.withValues(alpha: 0.5),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'لا توجد سجلات تعديل إضافية',
                      style: AppTextStyles.font14Medium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.55,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: logs.length,
                separatorBuilder: (_, _) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final log = logs[index];
                  final action = log.action ?? 'updated';
                  final hasPreviousSchedule = (log.previousDate != null &&
                          log.previousDate!.trim().isNotEmpty) ||
                      (log.previousTime != null &&
                          log.previousTime!.trim().isNotEmpty);
                  final hasNewSchedule = (log.newDate != null &&
                          log.newDate!.trim().isNotEmpty) ||
                      (log.newTime != null &&
                          log.newTime!.trim().isNotEmpty);

                  return Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildActionBadge(context, action),
                            if (log.timestamp != null)
                              Text(
                                _formatTimestamp(log.timestamp),
                                style: AppTextStyles.font11Regular.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                          ],
                        ),
                        if (log.actorName != null && log.actorName!.isNotEmpty) ...[
                          SizedBox(height: 8.h),
                          Row(
                            children: [
                              Icon(
                                Icons.person_outline_rounded,
                                size: 14.r,
                                color: AppColors.textSecondary,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'بواسطة: ${log.actorName}',
                                style: AppTextStyles.font12Medium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (hasPreviousSchedule || hasNewSchedule) ...[
                          SizedBox(height: 6.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                if (hasPreviousSchedule) ...[
                                  Flexible(
                                    child: Text(
                                      AppDateFormatter.formatScheduleDateTime(
                                        log.previousDate,
                                        log.previousTime,
                                      ),
                                      style: AppTextStyles.font12Medium.copyWith(
                                        color: AppColors.textSecondary,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(
                                    Icons.arrow_forward_rounded,
                                    size: 14.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                  SizedBox(width: 8.w),
                                ],
                                Flexible(
                                  child: Text(
                                    AppDateFormatter.formatScheduleDateTime(
                                      log.newDate,
                                      log.newTime,
                                    ),
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: AppColors.brandPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        if (log.details != null && log.details!.isNotEmpty) ...[
                          SizedBox(height: 6.h),
                          Text(
                            _formatLogDetails(log),
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.textSecondary,
                              height: 1.35,
                            ),
                          ),
                        ],
                        if (log.reason != null &&
                            log.reason!.isNotEmpty &&
                            log.reason != log.details) ...[
                          SizedBox(height: 4.h),
                          Text(
                            'السبب: ${log.reason}',
                            style: AppTextStyles.font12Regular.copyWith(
                              color: AppColors.error,
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ],
      ),
    );
  }
}
