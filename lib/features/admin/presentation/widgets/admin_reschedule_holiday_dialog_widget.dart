import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_departments_state.dart';
import 'package:check_point_v2/features/leaves/data/models/official_holiday_model.dart';

class AdminRescheduleHolidayDialogWidget extends StatefulWidget {
  const AdminRescheduleHolidayDialogWidget({
    required this.holiday,
    required this.onSave,
    super.key,
  });

  final OfficialHolidayModel holiday;
  final Future<void> Function({
    required DateTime newDate,
    required String? note,
    required bool reset,
    required bool isCancelled,
    required String? cancelReason,
    required List<String> excludedDepartmentIds,
    required List<String> excludedEmployeeIds,
  })
  onSave;

  @override
  State<AdminRescheduleHolidayDialogWidget> createState() =>
      _AdminRescheduleHolidayDialogWidgetState();
}

class _AdminRescheduleHolidayDialogWidgetState
    extends State<AdminRescheduleHolidayDialogWidget> {
  int activeTab = 0;
  late DateTime selectedDate;
  late final TextEditingController noteController;
  late final TextEditingController cancelReasonController;
  bool isCancelled = false;
  final Set<String> selectedExcludedDepartmentIds = {};
  final Set<String> selectedExcludedEmployeeIds = {};
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
    cancelReasonController = TextEditingController(
      text: widget.holiday.cancelReason ?? 'إلغاء الإجازة الرسمية لحاجة العمل',
    );
    isCancelled = widget.holiday.isCancelled ?? false;
    if (widget.holiday.excludedDepartmentIds != null) {
      selectedExcludedDepartmentIds.addAll(
        widget.holiday.excludedDepartmentIds!,
      );
    }
    if (widget.holiday.excludedEmployeeIds != null) {
      selectedExcludedEmployeeIds.addAll(widget.holiday.excludedEmployeeIds!);
    }

    if (isCancelled) {
      activeTab = 1;
    } else if (selectedExcludedDepartmentIds.isNotEmpty ||
        selectedExcludedEmployeeIds.isNotEmpty) {
      activeTab = 2;
    }
  }

  @override
  void dispose() {
    noteController.dispose();
    cancelReasonController.dispose();
    super.dispose();
  }

  void _shiftToThursday() {
    final weekday = selectedDate.weekday;
    final daysToAdd = (DateTime.thursday - weekday) % 7;
    setState(() {
      selectedDate = selectedDate.add(
        Duration(days: daysToAdd == 0 ? 7 : daysToAdd),
      );
    });
  }

  void _shiftToSunday() {
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
      newDate: selectedDate,
      note: noteController.text.trim().isNotEmpty
          ? noteController.text.trim()
          : null,
      reset: false,
      isCancelled: isCancelled,
      cancelReason: cancelReasonController.text.trim().isNotEmpty
          ? cancelReasonController.text.trim()
          : null,
      excludedDepartmentIds: selectedExcludedDepartmentIds.toList(),
      excludedEmployeeIds: selectedExcludedEmployeeIds.toList(),
    );
    if (mounted) {
      setState(() => isSubmitting = false);
      Navigator.pop(context);
    }
  }

  Future<void> _handleReset() async {
    final orig = widget.holiday.originalDate ?? widget.holiday.date;
    setState(() => isSubmitting = true);
    await widget.onSave(
      newDate: orig,
      note: null,
      reset: true,
      isCancelled: false,
      cancelReason: null,
      excludedDepartmentIds: const [],
      excludedEmployeeIds: const [],
    );
    if (mounted) {
      setState(() => isSubmitting = false);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final originalDate = widget.holiday.originalDate ?? widget.holiday.date;
    final hasChanges =
        (widget.holiday.isRescheduled ?? false) ||
        (widget.holiday.isCancelled ?? false) ||
        (widget.holiday.excludedDepartmentIds?.isNotEmpty ?? false) ||
        (widget.holiday.excludedEmployeeIds?.isNotEmpty ?? false);

    return Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 650.h),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18.r),
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
                          color: AppColors.softOrangeBackground,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          Icons.edit_calendar_rounded,
                          color: AppColors.brandPrimary,
                          size: 22.r,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'إدارة موعد وحالة الإجازة',
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
              SizedBox(height: 10.h),

              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.softOrangeLightBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.orangeBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.holiday.arabicName ?? widget.holiday.name,
                      style: AppTextStyles.font14Bold,
                    ),
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
                          'الموعد الرسمي الأساسي: ${DateFormat('EEEE، d MMMM yyyy', context.locale.languageCode).format(originalDate)}',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              Container(
                padding: EdgeInsets.all(3.r),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton(
                        index: 0,
                        title: 'ترحيل الموعد',
                        icon: Icons.calendar_month_outlined,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        index: 1,
                        title: 'إلغاء الإجازة',
                        icon: Icons.cancel_outlined,
                      ),
                    ),
                    Expanded(
                      child: _buildTabButton(
                        index: 2,
                        title: 'استثناءات',
                        icon: Icons.group_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              if (activeTab == 0) ...[
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
                      setState(() {
                        selectedDate = picked;
                        isCancelled = false;
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(12.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softOrangeLightBackground,
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
                            DateFormat(
                              'EEEE، d MMMM yyyy',
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
                SizedBox(height: 10.h),

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
                        onPressed: () {
                          _shiftToThursday();
                          setState(() => isCancelled = false);
                        },
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
                        onPressed: () {
                          _shiftToSunday();
                          setState(() => isCancelled = false);
                        },
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
                SizedBox(height: 14.h),

                Text('سبب أو بيان الترحيل', style: AppTextStyles.font12Medium),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  controller: noteController,
                  hintText: 'مثال: بقرار رسمي ترحيل الإجازة لنهاية الأسبوع',
                  maxLines: 2,
                ),
              ],

              if (activeTab == 1) ...[
                Container(
                  padding: EdgeInsets.all(14.r),
                  decoration: BoxDecoration(
                    color: isCancelled
                        ? AppColors.softRedBackground
                        : AppColors.pageBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: isCancelled ? AppColors.error : AppColors.border,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.block_flipped,
                        color: isCancelled
                            ? AppColors.error
                            : AppColors.placeholder,
                        size: 24.r,
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'إلغاء الإجازة بالكامل',
                              style: AppTextStyles.font14Bold.copyWith(
                                color: isCancelled
                                    ? AppColors.error
                                    : AppColors.brandInk,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'اعتبار هذا اليوم يوم عمل عادي لجميع الموظفين',
                              style: AppTextStyles.font11Regular.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Switch.adaptive(
                        value: isCancelled,
                        activeThumbColor: AppColors.error,
                        onChanged: (val) => setState(() => isCancelled = val),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 14.h),
                Text(
                  'سبب الإلغاء (بيان إداري)',
                  style: AppTextStyles.font12Medium,
                ),
                SizedBox(height: 6.h),
                CustomTextFormField(
                  controller: cancelReasonController,
                  hintText: 'مثال: استمرار العمل نظراً لضغط التشغيل والمشاريع',
                  maxLines: 2,
                ),
              ],

              if (activeTab == 2) ...[
                Text(
                  'تحديد من يستثنى من الإجازة (يكون لديهم عمل عادي)',
                  style: AppTextStyles.font12Bold,
                ),
                SizedBox(height: 10.h),

                Text(
                  'استثناء أقسام بالكامل:',
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
                SizedBox(height: 6.h),
                BlocBuilder<AdminDepartmentsCubit, AdminDepartmentsState>(
                  builder: (context, state) {
                    final departments = context
                        .read<AdminDepartmentsCubit>()
                        .departments;
                    if (departments.isEmpty) {
                      return Text(
                        'لا توجد أقسام مسجلة',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      );
                    }
                    return Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: departments.map((dept) {
                        final deptId = dept.id?.toString() ?? '';
                        final isSelected = selectedExcludedDepartmentIds
                            .contains(deptId);
                        return FilterChip(
                          label: Text(dept.departmentName ?? '-'),
                          selected: isSelected,
                          selectedColor: AppColors.softOrangeBackground,
                          checkmarkColor: AppColors.brandPrimary,
                          labelStyle: AppTextStyles.font12Medium.copyWith(
                            color: isSelected
                                ? AppColors.brandPrimary
                                : AppColors.brandInk,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedExcludedDepartmentIds.add(deptId);
                              } else {
                                selectedExcludedDepartmentIds.remove(deptId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
                SizedBox(height: 14.h),

                Text(
                  'استثناء موظفين محددين:',
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
                SizedBox(height: 6.h),
                BlocBuilder<AdminEmployeesCubit, AdminEmployeesState>(
                  builder: (context, state) {
                    final employees = context
                        .read<AdminEmployeesCubit>()
                        .employees;
                    final validEmployees = employees
                        .where(
                          (e) => e.id != null && (e.name?.isNotEmpty ?? false),
                        )
                        .take(20)
                        .toList();
                    if (validEmployees.isEmpty) {
                      return Text(
                        'لا يوجد موظفون متاحون',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      );
                    }
                    return Wrap(
                      spacing: 8.w,
                      runSpacing: 6.h,
                      children: validEmployees.map((emp) {
                        final empId = emp.id!;
                        final isSelected = selectedExcludedEmployeeIds.contains(
                          empId,
                        );
                        return FilterChip(
                          label: Text(emp.name ?? '-'),
                          selected: isSelected,
                          selectedColor: AppColors.softOrangeBackground,
                          checkmarkColor: AppColors.brandPrimary,
                          labelStyle: AppTextStyles.font12Medium.copyWith(
                            color: isSelected
                                ? AppColors.brandPrimary
                                : AppColors.brandInk,
                          ),
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                selectedExcludedEmployeeIds.add(empId);
                              } else {
                                selectedExcludedEmployeeIds.remove(empId);
                              }
                            });
                          },
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
              SizedBox(height: 20.h),

              Row(
                children: [
                  if (hasChanges) ...[
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
                          'إلغاء التعديل',
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
                      text: 'حفظ وتطبيق التغييرات',
                      isLoading: isSubmitting,
                      onTap: _handleSave,
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

  Widget _buildTabButton({
    required int index,
    required String title,
    required IconData icon,
  }) {
    final isSelected = activeTab == index;
    return InkWell(
      onTap: () => setState(() => activeTab = index),
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 15.r,
              color: isSelected
                  ? AppColors.brandPrimary
                  : AppColors.placeholder,
            ),
            SizedBox(width: 4.w),
            Text(
              title,
              style: AppTextStyles.font10Bold.copyWith(
                color: isSelected
                    ? AppColors.brandPrimary
                    : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
