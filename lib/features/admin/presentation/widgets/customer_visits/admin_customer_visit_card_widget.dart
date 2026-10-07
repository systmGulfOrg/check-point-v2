import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'admin_customer_visit_doc_viewer_dialog_widget.dart';
import 'admin_record_visit_outcome_dialog_widget.dart';

class AdminCustomerVisitCardWidget extends StatelessWidget {
  const AdminCustomerVisitCardWidget({
    required this.visit,
    required this.onRecordOutcome,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function(String outcome, String status, String? notes)
  onRecordOutcome;

  @override
  Widget build(BuildContext context) {
    final isCompleted = visit.status == 'completed';
    final isCancelled = visit.status == 'cancelled';
    final statusColor = isCompleted
        ? AppColors.success
        : isCancelled
        ? AppColors.error
        : AppColors.brandPrimary;
    final statusText = isCompleted
        ? 'admin.visits.statusCompleted'.tr(context: context)
        : isCancelled
        ? 'admin.visits.statusCancelled'.tr(context: context)
        : 'admin.visits.statusScheduled'.tr(context: context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: EdgeInsets.all(14.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Status badge & Date/Time
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isCompleted
                          ? Icons.check_circle_rounded
                          : isCancelled
                          ? Icons.cancel_rounded
                          : Icons.schedule_rounded,
                      color: statusColor,
                      size: 14.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      statusText,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 13.r,
                    color: AppColors.placeholder,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    '${visit.visitDate != null ? AppDateFormatter.formatDateString(visit.visitDate) : ''} • ${visit.visitTime != null ? AppDateFormatter.formatTimeString(visit.visitTime) : ''}',
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),

          // Customer Name (if available)
          if (visit.customerName != null && visit.customerName!.isNotEmpty) ...[
            Row(
              children: [
                Icon(
                  Icons.business_rounded,
                  size: 14.r,
                  color: AppColors.info,
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    visit.customerName!,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.info,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
          ],

          // Title
          Text(
            visit.title ?? 'admin.visits.title'.tr(context: context),
            style: AppTextStyles.font14Bold,
          ),

          // Attendees ("مين حضر / مين معايا")
          if (visit.attendees.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.people_alt_outlined,
                  size: 15.r,
                  color: AppColors.brandPrimary,
                ),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    '${'admin.visits.attendees'.tr(context: context)}: ${visit.attendees.join('، ')}',
                    style: AppTextStyles.font12Regular.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ],

          // Attached Document preview chip
          if (visit.documentName != null && visit.documentName!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            InkWell(
              onTap: () => showDialog<void>(
                context: context,
                builder: (_) => AdminCustomerVisitDocViewerDialogWidget(
                  fileName: visit.documentName!,
                  fileUrl: visit.documentUrl,
                ),
              ),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.selectedBackground,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.picture_as_pdf_rounded,
                      color: AppColors.error,
                      size: 16.r,
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: Text(
                          visit.documentName!,
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                            decoration: TextDecoration.underline,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Icon(
                      Icons.visibility_outlined,
                      color: AppColors.brandPrimary,
                      size: 14.r,
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Notes
          if (visit.notes != null && visit.notes!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: AppColors.fieldBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    size: 14.r,
                    color: AppColors.placeholder,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      visit.notes!,
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Outcome Report ("حصل إيه")
          if (visit.outcome != null && visit.outcome!.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: AppColors.softGreenBackground,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: AppColors.success.withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: AppColors.success,
                        size: 15.r,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'admin.visits.outcome'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    visit.outcome!,
                    style: AppTextStyles.font12Medium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Action button to record or edit outcome
          SizedBox(height: 10.h),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton.icon(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (_) => AdminRecordVisitOutcomeDialogWidget(
                  visit: visit,
                  onSubmit: onRecordOutcome,
                ),
              ),
              icon: Icon(
                isCompleted ? Icons.edit_note_rounded : Icons.add_task_rounded,
                size: 16.r,
                color: AppColors.brandPrimary,
              ),
              label: Text(
                isCompleted
                    ? 'تعديل تقرير الزيارة'
                    : 'admin.visits.recordOutcome'.tr(context: context),
                style: AppTextStyles.font12Bold.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
