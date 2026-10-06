import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';

class AdminRescheduleHolidayDialogWidget extends StatefulWidget {
  const AdminRescheduleHolidayDialogWidget({
    required this.holiday,
    required this.onSave,
    super.key,
  });

  final OfficialHolidayModel holiday;
  final Future<void> Function(DateTime newDate, String? note, bool reset)
  onSave;

  @override
  State<AdminRescheduleHolidayDialogWidget> createState() =>
      _AdminRescheduleHolidayDialogWidgetState();
}

class _AdminRescheduleHolidayDialogWidgetState
    extends State<AdminRescheduleHolidayDialogWidget> {
  late DateTime selectedDate;
  late final TextEditingController noteController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.holiday.date;
    noteController = TextEditingController(
      text:
          widget.holiday.rescheduledNote ??
          'بقرار رسمي ترحيل الإجازة لنهاية الأسبوع',
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  void _shiftToThursday() {
    // Shift to nearest Thursday of the same week
    final weekday =
        selectedDate.weekday; // Mon=1, Tue=2, Wed=3, Thu=4, Fri=5, Sat=6, Sun=7
    final daysToAdd = (DateTime.thursday - weekday) % 7;
    setState(() {
      selectedDate = selectedDate.add(
        Duration(days: daysToAdd == 0 ? 7 : daysToAdd),
      );
    });
  }

  void _shiftToSunday() {
    // Shift to nearest Sunday
    final weekday = selectedDate.weekday;
    final daysToAdd = (DateTime.sunday - weekday) % 7;
    setState(() {
      selectedDate = selectedDate.add(
        Duration(days: daysToAdd == 0 ? 7 : daysToAdd),
      );
    });
  }

  Future<void> _handleSave() async {
    setState(() => isSubmitting = true);
    await widget.onSave(
      selectedDate,
      noteController.text.trim().isNotEmpty ? noteController.text.trim() : null,
      false,
    );
    if (mounted) {
      setState(() => isSubmitting = false);
      Navigator.pop(context);
    }
  }

  Future<void> _handleReset() async {
    final orig = widget.holiday.originalDate ?? widget.holiday.date;
    setState(() => isSubmitting = true);
    await widget.onSave(orig, null, true);
    if (mounted) {
      setState(() => isSubmitting = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalDate = widget.holiday.originalDate ?? widget.holiday.date;
    final isAlreadyRescheduled = widget.holiday.isRescheduled ?? false;

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
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(
                        Icons.edit_calendar_rounded,
                        color: AppColors.brandPrimary,
                        size: 22.r,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Text('ترحيل موعد الإجازة', style: AppTextStyles.font16Bold),
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

            // Holiday Name card
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.holiday.name, style: AppTextStyles.font14Bold),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.event_outlined,
                        size: 14.r,
                        color: AppColors.placeholder,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'الموعد الرسمي الأساسي: ${DateFormat.yMMMMEEEEd(context.locale.languageCode).format(originalDate)}',
                        style: AppTextStyles.font11Medium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),

            // Date picker trigger for new date
            Text(
              'الموعد الجديد بعد الترحيل',
              style: AppTextStyles.font12Medium,
            ),
            SizedBox(height: 8.h),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2025),
                  lastDate: DateTime(2030),
                );
                if (picked != null && mounted) {
                  setState(() => selectedDate = picked);
                }
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.brandPrimary),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.brandPrimary,
                      size: 20.r,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        DateFormat.yMMMMEEEEd(
                          context.locale.languageCode,
                        ).format(selectedDate),
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: AppColors.brandPrimary,
                      size: 24.r,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12.h),

            // Quick Preset Chips
            Text(
              'ترحيل سريع إلى:',
              style: AppTextStyles.font11Medium.copyWith(
                color: AppColors.placeholder,
              ),
            ),
            SizedBox(height: 6.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shiftToThursday,
                    icon: Icon(Icons.fast_forward_rounded, size: 14.r),
                    label: Text(
                      'الخميس القادم',
                      style: AppTextStyles.font11Medium,
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _shiftToSunday,
                    icon: Icon(Icons.fast_forward_rounded, size: 14.r),
                    label: Text(
                      'الأحد القادم',
                      style: AppTextStyles.font11Medium,
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 6.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            // Decision note
            Text('سبب أو بيان الترحيل', style: AppTextStyles.font12Medium),
            SizedBox(height: 8.h),
            CustomTextFormField(
              controller: noteController,
              hintText:
                  'مثال: قرار مجلس الوزراء بترحيل إجازة 6 أكتوبر لنهاية الأسبوع',
              maxLines: 2,
            ),
            SizedBox(height: 20.h),

            // Actions
            Row(
              children: [
                if (isAlreadyRescheduled) ...[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isSubmitting ? null : _handleReset,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                      ),
                      child: Text(
                        'إلغاء الترحيل',
                        style: AppTextStyles.font13SemiBold.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
                Expanded(
                  flex: 2,
                  child: CustomButton(
                    text: 'حفظ وتطبيق الترحيل',
                    isLoading: isSubmitting,
                    onTap: _handleSave,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
