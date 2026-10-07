import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'admin_customer_visit_doc_viewer_dialog_widget.dart';

class AdminCreateCustomerVisitSheetWidget extends StatefulWidget {
  const AdminCreateCustomerVisitSheetWidget({
    required this.onSave,
    this.initialCustomer,
    this.availableCustomers = const [],
    super.key,
  });

  final CustomerModel? initialCustomer;
  final List<CustomerModel> availableCustomers;
  final Future<bool> Function(CustomerVisitModel visit) onSave;

  @override
  State<AdminCreateCustomerVisitSheetWidget> createState() =>
      _AdminCreateCustomerVisitSheetWidgetState();
}

class _AdminCreateCustomerVisitSheetWidgetState
    extends State<AdminCreateCustomerVisitSheetWidget> {
  CustomerModel? selectedCustomer;
  late final TextEditingController titleController;
  late final TextEditingController dateController;
  late final TextEditingController timeController;
  late final TextEditingController attendeeInputController;
  late final TextEditingController notesController;

  final List<String> attendees = [];
  List<EmployeeModel> availableEmployees = [];
  bool isLoadingEmployees = false;
  String? attachedDocName;
  String? attachedDocUrl;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    selectedCustomer = widget.initialCustomer;
    titleController = TextEditingController();
    dateController = TextEditingController(
      text: AppDateFormatter.formatYearMonthDay(DateTime.now()),
    );
    timeController = TextEditingController(text: '10:00 ص');
    attendeeInputController = TextEditingController();
    notesController = TextEditingController();

    // Default companions for great UX
    attendees.add('أنا (المشرف / المسؤول)');
    _loadSystemEmployees();
  }

  Future<void> _loadSystemEmployees() async {
    setState(() => isLoadingEmployees = true);
    final result = await sl<AdminEmployeeRepo>().getEmployees(
      page: 1,
      pageSize: 50,
    );
    if (!mounted) return;
    switch (result) {
      case Success(:final data):
        setState(() {
          availableEmployees = data;
          isLoadingEmployees = false;
        });
      case Failure():
        setState(() => isLoadingEmployees = false);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    dateController.dispose();
    timeController.dispose();
    attendeeInputController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void _addEmployeeAttendee(String name) {
    if (!attendees.contains(name)) {
      setState(() {
        attendees.add(name);
      });
    }
  }

  void _addAttendee() {
    final text = attendeeInputController.text.trim();
    if (text.isNotEmpty && !attendees.contains(text)) {
      setState(() {
        attendees.add(text);
        attendeeInputController.clear();
      });
    }
  }

  void _removeAttendee(String attendee) {
    setState(() {
      attendees.remove(attendee);
    });
  }

  void _attachMockDocument() {
    setState(() {
      attachedDocName =
          'خطة_الزيارة_${DateTime.now().millisecondsSinceEpoch % 1000}.pdf';
      attachedDocUrl = 'https://example.com/docs/visit_plan.pdf';
    });
    CustomSnackBar.showSuccess(
      context,
      message: 'admin.visits.docAttached'.tr(),
    );
  }

  Future<void> _submit() async {
    final title = titleController.text.trim();
    if (title.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'يرجى كتابة هدف أو عنوان الزيارة'.tr(),
      );
      return;
    }

    final cust = selectedCustomer ?? widget.initialCustomer;
    final customerId = cust?.id ?? '1';
    final customerName = cust?.name ?? 'العميل';

    setState(() => isSubmitting = true);

    final visit = CustomerVisitModel(
      customerId: customerId,
      customerName: customerName,
      title: title,
      visitDate: dateController.text.trim(),
      visitTime: timeController.text.trim(),
      attendees: List.unmodifiable(attendees),
      documentName: attachedDocName,
      documentUrl: attachedDocUrl,
      notes: notesController.text.trim().isNotEmpty
          ? notesController.text.trim()
          : null,
      status: 'scheduled',
    );

    final success = await widget.onSave(visit);
    if (!mounted) return;
    setState(() => isSubmitting = false);

    if (success) {
      Navigator.pop(context);
      CustomSnackBar.showSuccess(
        context,
        message: 'admin.visits.visitSuccess'.tr(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          18.h,
          20.w,
          MediaQuery.of(context).viewInsets.bottom + 16.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
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
                          Icons.calendar_month_rounded,
                          color: AppColors.brandPrimary,
                          size: 22.r,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'admin.visits.planVisit'.tr(context: context),
                        style: AppTextStyles.font18Bold,
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
              SizedBox(height: 14.h),

              // Customer Selection if multiple
              if (widget.initialCustomer == null &&
                  widget.availableCustomers.isNotEmpty) ...[
                Text(
                  'admin.visits.customer'.tr(context: context),
                  style: AppTextStyles.font12Medium,
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  decoration: BoxDecoration(
                    color: AppColors.fieldBackground,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<CustomerModel>(
                      value:
                          selectedCustomer ?? widget.availableCustomers.first,
                      isExpanded: true,
                      items: widget.availableCustomers.map((c) {
                        return DropdownMenuItem<CustomerModel>(
                          value: c,
                          child: Text(
                            c.name ?? '',
                            style: AppTextStyles.font14Regular,
                          ),
                        );
                      }).toList(),
                      onChanged: (c) => setState(() => selectedCustomer = c),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ] else if (widget.initialCustomer != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.brandPrimary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.business_rounded,
                        color: AppColors.brandPrimary,
                        size: 20.r,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.initialCustomer!.name ?? '',
                              style: AppTextStyles.font14Bold.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                            if (widget.initialCustomer!.location != null)
                              Text(
                                widget.initialCustomer!.location!,
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
              ],

              // Purpose / Title
              Text(
                'admin.visits.purpose'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: titleController,
                hintText: 'admin.visits.purposeHint'.tr(context: context),
              ),
              SizedBox(height: 16.h),

              // Date & Time Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.visits.date'.tr(context: context),
                          style: AppTextStyles.font12Medium,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: dateController,
                          hintText: 'admin.visits.date'.tr(context: context),
                          readOnly: true,
                          prefixIcon: Icon(
                            Icons.calendar_today_rounded,
                            size: 18.r,
                          ),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 30),
                              ),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now(),
                            );
                            if (date != null && mounted) {
                              dateController.text =
                                  AppDateFormatter.formatYearMonthDay(date);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'admin.visits.time'.tr(context: context),
                          style: AppTextStyles.font12Medium,
                        ),
                        SizedBox(height: 8.h),
                        CustomTextFormField(
                          controller: timeController,
                          hintText: 'admin.visits.time'.tr(context: context),
                          readOnly: true,
                          prefixIcon: Icon(
                            Icons.access_time_rounded,
                            size: 18.r,
                          ),
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: const TimeOfDay(hour: 10, minute: 0),
                            );
                            if (time != null && mounted) {
                              final raw24 =
                                  '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                              timeController.text =
                                  AppDateFormatter.formatTime12HourArabic(
                                    raw24,
                                  );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),

              // Attendees / Companions ("مين معايا")
              Text(
                'admin.visits.attendees'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                decoration: BoxDecoration(
                  color: AppColors.fieldBackground,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    icon: isLoadingEmployees
                        ? SizedBox(
                            width: 16.r,
                            height: 16.r,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 20.r,
                            color: AppColors.textSecondary,
                          ),
                    hint: Row(
                      children: [
                        Icon(
                          Icons.person_add_alt_1_rounded,
                          size: 18.r,
                          color: AppColors.brandPrimary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            isLoadingEmployees
                                ? 'جاري تحميل موظفي السيستم...'
                                : 'اختر موظف من السيستم لإضافته...',
                            style: AppTextStyles.font13Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: 'أنا (المشرف / المسؤول)',
                        child: Text(
                          'أنا (المشرف / المسؤول)',
                          style: AppTextStyles.font13Medium,
                        ),
                      ),
                      ...availableEmployees.map((emp) {
                        final label =
                            '${emp.name ?? "موظف"}${emp.position != null && emp.position!.isNotEmpty ? " • ${emp.position}" : emp.departmentName != null && emp.departmentName!.isNotEmpty ? " • ${emp.departmentName}" : ""}';
                        return DropdownMenuItem<String>(
                          value: label,
                          child: Text(
                            label,
                            style: AppTextStyles.font13Regular,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: (val) {
                      if (val != null) {
                        _addEmployeeAttendee(val);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      controller: attendeeInputController,
                      hintText: 'أو أدخل اسم مرافق خارجي...',
                    ),
                  ),
                  SizedBox(width: 8.w),
                  IconButton.filled(
                    onPressed: _addAttendee,
                    icon: Icon(Icons.add_rounded, size: 22.r),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.brandPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 280),
                curve: Curves.easeInOutCubic,
                child: attendees.isNotEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Wrap(
                          spacing: 6.w,
                          runSpacing: 6.h,
                          children: attendees.map((att) {
                            return Chip(
                              backgroundColor: AppColors.selectedBackground,
                              side: const BorderSide(color: AppColors.border),
                              label: Text(
                                att,
                                style: AppTextStyles.font12Medium,
                              ),
                              deleteIcon: Icon(Icons.close, size: 14.r),
                              onDeleted: () => _removeAttendee(att),
                            );
                          }).toList(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              SizedBox(height: 16.h),

              // Document attachment ("الـ document اللي هرفعها")
              Text(
                'admin.visits.document'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              SizedBox(height: 8.h),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) => FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(scale: animation, child: child),
                ),
                child: attachedDocName != null
                    ? InkWell(
                        key: const ValueKey('doc_attached'),
                        onTap: () {
                          showDialog<void>(
                            context: context,
                            builder: (_) =>
                                AdminCustomerVisitDocViewerDialogWidget(
                                  fileName: attachedDocName!,
                                  fileUrl: attachedDocUrl,
                                ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 10.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: AppColors.brandPrimary),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.picture_as_pdf_rounded,
                                color: AppColors.error,
                                size: 24.r,
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Directionality(
                                  textDirection: ui.TextDirection.ltr,
                                  child: Text(
                                    attachedDocName!,
                                    style: AppTextStyles.font13Medium,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () => setState(() {
                                  attachedDocName = null;
                                  attachedDocUrl = null;
                                }),
                                icon: Icon(
                                  Icons.delete_outline_rounded,
                                  color: AppColors.error,
                                  size: 20.r,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : InkWell(
                        key: const ValueKey('doc_upload_button'),
                        onTap: _attachMockDocument,
                        borderRadius: BorderRadius.circular(14.r),
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          decoration: BoxDecoration(
                            color: AppColors.fieldBackground,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: AppColors.border,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                color: AppColors.brandPrimary,
                                size: 20.r,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'admin.visits.uploadDoc'.tr(context: context),
                                style: AppTextStyles.font13SemiBold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
              SizedBox(height: 16.h),

              // Notes & Objectives
              Text(
                'admin.visits.notes'.tr(context: context),
                style: AppTextStyles.font12Medium,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: notesController,
                hintText: 'admin.visits.notesHint'.tr(context: context),
                maxLines: 3,
              ),
              SizedBox(height: 24.h),

              // Submit Button
              CustomButton(
                text: 'admin.visits.planVisit'.tr(context: context),
                isLoading: isSubmitting,
                onTap: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
