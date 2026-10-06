import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

class AdminRecordVisitOutcomeDialogWidget extends StatefulWidget {
  const AdminRecordVisitOutcomeDialogWidget({
    required this.visit,
    required this.onSubmit,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function(String outcome, String status, String? notes)
  onSubmit;

  @override
  State<AdminRecordVisitOutcomeDialogWidget> createState() =>
      _AdminRecordVisitOutcomeDialogWidgetState();
}

class _AdminRecordVisitOutcomeDialogWidgetState
    extends State<AdminRecordVisitOutcomeDialogWidget> {
  late final TextEditingController outcomeController;
  late final TextEditingController notesController;
  String selectedStatus = 'completed';
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    outcomeController = TextEditingController(text: widget.visit.outcome ?? '');
    notesController = TextEditingController(text: widget.visit.notes ?? '');
    selectedStatus = widget.visit.status == 'scheduled'
        ? 'completed'
        : widget.visit.status;
  }

  @override
  void dispose() {
    outcomeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _handleSubmit() async {
    final outcome = outcomeController.text.trim();
    if (outcome.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'يرجى كتابة ما تم وما حدث في الزيارة'.tr(),
      );
      return;
    }

    setState(() => isSubmitting = true);
    await widget.onSubmit(
      outcome,
      selectedStatus,
      notesController.text.trim().isNotEmpty
          ? notesController.text.trim()
          : null,
    );
    if (mounted) {
      setState(() => isSubmitting = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        color: AppColors.softGreenBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.assignment_turned_in_outlined,
                        color: AppColors.success,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      'admin.visits.recordOutcome'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 20.r),
                ),
              ],
            ),
            const Divider(color: AppColors.border),
            SizedBox(height: 12.h),
            Text(
              'admin.visits.status'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                _buildStatusOption(
                  'completed',
                  'admin.visits.statusCompleted',
                  AppColors.success,
                ),
                SizedBox(width: 8.w),
                _buildStatusOption(
                  'cancelled',
                  'admin.visits.statusCancelled',
                  AppColors.error,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'admin.visits.outcome'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: outcomeController,
              hintText: 'admin.visits.outcomeHint'.tr(context: context),
              maxLines: 4,
            ),
            SizedBox(height: 16.h),
            Text(
              'admin.visits.notes'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: notesController,
              hintText: 'admin.visits.notesHint'.tr(context: context),
              maxLines: 2,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              text: 'admin.visits.recordOutcome'.tr(context: context),
              isLoading: isSubmitting,
              onTap: _handleSubmit,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusOption(
    String statusKey,
    String labelKey,
    Color activeColor,
  ) {
    final isSelected = selectedStatus == statusKey;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => selectedStatus = statusKey),
        borderRadius: BorderRadius.circular(10.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected
                ? activeColor.withValues(alpha: 0.12)
                : AppColors.cardBackground,
            border: Border.all(
              color: isSelected ? activeColor : AppColors.border,
              width: isSelected ? 1.5 : 1,
            ),
            borderRadius: BorderRadius.circular(10.r),
          ),
          alignment: Alignment.center,
          child: Text(
            labelKey.tr(context: context),
            style: AppTextStyles.font12Bold.copyWith(
              color: isSelected ? activeColor : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
