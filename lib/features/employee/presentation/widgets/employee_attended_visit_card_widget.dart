import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/customer_visits/admin_customer_visit_doc_viewer_dialog_widget.dart';

class EmployeeAttendedVisitCardWidget extends StatelessWidget {
  const EmployeeAttendedVisitCardWidget({
    required this.visit,
    required this.onRecordOutcomeTap,
    this.nextVisit,
    this.onNextVisitTap,
    super.key,
  });

  final CustomerVisitModel visit;
  final VoidCallback onRecordOutcomeTap;
  final CustomerVisitModel? nextVisit;
  final VoidCallback? onNextVisitTap;

  String? _getSchedulerDisplayName(CustomerVisitModel visit) {
    if (visit.createdByName != null &&
        visit.createdByName!.trim().isNotEmpty &&
        !visit.createdByName!.startsWith('01M')) {
      return visit.createdByName;
    }
    final createdBy = visit.createdBy;
    if (createdBy != null &&
        createdBy.isNotEmpty &&
        !createdBy.startsWith('01M') &&
        createdBy.length < 20) {
      return createdBy;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isCompleted = visit.status == 'completed';
    final schedulerName = _getSchedulerDisplayName(visit);

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

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isCompleted
              ? AppColors.success.withValues(alpha: 0.3)
              : AppColors.warning.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: (isCompleted ? AppColors.success : AppColors.warning)
                .withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? AppColors.softGreenBackground
                      : AppColors.softBrandBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted
                      ? Icons.task_alt_rounded
                      : Icons.pending_actions_rounded,
                  color: isCompleted
                      ? AppColors.success
                      : AppColors.brandPrimaryDark,
                  size: 24.r,
                ),
              ),
              wSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isCompleted
                          ? 'attendance.visitCompletedSuccess'.tr(
                              context: context,
                            )
                          : 'attendance.visitAttendedReportPending'.tr(
                              context: context,
                            ),
                      style: AppTextStyles.font14Bold.copyWith(
                        color: isCompleted
                            ? AppColors.success
                            : AppColors.brandPrimaryDark,
                      ),
                    ),
                    hSpace(4),
                    Text(
                      isCompleted
                          ? 'attendance.visitCompletedSuccessDesc'.tr(
                              context: context,
                            )
                          : 'attendance.visitAttendedReportPendingDesc'.tr(
                              context: context,
                            ),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          hSpace(14),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            Icons.business_rounded,
                            size: 16.r,
                            color: AppColors.brandPrimary,
                          ),
                          wSpace(6),
                          Expanded(
                            child: Text(
                              visit.customerName ?? 'عميل',
                              style: AppTextStyles.font13Bold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (visit.visitTime != null &&
                        visit.visitTime!.isNotEmpty) ...[
                      wSpace(8),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          '🕒 ${visit.visitTime}',
                          style: AppTextStyles.font11Bold.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (schedulerName != null) ...[
                  hSpace(8),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline_rounded,
                        size: 14.r,
                        color: AppColors.textSecondary,
                      ),
                      wSpace(6),
                      Text(
                        'admin.visits.scheduledBy'.tr(context: context),
                        style: AppTextStyles.font11Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      wSpace(4),
                      Text(
                        schedulerName,
                        style: AppTextStyles.font11Bold.copyWith(
                          color: AppColors.brandPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                ],
                if (visit.title != null && visit.title!.trim().isNotEmpty) ...[
                  hSpace(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        size: 14.r,
                        color: AppColors.brandPrimary,
                      ),
                      wSpace(6),
                      Expanded(
                        child: Text(
                          visit.title!,
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (visit.attendees.isNotEmpty) ...[
                  hSpace(8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.people_alt_outlined,
                        size: 14.r,
                        color: AppColors.brandPrimary,
                      ),
                      wSpace(6),
                      Expanded(
                        child: Text(
                          '${'admin.visits.attendees'.tr(context: context)}: ${visit.attendees.join('، ')}',
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
                if (visit.outcome != null &&
                    visit.outcome!.trim().isNotEmpty) ...[
                  hSpace(8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.visits.outcome'.tr(context: context),
                          style: AppTextStyles.font11Bold.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                        hSpace(4),
                        Text(
                          visit.outcome!,
                          style: AppTextStyles.font11Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                if (planDocName != null && planDocName.isNotEmpty) ...[
                  hSpace(8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBrandBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.brandPrimary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.visits.planDocTitle'.tr(context: context),
                          style: AppTextStyles.font10Bold.copyWith(
                            color: AppColors.brandPrimaryDark,
                          ),
                        ),
                        hSpace(4),
                        Row(
                          children: [
                            Icon(
                              Icons.description_outlined,
                              size: 15.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(6),
                            Expanded(
                              child: Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(
                                  planDocName,
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            wSpace(6),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      AdminCustomerVisitDocViewerDialogWidget(
                                        fileName: planDocName,
                                        fileUrl: planDocUrl,
                                      ),
                                );
                              },
                              child: Text(
                                'admin.visits.viewDoc'.tr(context: context),
                                style: AppTextStyles.font11Bold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                if (outcomeDocName != null && outcomeDocName.isNotEmpty) ...[
                  hSpace(8),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softBlueBackground,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(
                        color: AppColors.info.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.visits.outcomeDocTitle'.tr(context: context),
                          style: AppTextStyles.font10Bold.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                        hSpace(4),
                        Row(
                          children: [
                            Icon(
                              Icons.assignment_turned_in_outlined,
                              size: 15.r,
                              color: AppColors.info,
                            ),
                            wSpace(6),
                            Expanded(
                              child: Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(
                                  outcomeDocName,
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.textPrimary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            wSpace(6),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) =>
                                      AdminCustomerVisitDocViewerDialogWidget(
                                        fileName: outcomeDocName,
                                        fileUrl: outcomeDocUrl,
                                      ),
                                );
                              },
                              child: Text(
                                'admin.visits.viewDoc'.tr(context: context),
                                style: AppTextStyles.font11Bold.copyWith(
                                  color: AppColors.info,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          hSpace(14),
          CustomButton(
            text: isCompleted
                ? 'admin.visits.editOutcome'.tr(context: context)
                : 'admin.visits.recordOutcome'.tr(context: context),
            onTap: onRecordOutcomeTap,
          ),
          if (nextVisit != null && onNextVisitTap != null) ...[
            hSpace(10),
            OutlinedButton(
              onPressed: onNextVisitTap,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                side: const BorderSide(
                  color: AppColors.brandPrimary,
                  width: 1.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.directions_walk_rounded,
                    size: 18.r,
                    color: AppColors.brandPrimary,
                  ),
                  wSpace(8),
                  Flexible(
                    child: Text(
                      '${'attendance.nextScheduledVisit'.tr(context: context)}: ${nextVisit!.customerName ?? 'عميل'}${nextVisit!.visitTime != null && nextVisit!.visitTime!.isNotEmpty ? ' (🕒 ${nextVisit!.visitTime})' : ''}',
                      style: AppTextStyles.font12Bold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
