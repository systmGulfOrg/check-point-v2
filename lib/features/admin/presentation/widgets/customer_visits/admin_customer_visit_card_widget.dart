import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'admin_record_visit_outcome_dialog_widget.dart';

class AdminCustomerVisitCardWidget extends StatelessWidget {
  const AdminCustomerVisitCardWidget({
    required this.visit,
    required this.onRecordOutcome,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function(
    String outcome,
    String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  ) onRecordOutcome;

  @override
  Widget build(BuildContext context) {
    final isCancelled = visit.status == 'cancelled';
    final hasOutcome =
        visit.outcome != null && visit.outcome!.trim().isNotEmpty;
    final isVisitedPendingReport =
        (visit.status == 'visited' || visit.status == 'completed') &&
        !hasOutcome;
    final isCompleted =
        (visit.status == 'completed' || visit.status == 'visited') &&
        hasOutcome;

    final Color statusColor;
    final String statusText;
    final IconData statusIcon;

    if (isCompleted) {
      statusColor = AppColors.success;
      statusText = 'admin.visits.statusCompleted'.tr(context: context);
      statusIcon = Icons.check_circle_rounded;
    } else if (isVisitedPendingReport) {
      statusColor = const Color(0xFFD97706);
      statusText =
          'admin.visits.statusVisitedPendingReport'.tr(context: context);
      statusIcon = Icons.pending_actions_rounded;
    } else if (isCancelled) {
      statusColor = AppColors.error;
      statusText = 'admin.visits.statusCancelled'.tr(context: context);
      statusIcon = Icons.cancel_rounded;
    } else {
      statusColor = AppColors.brandPrimary;
      statusText = 'admin.visits.statusScheduled'.tr(context: context);
      statusIcon = Icons.schedule_rounded;
    }

    final scheduledBy = visit.createdByName ?? visit.createdBy;

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
                    Icon(statusIcon, color: statusColor, size: 14.r),
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

          // Scheduled By (مين اللي جدول الزيارة)
          if (scheduledBy != null && scheduledBy.trim().isNotEmpty) ...[
            SizedBox(height: 6.h),
            Row(
              children: [
                Icon(
                  Icons.person_outline_rounded,
                  size: 14.r,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 5.w),
                Text(
                  '${'admin.visits.scheduledBy'.tr(context: context)}: ',
                  style: AppTextStyles.font12Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                Expanded(
                  child: Text(
                    scheduledBy,
                    style: AppTextStyles.font12Bold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],

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
              onTap: () => AppDocumentViewerDialogWidget.show(
                context,
                fileName: visit.documentName!,
                fileUrl: visit.documentUrl,
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

          // Notice for Visited Pending Report (تم الحضور - ناقص تقرير الزيارة)
          if (isVisitedPendingReport) ...[
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBEB),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: const Color(0xFFF59E0B).withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: const Color(0xFFD97706),
                    size: 16.r,
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: Text(
                      'admin.visits.pendingReportNotice'.tr(context: context),
                      style: AppTextStyles.font12Medium.copyWith(
                        color: const Color(0xFFB45309),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Outcome Report ("ما حدث في الزيارة")
          if (isCompleted &&
              visit.outcome != null &&
              visit.outcome!.isNotEmpty) ...[
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
                  onSubmit:
                      (outcome, status, notes, documentName, documentUrl) =>
                          onRecordOutcome(
                            outcome,
                            status,
                            notes,
                            documentName,
                            documentUrl,
                          ),
                ),
              ),
              icon: Icon(
                isCompleted ? Icons.edit_note_rounded : Icons.add_task_rounded,
                size: 16.r,
                color: isVisitedPendingReport
                    ? const Color(0xFFD97706)
                    : AppColors.brandPrimary,
              ),
              label: Text(
                isCompleted
                    ? 'admin.visits.editOutcome'.tr(context: context)
                    : 'admin.visits.recordOutcome'.tr(context: context),
                style: AppTextStyles.font12Bold.copyWith(
                  color: isVisitedPendingReport
                      ? const Color(0xFFD97706)
                      : AppColors.brandPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
