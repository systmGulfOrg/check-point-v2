import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/disciplinary_models.dart';
import 'disciplinary_appeal_dialog_widget.dart';
import 'disciplinary_violation_status_badge_widget.dart';

class DisciplinaryViolationCardWidget extends StatelessWidget {
  const DisciplinaryViolationCardWidget({
    super.key,
    required this.violation,
    required this.onAppeal,
    this.currency = 'EGP',
  });

  final DisciplinaryViolationModel violation;
  final ValueChanged<String> onAppeal;
  final String currency;

  String _formatCurrency(String curr) {
    if (curr.toUpperCase() == 'SAR') return 'ر.س';
    if (curr.toUpperCase() == 'EGP') return 'ج.م';
    if (curr.toUpperCase() == 'AED') return 'د.إ';
    if (curr.toUpperCase() == 'USD') return '\$';
    return curr;
  }

  String _formatDate(BuildContext context) {
    try {
      final parsed = DateTime.tryParse(violation.violationDate);
      if (parsed != null) {
        return DateFormat.yMMMd(context.locale.toString()).format(parsed);
      }
    } catch (_) {}
    return violation.violationDate.length >= 10
        ? violation.violationDate.substring(0, 10)
        : violation.violationDate;
  }

  @override
  Widget build(BuildContext context) {
    final currencyLabel = _formatCurrency(currency);
    final penaltyText = violation.formattedPenaltyText(currencyLabel);
    final isWarning = violation.isWarning;

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: AppCardContainerWidget(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32.r,
                  height: 32.r,
                  decoration: BoxDecoration(
                    color: isWarning
                        ? AppColors.softYellowBackground
                        : AppColors.softRedBackground,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isWarning
                        ? Icons.warning_amber_rounded
                        : Icons.gavel_rounded,
                    size: 18.r,
                    color: isWarning ? AppColors.warning : AppColors.error,
                  ),
                ),
                wSpace(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        violation.ruleDescriptionAr ?? 'مخالفة مسلكية',
                        style: AppTextStyles.font14Bold,
                      ),
                      hSpace(2),
                      Text(
                        _formatDate(context),
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                AppStatusPillWidget(
                  label: 'المرة ${violation.occurrenceIndex}',
                  color: AppColors.brandInk,
                  backgroundColor: AppColors.softBrandBackground,
                ),
              ],
            ),
            hSpace(10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isWarning
                    ? AppColors.softYellowBackground.withValues(alpha: 0.5)
                    : AppColors.softRedBackground.withValues(alpha: 0.4),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(
                    isWarning
                        ? Icons.info_outline_rounded
                        : Icons.remove_circle_outline_rounded,
                    size: 16.r,
                    color: isWarning ? AppColors.warning : AppColors.error,
                  ),
                  wSpace(6),
                  Expanded(
                    child: Text(
                      penaltyText,
                      style: AppTextStyles.font12Bold.copyWith(
                        color: isWarning ? AppColors.warningOrange : AppColors.error,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (violation.notes != null && violation.notes!.trim().isNotEmpty) ...[
              hSpace(8),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 14.r,
                      color: AppColors.placeholder,
                    ),
                    wSpace(6),
                    Expanded(
                      child: Text(
                        violation.notes!,
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            hSpace(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DisciplinaryViolationStatusBadgeWidget(
                  status: violation.status,
                ),
                if (!violation.hasPendingAppeal &&
                    (violation.status == 'APPROVED' ||
                        violation.status == 'DEDUCTED_IN_PAYROLL'))
                  OutlinedButton.icon(
                    onPressed: () => _openAppealDialog(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.brandPrimary,
                      side: const BorderSide(color: AppColors.brandPrimary),
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    icon: Icon(Icons.edit_note_rounded, size: 16.r),
                    label: Text(
                      'تقديم تظلم',
                      style: AppTextStyles.font11Medium.copyWith(
                        color: AppColors.brandPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else if (violation.hasPendingAppeal)
                  AppStatusPillWidget(
                    label: 'التظلم قيد المراجعة',
                    icon: Icons.hourglass_top_rounded,
                    color: AppColors.warningOrange,
                    backgroundColor: AppColors.softYellowBackground,
                  )
                else if (violation.appealStatus != null)
                  AppStatusPillWidget(
                    label: violation.appealStatus == 'ACCEPTED'
                        ? 'تم قبول التظلم'
                        : 'تم رفض التظلم',
                    color: violation.appealStatus == 'ACCEPTED'
                        ? AppColors.success
                        : AppColors.error,
                    backgroundColor: violation.appealStatus == 'ACCEPTED'
                        ? AppColors.softGreenBackground
                        : AppColors.softRedBackground,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openAppealDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DisciplinaryAppealDialogWidget(
        violationDescription: violation.ruleDescriptionAr ?? '',
        onSubmit: onAppeal,
      ),
    );
  }
}
