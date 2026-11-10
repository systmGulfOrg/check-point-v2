import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../data/models/disciplinary_models.dart';
import 'disciplinary_appeal_dialog_widget.dart';

class DisciplinaryViolationCardWidget extends StatelessWidget {
  const DisciplinaryViolationCardWidget({
    super.key,
    required this.violation,
    required this.onAppeal,
  });

  final DisciplinaryViolationModel violation;
  final ValueChanged<String> onAppeal;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.08),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  violation.ruleDescriptionAr ?? 'مخالفة سلوكية',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  'المرة ${violation.occurrenceIndex}',
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                violation.violationDate.length >= 10
                    ? violation.violationDate.substring(0, 10)
                    : violation.violationDate,
                style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
              ),
              Text(
                'خصم ${violation.deductedDays ?? 0} يوم (${violation.calculatedAmount} ر.س)',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
          if (violation.notes != null && violation.notes!.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              'ملاحظة: ${violation.notes}',
              style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusBadge(context),
              if (!violation.hasPendingAppeal && violation.status == 'APPROVED')
                TextButton.icon(
                  onPressed: () => _openAppealDialog(context),
                  icon: Icon(Icons.edit_note, size: 16.sp),
                  label: Text('تقديم تظلم', style: TextStyle(fontSize: 11.sp)),
                )
              else if (violation.hasPendingAppeal)
                Text(
                  'التظلم قيد المراجعة',
                  style: TextStyle(fontSize: 11.sp, color: Colors.orange[800]),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final (label, color) = switch (violation.status) {
      'APPROVED' => ('معتمد', Colors.green),
      'WAIVED' => ('معفى إدارياً', Colors.grey),
      'CANCELLED_BY_APPEAL' => ('ملغي بتظلم', Colors.blue),
      _ => ('قيد الاعتماد', Colors.orange),
    };

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
          color: color,
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
