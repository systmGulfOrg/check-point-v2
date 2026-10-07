import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
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
  final Future<void> Function(
    String outcome,
    String status,
    String? notes,
    String? documentName,
    String? documentUrl,
  ) onSubmit;

  @override
  State<AdminRecordVisitOutcomeDialogWidget> createState() =>
      _AdminRecordVisitOutcomeDialogWidgetState();
}

class _AdminRecordVisitOutcomeDialogWidgetState
    extends State<AdminRecordVisitOutcomeDialogWidget> {
  late final TextEditingController outcomeController;
  late final TextEditingController notesController;
  String selectedStatus = 'completed';
  String? attachedDocName;
  String? attachedDocUrl;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    outcomeController = TextEditingController(text: widget.visit.outcome ?? '');
    notesController = TextEditingController(text: widget.visit.notes ?? '');
    attachedDocName = widget.visit.documentName;
    attachedDocUrl = widget.visit.documentUrl;
    selectedStatus =
        widget.visit.status == 'cancelled' ? 'cancelled' : 'completed';
  }

  @override
  void dispose() {
    outcomeController.dispose();
    notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'pdf',
          'png',
          'jpg',
          'jpeg',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'txt',
        ],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        setState(() {
          attachedDocName = file.name;
          attachedDocUrl = file.path ?? 'file://${file.name}';
        });
        if (mounted) {
          CustomSnackBar.showSuccess(
            context,
            message: 'admin.visits.docAttached'.tr(context: context),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          message: 'حدث خطأ أثناء اختيار الملف'.tr(),
        );
      }
    }
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
      attachedDocName,
      attachedDocUrl,
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
            SizedBox(height: 16.h),
            Text(
              'admin.visits.outcomeDocumentSection'.tr(context: context),
              style: AppTextStyles.font12Medium,
            ),
            SizedBox(height: 8.h),
            if (attachedDocName != null && attachedDocName!.isNotEmpty)
              Builder(
                builder: (context) {
                  final isImg = attachedDocName!.toLowerCase().endsWith('.png') ||
                      attachedDocName!.toLowerCase().endsWith('.jpg') ||
                      attachedDocName!.toLowerCase().endsWith('.jpeg');
                  final isPdf = attachedDocName!.toLowerCase().endsWith('.pdf');
                  final docIcon = isImg
                      ? Icons.image_rounded
                      : isPdf
                      ? Icons.picture_as_pdf_rounded
                      : Icons.description_rounded;
                  final docIconColor = isImg
                      ? AppColors.info
                      : isPdf
                      ? AppColors.error
                      : AppColors.brandPrimary;

                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: AppColors.selectedBackground,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColors.brandPrimary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          docIcon,
                          color: docIconColor,
                          size: 20.r,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Directionality(
                            textDirection: ui.TextDirection.ltr,
                            child: Text(
                              attachedDocName!,
                              style: AppTextStyles.font12Medium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.error,
                            size: 18.r,
                          ),
                          onPressed: () {
                            setState(() {
                              attachedDocName = null;
                              attachedDocUrl = null;
                            });
                          },
                          tooltip: 'admin.visits.removeDoc'.tr(context: context),
                        ),
                      ],
                    ),
                  );
                },
              )
            else
              InkWell(
                onTap: _pickDocument,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.fieldBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColors.border,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.attach_file_rounded,
                        size: 18.r,
                        color: AppColors.brandPrimary,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'admin.visits.attachOutcomeDoc'.tr(context: context),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
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
