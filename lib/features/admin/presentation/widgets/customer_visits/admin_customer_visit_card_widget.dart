import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_attendance_location_sheet_widget.dart';
import 'admin_cancel_customer_visit_dialog_widget.dart';
import 'admin_customer_visit_logs_sheet_widget.dart';
import 'admin_record_visit_outcome_dialog_widget.dart';
import 'admin_reschedule_customer_visit_dialog_widget.dart';

class AdminCustomerVisitCardWidget extends StatelessWidget {
  const AdminCustomerVisitCardWidget({
    required this.visit,
    required this.onRecordOutcome,
    this.onRescheduleVisit,
    this.onCancelVisit,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function(
    String outcome,
    String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  )
  onRecordOutcome;
  final Future<void> Function({
    required String visitDate,
    String? visitTime,
    String? reason,
  })?
  onRescheduleVisit;
  final Future<void> Function(String? reason)? onCancelVisit;

  void _openAttendanceCheckIn(BuildContext context) async {
    final visitsCubit = context.read<AdminCustomerVisitsCubit?>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider<EmployeeAttendanceCubit>(
        create: (_) => sl<EmployeeAttendanceCubit>(),
        child: EmployeeAttendanceLocationSheetWidget(
          isCheckOut: false,
          initialVisit: visit,
          initialType: 'Customer',
        ),
      ),
    );
    if (context.mounted && visitsCubit != null) {
      if (visit.customerId != null && visit.customerId!.isNotEmpty) {
        await visitsCubit.loadCustomerVisits(visit.customerId!);
      } else {
        await visitsCubit.loadAllVisits();
      }
    }
  }

  void _openRescheduleDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AdminRescheduleCustomerVisitDialogWidget(
        visit: visit,
        onConfirm: ({required visitDate, visitTime, reason}) async {
          if (onRescheduleVisit != null) {
            await onRescheduleVisit!(
              visitDate: visitDate,
              visitTime: visitTime,
              reason: reason,
            );
          } else {
            final cubit = context.read<AdminCustomerVisitsCubit>();
            final success = await cubit.rescheduleVisit(
              visitId: visit.id ?? '',
              customerId: visit.customerId ?? '',
              visitDate: visitDate,
              visitTime: visitTime,
              reason: reason,
            );
            if (context.mounted) {
              if (success) {
                CustomSnackBar.showSuccess(
                  context,
                  message: 'تم تعديل موعد الزيارة بنجاح',
                );
              } else {
                CustomSnackBar.showError(
                  context,
                  message: 'حدث خطأ أثناء تعديل موعد الزيارة',
                );
              }
            }
          }
        },
      ),
    );
  }

  void _openCancelDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AdminCancelCustomerVisitDialogWidget(
        visit: visit,
        onConfirm: (reason) async {
          if (onCancelVisit != null) {
            await onCancelVisit!(reason);
          } else {
            final cubit = context.read<AdminCustomerVisitsCubit>();
            final success = await cubit.cancelVisit(
              visitId: visit.id ?? '',
              customerId: visit.customerId ?? '',
              reason: reason,
            );
            if (context.mounted) {
              if (success) {
                CustomSnackBar.showSuccess(
                  context,
                  message: 'تم إلغاء الزيارة بنجاح',
                );
              } else {
                CustomSnackBar.showError(
                  context,
                  message: 'حدث خطأ أثناء إلغاء الزيارة',
                );
              }
            }
          }
        },
      ),
    );
  }

  void _openLogsSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AdminCustomerVisitLogsSheetWidget(visit: visit),
    );
  }

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
      statusColor = AppColors.amberStatus;
      statusText = 'admin.visits.statusVisitedPendingReport'.tr(
        context: context,
      );
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

    final rawScheduledBy = visit.createdByName ?? visit.createdBy;
    final isOpaqueId =
        rawScheduledBy != null &&
        rawScheduledBy.length >= 15 &&
        !rawScheduledBy.contains(' ');
    final scheduledBy = isOpaqueId ? null : rawScheduledBy;

    final planDocName =
        visit.planDocumentName ??
        (visit.outcomeDocumentName != null &&
                visit.outcomeDocumentName != visit.documentName
            ? visit.documentName
            : (visit.outcome == null ? visit.documentName : null));
    final planDocUrl =
        visit.planDocumentUrl ??
        (visit.outcomeDocumentUrl != null &&
                visit.outcomeDocumentUrl != visit.documentUrl
            ? visit.documentUrl
            : (visit.outcome == null ? visit.documentUrl : null));

    final outcomeDocName =
        visit.outcomeDocumentName ??
        (visit.outcome != null ? visit.documentName : null);
    final outcomeDocUrl =
        visit.outcomeDocumentUrl ??
        (visit.outcome != null ? visit.documentUrl : null);

    return InkWell(
      onTap: isCancelled ? null : () => _openAttendanceCheckIn(context),
      borderRadius: BorderRadius.circular(14.r),
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(statusIcon, color: statusColor, size: 14.r),
                        SizedBox(width: 4.w),
                        Flexible(
                          child: Text(
                            statusText,
                            style: AppTextStyles.font12Bold.copyWith(
                              color: statusColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    size: 18.r,
                    color: AppColors.textSecondary,
                  ),
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  onSelected: (action) {
                    switch (action) {
                      case 'reschedule':
                        _openRescheduleDialog(context);
                      case 'cancel':
                        _openCancelDialog(context);
                      case 'logs':
                        _openLogsSheet(context);
                    }
                  },
                  itemBuilder: (ctx) => [
                    if (!isCancelled && !isCompleted) ...[
                      PopupMenuItem<String>(
                        value: 'reschedule',
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit_calendar_rounded,
                              size: 18.r,
                              color: AppColors.brandPrimary,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'تعديل موعد الزيارة',
                              style: AppTextStyles.font13Medium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'cancel',
                        child: Row(
                          children: [
                            Icon(
                              Icons.event_busy_rounded,
                              size: 18.r,
                              color: AppColors.error,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'إلغاء الزيارة',
                              style: AppTextStyles.font13Medium.copyWith(
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    PopupMenuItem<String>(
                      value: 'logs',
                      child: Row(
                        children: [
                          Icon(
                            Icons.history_rounded,
                            size: 18.r,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'سجل نشاط الزيارة (Log)',
                            style: AppTextStyles.font13Medium.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8.h),

            if (visit.visitDate != null || visit.visitTime != null) ...[
              Row(
                children: [
                  Icon(
                    Icons.calendar_today_rounded,
                    size: 13.r,
                    color: AppColors.placeholder,
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      '${visit.visitDate != null ? AppDateFormatter.formatDateString(visit.visitDate) : ''}${visit.visitTime != null ? ' • ${AppDateFormatter.formatReadableTime(visit.visitTime)}' : ''}',
                      style: AppTextStyles.font12Medium.copyWith(
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            ],

            if (visit.customerName != null &&
                visit.customerName!.isNotEmpty) ...[
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

            Text(
              visit.title ?? 'admin.visits.title'.tr(context: context),
              style: AppTextStyles.font14Bold,
            ),

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

            if (planDocName != null && planDocName.isNotEmpty) ...[
              SizedBox(height: 8.h),
              InkWell(
                onTap: () => AppDocumentViewerDialogWidget.show(
                  context,
                  fileName: planDocName,
                  fileUrl: planDocUrl,
                ),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.selectedBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: AppColors.brandPrimary,
                        size: 16.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${'admin.visits.planDocTitle'.tr(context: context)}: ',
                        style: AppTextStyles.font11Bold.copyWith(
                          color: AppColors.brandPrimaryDark,
                        ),
                      ),
                      Flexible(
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Text(
                            planDocName,
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

            if (outcomeDocName != null && outcomeDocName.isNotEmpty) ...[
              SizedBox(height: 8.h),
              InkWell(
                onTap: () => AppDocumentViewerDialogWidget.show(
                  context,
                  fileName: outcomeDocName,
                  fileUrl: outcomeDocUrl,
                ),
                borderRadius: BorderRadius.circular(8.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softBlueBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: AppColors.info.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.assignment_turned_in_outlined,
                        color: AppColors.info,
                        size: 16.r,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        '${'admin.visits.outcomeDocTitle'.tr(context: context)}: ',
                        style: AppTextStyles.font11Bold.copyWith(
                          color: AppColors.info,
                        ),
                      ),
                      Flexible(
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: Text(
                            outcomeDocName,
                            style: AppTextStyles.font12Medium.copyWith(
                              color: AppColors.info,
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
                        color: AppColors.info,
                        size: 14.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],

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

            if (isCancelled) ...[
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.error.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.error.withValues(alpha: 0.25),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.cancel_outlined,
                      color: AppColors.error,
                      size: 16.r,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        visit.notes != null && visit.notes!.isNotEmpty
                            ? 'الزيارة ملغاة: ${visit.notes}'
                            : 'تم إلغاء هذه الزيارة',
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (isVisitedPendingReport) ...[
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.amberSoftBg,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: AppColors.warning.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.amberStatus,
                      size: 16.r,
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'admin.visits.pendingReportNotice'.tr(context: context),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.amberDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

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

            SizedBox(height: 12.h),
            Row(
              children: [
                InkWell(
                  onTap: () => _openLogsSheet(context),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 5.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.history_rounded,
                          size: 14.r,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'سجل النشاط (${visit.logs.length})',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                if (!isCancelled &&
                    !isCompleted &&
                    !isVisitedPendingReport) ...[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.brandPrimary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 8.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () => _openAttendanceCheckIn(context),
                    icon: Icon(
                      Icons.location_on_rounded,
                      size: 16.r,
                      color: Colors.white,
                    ),
                    label: Text(
                      'تسجيل حضور الزيارة',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
                if (isVisitedPendingReport || isCompleted) ...[
                  TextButton.icon(
                    onPressed: () {
                      final visitsCubit = context
                          .read<AdminCustomerVisitsCubit>();
                      showDialog<void>(
                        context: context,
                        builder: (_) =>
                            BlocProvider<AdminCustomerVisitsCubit>.value(
                              value: visitsCubit,
                              child: AdminRecordVisitOutcomeDialogWidget(
                                visit: visit,
                                onSubmit:
                                    (
                                      outcome,
                                      status,
                                      notes,
                                      documentName,
                                      documentUrl,
                                    ) => onRecordOutcome(
                                      outcome,
                                      status,
                                      notes,
                                      documentName,
                                      documentUrl,
                                    ),
                              ),
                            ),
                      );
                    },
                    icon: Icon(
                      isCompleted
                          ? Icons.edit_note_rounded
                          : Icons.assignment_turned_in_rounded,
                      size: 16.r,
                      color: isVisitedPendingReport
                          ? AppColors.amberStatus
                          : AppColors.brandPrimary,
                    ),
                    label: Text(
                      isCompleted
                          ? 'admin.visits.editOutcome'.tr(context: context)
                          : 'admin.visits.recordOutcome'.tr(context: context),
                      style: AppTextStyles.font12Bold.copyWith(
                        color: isVisitedPendingReport
                            ? AppColors.amberStatus
                            : AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
