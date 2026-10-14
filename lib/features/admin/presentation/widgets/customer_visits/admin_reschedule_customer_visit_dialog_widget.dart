import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';

class AdminRescheduleCustomerVisitDialogWidget extends StatefulWidget {
  const AdminRescheduleCustomerVisitDialogWidget({
    required this.visit,
    required this.onConfirm,
    super.key,
  });

  final CustomerVisitModel visit;
  final Future<void> Function({
    required String visitDate,
    String? visitTime,
    String? reason,
  })
  onConfirm;

  @override
  State<AdminRescheduleCustomerVisitDialogWidget> createState() =>
      _AdminRescheduleCustomerVisitDialogWidgetState();
}

class _AdminRescheduleCustomerVisitDialogWidgetState
    extends State<AdminRescheduleCustomerVisitDialogWidget> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  late final TextEditingController reasonController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    reasonController = TextEditingController();
    if (widget.visit.visitDate != null) {
      try {
        selectedDate = DateTime.parse(widget.visit.visitDate!);
      } catch (_) {}
    }
    selectedDate ??= DateTime.now();

    if (widget.visit.visitTime != null && widget.visit.visitTime!.isNotEmpty) {
      try {
        final parts = widget.visit.visitTime!.split(':');
        if (parts.length >= 2) {
          selectedTime = TimeOfDay(
            hour: int.parse(parts[0]),
            minute: int.parse(parts[1]),
          );
        }
      } catch (_) {}
    }
  }

  @override
  void dispose() {
    reasonController.dispose();
    super.dispose();
  }

  bool get isSelectedDateWeekend {
    if (selectedDate == null) return false;
    return selectedDate!.weekday == DateTime.friday ||
        selectedDate!.weekday == DateTime.saturday;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.brandPrimary,
              onPrimary: Colors.white,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.brandPrimary,
              onPrimary: Colors.white,
              surface: AppColors.cardBackground,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => selectedTime = picked);
    }
  }

  Future<void> _handleConfirm() async {
    if (selectedDate == null) {
      CustomSnackBar.showError(
        context,
        message: 'يرجى تحديد تاريخ الزيارة الجديد',
      );
      return;
    }

    if (isSelectedDateWeekend) {
      final shouldProceed = await showDialog<bool>(
        context: context,
        builder: (ctx) => CustomDialogWidget(
          icon: Icons.warning_amber_rounded,
          iconColor: AppColors.amberStatus,
          iconBackgroundColor: AppColors.softYellowBackground,
          title: 'تنبيه موعد الزيارة',
          message:
              'التاريخ المحدد يوافق عطلة أسبوعية (إجازة).\nهل ترغب في المتابعة وتأكيد تعديل موعد الزيارة في يوم الإجازة؟',
          confirmLabel: 'متابعة وتأكيد',
          cancelLabel: 'إلغاء / تغيير التاريخ',
          confirmButtonColor: AppColors.brandPrimary,
          onConfirm: () => Navigator.pop(ctx, true),
        ),
      );

      if (shouldProceed != true) return;
    }

    setState(() => isSubmitting = true);
    try {
      final dateStr = AppDateFormatter.formatDate(selectedDate!);
      final timeStr = selectedTime != null
          ? '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}'
          : null;
      final reason = reasonController.text.trim();

      await widget.onConfirm(
        visitDate: dateStr,
        visitTime: timeStr,
        reason: reason.isNotEmpty ? reason : null,
      );

      if (mounted) {
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateDisplay = selectedDate != null
        ? AppDateFormatter.formatDate(selectedDate!)
        : 'اختر التاريخ';
    final timeDisplay = selectedTime != null
        ? AppDateFormatter.formatReadableTime(
            '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
          )
        : 'اختر الوقت';

    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.edit_calendar_rounded,
                      color: AppColors.brandPrimary,
                      size: 24.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'تعديل موعد الزيارة',
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        if (widget.visit.customerName != null) ...[
                          SizedBox(height: 2.h),
                          Text(
                            widget.visit.customerName!,
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
              SizedBox(height: 18.h),

              // Date picker field
              Text(
                'التاريخ الجديد',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _pickDate,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: AppColors.brandPrimary,
                        size: 18.r,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        dateDisplay,
                        style: AppTextStyles.font14Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary,
                        size: 22.r,
                      ),
                    ],
                  ),
                ),
              ),

              if (isSelectedDateWeekend) ...[
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softYellowBackground,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.amberBorder),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: AppColors.amberStatus,
                        size: 14.r,
                      ),
                      SizedBox(width: 6.w),
                      Expanded(
                        child: Text(
                          'تنبيه: اليوم المحدد يوافق عطلة أسبوعية رسمية.',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.amberTextStrong,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              SizedBox(height: 14.h),

              // Time picker field
              Text(
                'الوقت الجديد (اختياري)',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _pickTime,
                borderRadius: BorderRadius.circular(10.r),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: AppColors.brandPrimary,
                        size: 18.r,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        timeDisplay,
                        style: AppTextStyles.font14Medium.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_drop_down_rounded,
                        color: AppColors.textSecondary,
                        size: 22.r,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 14.h),

              Text(
                'سبب التعديل / ملاحظات (اختياري)',
                style: AppTextStyles.font14Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: reasonController,
                hintText: 'اكتب سبب تعديل موعد الزيارة...',
                maxLines: 2,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(height: 24.h),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      onPressed: isSubmitting
                          ? null
                          : () => Navigator.of(context).pop(),
                      child: Text(
                        'common.cancel'.tr(context: context),
                        style: AppTextStyles.font14Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.brandPrimary,
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        elevation: 0,
                      ),
                      onPressed: isSubmitting ? null : _handleConfirm,
                      child: isSubmitting
                          ? SizedBox(
                              width: 18.r,
                              height: 18.r,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              'حفظ الموعد الجديد',
                              style: AppTextStyles.font14Bold.copyWith(
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
