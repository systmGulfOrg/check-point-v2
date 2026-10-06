import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';

class ApplyForLeaveSheetWidget extends StatefulWidget {
  const ApplyForLeaveSheetWidget({
    required this.onSubmit,
    this.leaveTypes = const [],
    super.key,
  });

  final List<LeaveTypeModel> leaveTypes;
  final FutureOr<void> Function({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
    String? attachmentUrl,
  })
  onSubmit;

  @override
  State<ApplyForLeaveSheetWidget> createState() =>
      _ApplyForLeaveSheetWidgetState();
}

class _ApplyForLeaveSheetWidgetState extends State<ApplyForLeaveSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _reasonController = TextEditingController();
  final _remarkController = TextEditingController();

  bool _isLoading = false;
  DateTime? _startDate;
  DateTime? _endDate;
  late String _selectedLeaveRequestType;
  String? _attachedFileName;
  String? _attachedFileBase64;
  final _defaultLeaveRequestTypes = const [
    'LeaveRequest',
    'RequestClaim',
    'LeaveSchedule',
    'LeavePlanner',
    'Icident',
    'DocumentWorkflow',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.leaveTypes.isNotEmpty) {
      _selectedLeaveRequestType =
          widget.leaveTypes.first.id?.toString() ??
          widget.leaveTypes.first.typeName ??
          '1';
    } else {
      _selectedLeaveRequestType = 'LeaveRequest';
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  Future<void> _pickAttachment() async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
        withData: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        String? base64Data;
        if (file.bytes != null) {
          final ext = file.extension?.toLowerCase() ?? 'pdf';
          final mimeType = ext == 'png'
              ? 'image/png'
              : (ext == 'jpg' || ext == 'jpeg')
                  ? 'image/jpeg'
                  : ext == 'pdf'
                      ? 'application/pdf'
                      : 'application/octet-stream';
          base64Data = 'data:$mimeType;base64,${base64Encode(file.bytes!)}';
        } else if (file.path != null) {
          final bytes = await File(file.path!).readAsBytes();
          final ext = file.extension?.toLowerCase() ?? 'pdf';
          final mimeType = ext == 'png'
              ? 'image/png'
              : (ext == 'jpg' || ext == 'jpeg')
                  ? 'image/jpeg'
                  : ext == 'pdf'
                      ? 'application/pdf'
                      : 'application/octet-stream';
          base64Data = 'data:$mimeType;base64,${base64Encode(bytes)}';
        }

        setState(() {
          _attachedFileName = file.name;
          _attachedFileBase64 = base64Data;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'leaves.request.attachmentSelected'.tr(context: context),
              ),
              backgroundColor: AppColors.success,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking file: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  Future<void> _selectDate({required bool isStartDate}) async {
    final selected = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? _startDate ?? DateTime.now()),
    );
    if (selected == null || !mounted) return;
    final formatted = AppDateFormatter.formatDate(
      selected,
      pattern: 'dd/MM/yyyy',
    );
    setState(() {
      if (isStartDate) {
        _startDate = selected;
        _startDateController.text = formatted;
      } else {
        _endDate = selected;
        _endDateController.text = formatted;
      }
    });
  }

  String _typeLabel(String type) => switch (type) {
    'LeaveRequest' => 'employee.leaves.types.leaveRequest'.tr(context: context),
    'RequestClaim' => 'employee.leaves.types.requestClaim'.tr(context: context),
    'LeaveSchedule' => 'employee.leaves.types.leaveSchedule'.tr(
      context: context,
    ),
    'LeavePlanner' => 'employee.leaves.types.leavePlanner'.tr(context: context),
    'Icident' => 'employee.leaves.types.incident'.tr(context: context),
    'DocumentWorkflow' => 'employee.leaves.types.documentWorkflow'.tr(
      context: context,
    ),
    _ => type,
  };

  @override
  Widget build(BuildContext context) {
    final selectedType = widget.leaveTypes
        .where(
          (t) =>
              t.id?.toString() == _selectedLeaveRequestType ||
              t.typeName == _selectedLeaveRequestType,
        )
        .firstOrNull;

    return Container(
      padding: EdgeInsets.only(
        top: 20.h,
        left: 20.w,
        right: 20.w,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'employee.leaves.applyTitle'.tr(context: context),
                      style: AppTextStyles.font18Bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColors.textSecondary,
                      size: 22.r,
                    ),
                  ),
                ],
              ),
              hSpace(16),
              Text(
                'employee.leaves.leaveType'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.pageBackground,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedLeaveRequestType,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                    items: widget.leaveTypes.isNotEmpty
                        ? widget.leaveTypes.map((type) {
                            final val =
                                type.id?.toString() ?? type.typeName ?? '';
                            final name = type.typeName ?? val;
                            return DropdownMenuItem<String>(
                              value: val,
                              child: Text(
                                name,
                                style: AppTextStyles.font14Regular.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            );
                          }).toList()
                        : _defaultLeaveRequestTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(
                                _typeLabel(type),
                                style: AppTextStyles.font14Regular.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            );
                          }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedLeaveRequestType = val);
                      }
                    },
                  ),
                ),
              ),
              if (selectedType != null) ...[
                hSpace(10),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: (selectedType.isPaid ?? true)
                            ? AppColors.success.withValues(alpha: 0.1)
                            : AppColors.warning.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: (selectedType.isPaid ?? true)
                              ? AppColors.success.withValues(alpha: 0.3)
                              : AppColors.warning.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            (selectedType.isPaid ?? true)
                                ? Icons.check_circle_outline_rounded
                                : Icons.info_outline_rounded,
                            size: 15.r,
                            color: (selectedType.isPaid ?? true)
                                ? AppColors.success
                                : AppColors.warning,
                          ),
                          wSpace(6),
                          Text(
                            (selectedType.isPaid ?? true)
                                ? 'leaves.request.paid'.tr(context: context)
                                : 'leaves.request.unpaid'.tr(context: context),
                            style: AppTextStyles.font12Medium.copyWith(
                              color: (selectedType.isPaid ?? true)
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (selectedType.maxDaysPerYear != null)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.brandPrimary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColors.brandPrimary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.event_note_outlined,
                              size: 15.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(6),
                            Text(
                              'leaves.request.maxDays'.tr(
                                context: context,
                                args: [selectedType.maxDaysPerYear.toString()],
                              ),
                              style: AppTextStyles.font12Medium.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
              if (selectedType != null &&
                  (selectedType.requiresAttachment ?? false)) ...[
                hSpace(14),
                Row(
                  children: [
                    Text(
                      'leaves.request.attachmentRequired'.tr(context: context),
                      style: AppTextStyles.font13SemiBold,
                    ),
                    wSpace(4),
                    Text(
                      '*',
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                if (_attachedFileName == null)
                  InkWell(
                    onTap: _pickAttachment,
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 18.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.pageBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.brandPrimary.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 24.r,
                            color: AppColors.brandPrimary,
                          ),
                          wSpace(8),
                          Text(
                            'leaves.request.uploadAttachment'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font14Medium.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 12.w,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.success.withValues(alpha: 0.5),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: BoxDecoration(
                            color: AppColors.brandPrimary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.insert_drive_file_outlined,
                            size: 18.r,
                            color: AppColors.brandPrimary,
                          ),
                        ),
                        wSpace(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _attachedFileName!,
                                style: AppTextStyles.font14Medium.copyWith(
                                  color: AppColors.textPrimary,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              hSpace(2),
                              Text(
                                'leaves.request.attachmentSelected'.tr(
                                  context: context,
                                ),
                                style: AppTextStyles.font11Regular.copyWith(
                                  color: AppColors.success,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () =>
                              setState(() => _attachedFileName = null),
                          icon: const Icon(
                            Icons.delete_outline_rounded,
                            color: AppColors.error,
                          ),
                          tooltip: 'leaves.request.removeAttachment'.tr(
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
              hSpace(14),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'employee.leaves.startDate'.tr(context: context),
                          style: AppTextStyles.font13SemiBold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          controller: _startDateController,
                          hintText: 'employee.leaves.dateHint'.tr(
                            context: context,
                          ),
                          readOnly: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'employee.leaves.dateRequired'.tr(
                                context: context,
                              );
                            }
                            if (_startDate != null &&
                                _endDate != null &&
                                _endDate!.isBefore(_startDate!)) {
                              return 'employee.leaves.endDateInvalid'.tr(
                                context: context,
                              );
                            }
                            return null;
                          },
                          onTap: () => _selectDate(isStartDate: true),
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 18.r,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'employee.leaves.endDate'.tr(context: context),
                          style: AppTextStyles.font13SemiBold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          controller: _endDateController,
                          hintText: 'employee.leaves.dateHint'.tr(
                            context: context,
                          ),
                          readOnly: true,
                          validator: (value) => value == null || value.isEmpty
                              ? 'employee.leaves.dateRequired'.tr(
                                  context: context,
                                )
                              : null,
                          onTap: () => _selectDate(isStartDate: false),
                          suffixIcon: Icon(
                            Icons.calendar_today_outlined,
                            size: 18.r,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              hSpace(14),
              Text(
                'employee.leaves.reason'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _reasonController,
                hintText: 'employee.leaves.reasonHint'.tr(context: context),
                maxLines: 3,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'employee.leaves.reasonRequired'.tr(context: context)
                    : null,
              ),
              hSpace(14),
              Text(
                'employee.leaves.remark'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _remarkController,
                hintText: 'employee.leaves.remarkHint'.tr(context: context),
                maxLines: 3,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'employee.leaves.remarkRequired'.tr(context: context)
                    : null,
              ),
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14.h),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        'employee.leaves.cancel'.tr(context: context),
                        style: AppTextStyles.font16Bold.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'employee.leaves.submit'.tr(context: context),
                      isLoading: _isLoading,
                      onTap: () async {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        if ((selectedType?.requiresAttachment ?? false) &&
                            _attachedFileName == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'leaves.request.attachmentMissing'.tr(
                                  context: context,
                                ),
                              ),
                              backgroundColor: AppColors.error,
                            ),
                          );
                          return;
                        }

                        final navigator = Navigator.of(context);
                        setState(() => _isLoading = true);
                        try {
                          await widget.onSubmit(
                            leaveRequestType: _selectedLeaveRequestType,
                            startDate: AppDateFormatter.formatYearMonthDay(
                              _startDate!,
                            ),
                            endDate: AppDateFormatter.formatYearMonthDay(
                              _endDate!,
                            ),
                            reason: _reasonController.text.trim(),
                            remark: _remarkController.text.trim(),
                            attachmentUrl: _attachedFileBase64,
                          );
                          if (mounted) {
                            navigator.pop();
                          }
                        } catch (_) {
                          if (mounted) {
                            setState(() => _isLoading = false);
                          }
                        }
                      },
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
