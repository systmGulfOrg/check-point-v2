import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/leave_request_body.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';

class RequestLeaveScreen extends StatefulWidget {
  const RequestLeaveScreen({super.key});

  @override
  State<RequestLeaveScreen> createState() => _RequestLeaveScreenState();
}

class _RequestLeaveScreenState extends State<RequestLeaveScreen> {
  late final TextEditingController _reasonController;
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedLeaveTypeId;
  String? _attachedFileName;
  String? _attachedFileBase64;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
    context.read<LeavesCubit>().loadLeavesData();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _pickStartDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? now,
      firstDate: now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(picked)) {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _pickEndDate() async {
    final now = DateTime.now();
    final initial = _endDate ?? _startDate ?? now;
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: _startDate ?? now.subtract(const Duration(days: 30)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() => _endDate = picked);
    }
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
          final isImage = ext == 'png' || ext == 'jpg' || ext == 'jpeg';
          final mimeType = ext == 'png'
              ? 'image/png'
              : (ext == 'jpg' || ext == 'jpeg')
              ? 'image/jpeg'
              : ext == 'pdf'
              ? 'application/pdf'
              : 'application/octet-stream';
          if (isImage) {
            base64Data = await AppImageCompressor.compressAndEncodeBase64(
              file.bytes!,
              maxDimension: 1024,
              mimeType: mimeType,
            );
          } else {
            base64Data = 'data:$mimeType;base64,${base64Encode(file.bytes!)}';
          }
        } else if (file.path != null) {
          final bytes = await File(file.path!).readAsBytes();
          final ext = file.extension?.toLowerCase() ?? 'pdf';
          final isImage = ext == 'png' || ext == 'jpg' || ext == 'jpeg';
          final mimeType = ext == 'png'
              ? 'image/png'
              : (ext == 'jpg' || ext == 'jpeg')
              ? 'image/jpeg'
              : ext == 'pdf'
              ? 'application/pdf'
              : 'application/octet-stream';
          if (isImage) {
            base64Data = await AppImageCompressor.compressAndEncodeBase64(
              bytes,
              maxDimension: 1024,
              mimeType: mimeType,
            );
          } else {
            base64Data = 'data:$mimeType;base64,${base64Encode(bytes)}';
          }
        }

        setState(() {
          _attachedFileName = file.name;
          _attachedFileBase64 = base64Data;
        });

        if (mounted) {
          CustomSnackBar.showSuccess(
            context,
            message: 'leaves.request.attachmentSelected'.tr(context: context),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, message: 'Error picking file: $e');
      }
    }
  }

  void _submit(List<dynamic> types) {
    if (_selectedLeaveTypeId == null) {
      CustomSnackBar.showError(
        context,
        message: 'employee.leaves.leaveType'.tr(context: context),
      );
      return;
    }
    if (_startDate == null || _endDate == null) {
      CustomSnackBar.showError(
        context,
        message: 'employee.leaves.dateRequired'.tr(context: context),
      );
      return;
    }

    final selectedType = types
        .where(
          (t) =>
              t.typeName == _selectedLeaveTypeId ||
              t.id == _selectedLeaveTypeId,
        )
        .firstOrNull;

    if (selectedType != null &&
        selectedType.requiresAttachment == true &&
        _attachedFileName == null) {
      CustomSnackBar.showError(
        context,
        message: 'leaves.request.attachmentMissing'.tr(context: context),
      );
      return;
    }

    context.read<LeavesCubit>().submitLeave(
      LeaveRequestBody(
        leaveTypeId: _selectedLeaveTypeId!,
        startDate: _startDate!,
        endDate: _endDate!,
        reason: _reasonController.text.trim(),
        attachmentUrl: _attachedFileBase64,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'leaves.request.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: BlocConsumer<LeavesCubit, LeavesState>(
        listener: (context, state) {
          state.whenOrNull(
            submitSuccess: () {
              CustomSnackBar.showSuccess(
                context,
                message: 'leaves.request.success'.tr(context: context),
              );
              Navigator.pop(context);
            },
            error: (msg) {
              CustomSnackBar.showError(
                context,
                message: msg.tr(context: context),
              );
            },
          );
        },
        builder: (context, state) {
          final isSubmitting = state.maybeWhen(
            submitting: () => true,
            orElse: () => false,
          );

          final types = state.maybeWhen(
            success: (balances, types, requests) => types,
            orElse: () => context.read<LeavesCubit>().leaveTypes,
          );

          final selectedType = types
              .where(
                (t) =>
                    t.typeName == _selectedLeaveTypeId ||
                    t.id == _selectedLeaveTypeId,
              )
              .firstOrNull;

          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'leaves.request.type'.tr(context: context),
                  style: AppTextStyles.font13SemiBold,
                ),
                hSpace(6),
                DropdownButtonFormField<String>(
                  key: ValueKey('leave_type_${_selectedLeaveTypeId ?? 'none'}'),
                  initialValue: _selectedLeaveTypeId,
                  isExpanded: true,
                  hint: Text('employee.leaves.leaveType'.tr(context: context)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.fieldBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                  ),
                  items: types
                      .map<DropdownMenuItem<String>>(
                        (t) => DropdownMenuItem<String>(
                          value: t.typeName,
                          child: Text(t.typeName),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedLeaveTypeId = v),
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
                          color: selectedType.isPaid
                              ? AppColors.success.withValues(alpha: 0.1)
                              : AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: selectedType.isPaid
                                ? AppColors.success.withValues(alpha: 0.3)
                                : AppColors.warning.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              selectedType.isPaid
                                  ? Icons.check_circle_outline_rounded
                                  : Icons.info_outline_rounded,
                              size: 15.r,
                              color: selectedType.isPaid
                                  ? AppColors.success
                                  : AppColors.warning,
                            ),
                            wSpace(6),
                            Text(
                              selectedType.isPaid
                                  ? 'leaves.request.paid'.tr(context: context)
                                  : 'leaves.request.unpaid'.tr(
                                      context: context,
                                    ),
                              style: AppTextStyles.font12Medium.copyWith(
                                color: selectedType.isPaid
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
                            color: AppColors.brandPrimary.withValues(
                              alpha: 0.08,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: AppColors.brandPrimary.withValues(
                                alpha: 0.2,
                              ),
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
                                  args: [
                                    selectedType.maxDaysPerYear.toString(),
                                  ],
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
                    selectedType.requiresAttachment) ...[
                  hSpace(16),
                  Row(
                    children: [
                      Text(
                        'leaves.request.attachmentRequired'.tr(
                          context: context,
                        ),
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
                          vertical: 20.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.fieldBackground,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.brandPrimary.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.cloud_upload_outlined,
                              size: 32.r,
                              color: AppColors.brandPrimary,
                            ),
                            hSpace(8),
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
                        vertical: 12.h,
                        horizontal: 14.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fieldBackground,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.5),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.r),
                            decoration: BoxDecoration(
                              color: AppColors.brandPrimary.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.insert_drive_file_outlined,
                              size: 20.r,
                              color: AppColors.brandPrimary,
                            ),
                          ),
                          wSpace(12),
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
                hSpace(16),
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
                          InkWell(
                            onTap: _pickStartDate,
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.fieldBackground,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 18.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                  wSpace(8),
                                  Expanded(
                                    child: Text(
                                      _startDate != null
                                          ? AppDateFormatter.formatDate(
                                              _startDate!,
                                            )
                                          : 'employee.leaves.dateHint'.tr(
                                              context: context,
                                            ),
                                      style: AppTextStyles.font13Regular
                                          .copyWith(
                                            color: _startDate != null
                                                ? AppColors.textPrimary
                                                : AppColors.placeholder,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
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
                          InkWell(
                            onTap: _pickEndDate,
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 14.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.fieldBackground,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today_rounded,
                                    size: 18.r,
                                    color: AppColors.brandPrimary,
                                  ),
                                  wSpace(8),
                                  Expanded(
                                    child: Text(
                                      _endDate != null
                                          ? AppDateFormatter.formatDate(
                                              _endDate!,
                                            )
                                          : 'employee.leaves.dateHint'.tr(
                                              context: context,
                                            ),
                                      style: AppTextStyles.font13Regular
                                          .copyWith(
                                            color: _endDate != null
                                                ? AppColors.textPrimary
                                                : AppColors.placeholder,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                hSpace(16),
                Text(
                  'leaves.request.reason'.tr(context: context),
                  style: AppTextStyles.font13SemiBold,
                ),
                hSpace(6),
                CustomTextFormField(
                  controller: _reasonController,
                  hintText: 'employee.leaves.reasonHint'.tr(context: context),
                  maxLines: 3,
                ),
                hSpace(24),
                CustomButton(
                  text: isSubmitting
                      ? '...'
                      : 'leaves.request.submit'.tr(context: context),
                  onTap: isSubmitting ? () {} : () => _submit(types),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
