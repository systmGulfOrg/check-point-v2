import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'admin_attendance_record_data.dart';
import 'admin_attendance_time_field_widget.dart';

enum AdminAttendanceAction { edit, delete }

class AdminAttendanceActionSheetWidget extends StatefulWidget {
  const AdminAttendanceActionSheetWidget({
    required this.record,
    required this.attendanceId,
    required this.action,
    super.key,
  });

  final AdminAttendanceRecordData record;
  final int attendanceId;
  final AdminAttendanceAction action;

  @override
  State<AdminAttendanceActionSheetWidget> createState() =>
      _AdminAttendanceActionSheetWidgetState();
}

class _AdminAttendanceActionSheetWidgetState
    extends State<AdminAttendanceActionSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;

  late final TextEditingController checkInController;
  late final TextEditingController checkOutController;
  late final TextEditingController reasonController;
  late String selectedStatus;

  bool get isDeleting => widget.action == AdminAttendanceAction.delete;

  @override
  void initState() {
    super.initState();
    final initialCheckIn =
        widget.record.checkIn != '--:--' && widget.record.checkIn.isNotEmpty
        ? widget.record.checkIn
        : '09:00';
    final initialCheckOut =
        widget.record.checkOut != '--:--' && widget.record.checkOut.isNotEmpty
        ? widget.record.checkOut
        : '';
    checkInController = TextEditingController(text: initialCheckIn);
    checkOutController = TextEditingController(text: initialCheckOut);
    reasonController = TextEditingController();
    final statusSuffix = widget.record.statusKey.split('.').last;
    selectedStatus =
        const [
          'onTime',
          'late',
          'absent',
          'excused',
          'manual',
          'earlyCheckout',
          'onLeave',
        ].contains(statusSuffix)
        ? statusSuffix
        : 'onTime';
  }

  @override
  void dispose() {
    checkInController.dispose();
    checkOutController.dispose();
    reasonController.dispose();
    super.dispose();
  }

  int? _parseTimeToMinutes(String? timeStr) {
    if (timeStr == null || timeStr.trim().isEmpty || timeStr == '--:--') {
      return null;
    }
    final clean = timeStr.trim().toUpperCase();
    final isPm = clean.contains('PM');
    final isAm = clean.contains('AM');
    final timePart = clean.replaceAll('AM', '').replaceAll('PM', '').trim();
    final parts = timePart.split(':');
    if (parts.length < 2) return null;
    var h = int.tryParse(parts[0]) ?? 0;
    final m = int.tryParse(parts[1]) ?? 0;
    if (isPm && h < 12) h += 12;
    if (isAm && h == 12) h = 0;
    return h * 60 + m;
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) {
      setState(() => _autoValidateMode = AutovalidateMode.onUserInteraction);
      return;
    }

    final cubit = context.read<AdminAttendanceCubit>();
    final checkIn = checkInController.text.trim();
    final checkOut = checkOutController.text.trim();
    final reason = reasonController.text.trim();

    if (isDeleting) {
      Navigator.pop(context);
      await cubit.deleteAttendance(widget.attendanceId);
      return;
    }

    Navigator.pop(context);
    await cubit.updateAttendance(
      id: widget.attendanceId,
      clockInTime: checkIn.isNotEmpty && checkIn != '--:--' ? checkIn : null,
      clockOutTime: checkOut.isNotEmpty && checkOut != '--:--'
          ? checkOut
          : null,
      status: selectedStatus,
      reason: reason,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            18.h,
            20.w,
            16.h + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: _formKey,
            autovalidateMode: _autoValidateMode,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (isDeleting
                                ? 'admin.attendance.deleteTitle'
                                : 'admin.attendance.editTitle')
                            .tr(context: context),
                        style: AppTextStyles.font18Bold,
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close_rounded, size: 20.r),
                      ),
                    ],
                  ),
                  const Divider(color: AppColors.border),
                  if (isDeleting) ...[
                    hSpace(16),
                    Text(
                      'admin.attendance.deleteDescription'.tr(
                        context: context,
                        args: [widget.record.name, widget.record.date],
                      ),
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    hSpace(14),
                    Text(
                      'admin.attendance.deleteWarning'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    hSpace(16),
                    Text(
                      'admin.attendance.reasonRequired'.tr(context: context),
                      style: AppTextStyles.font12Medium,
                    ),
                    hSpace(8),
                    CustomTextFormField(
                      controller: reasonController,
                      hintText: 'admin.attendance.deleteReasonHint'.tr(
                        context: context,
                      ),
                      maxLines: 3,
                      validator: AppValidators.required(
                        message: 'admin.attendance.deleteReasonValidation'.tr(
                          context: context,
                        ),
                        context: context,
                      ),
                    ),
                  ] else ...[
                    hSpace(14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AdminAttendanceTimeFieldWidget(
                            labelKey: 'admin.attendance.manual.checkIn',
                            controller: checkInController,
                            validator: (value) {
                              if (selectedStatus != 'absent' &&
                                  selectedStatus != 'onLeave') {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    value.trim() == '--:--') {
                                  return 'admin.attendance.checkInRequired'.tr(
                                    context: context,
                                  );
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                        vSpace(12),
                        Expanded(
                          child: AdminAttendanceTimeFieldWidget(
                            labelKey: 'admin.attendance.manual.checkOut',
                            controller: checkOutController,
                            validator: (value) {
                              if (value != null &&
                                  value.trim().isNotEmpty &&
                                  value.trim() != '--:--') {
                                final inMinutes = _parseTimeToMinutes(
                                  checkInController.text,
                                );
                                final outMinutes = _parseTimeToMinutes(value);
                                if (inMinutes != null &&
                                    outMinutes != null &&
                                    outMinutes < inMinutes) {
                                  return 'admin.attendance.checkOutAfterCheckIn'
                                      .tr(context: context);
                                }
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    hSpace(16),
                    Text(
                      'admin.attendance.statusLabel'.tr(context: context),
                      style: AppTextStyles.font12Medium,
                    ),
                    hSpace(8),
                    DropdownButtonFormField<String>(
                      initialValue: selectedStatus,
                      decoration: const InputDecoration(),
                      items: [
                        for (final status in const [
                          'onTime',
                          'late',
                          'absent',
                          'excused',
                          'manual',
                          'earlyCheckout',
                          'onLeave',
                        ])
                          DropdownMenuItem(
                            value: status,
                            child: Text(
                              'admin.attendance.status.$status'.tr(
                                context: context,
                              ),
                            ),
                          ),
                      ],
                      validator: AppValidators.required(
                        message: 'admin.attendance.statusRequired'.tr(
                          context: context,
                        ),
                        context: context,
                      ),
                      onChanged: (value) => setState(
                        () => selectedStatus = value ?? selectedStatus,
                      ),
                    ),
                    hSpace(16),
                    Text(
                      'admin.attendance.reasonForEdit'.tr(context: context),
                      style: AppTextStyles.font12Medium,
                    ),
                    hSpace(8),
                    CustomTextFormField(
                      controller: reasonController,
                      hintText: 'admin.attendance.editReasonHint'.tr(
                        context: context,
                      ),
                      maxLines: 3,
                      validator: AppValidators.required(
                        message: 'admin.attendance.editReasonValidation'.tr(
                          context: context,
                        ),
                        context: context,
                      ),
                    ),
                  ],
                  hSpace(16),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'admin.attendance.cancel'.tr(context: context),
                          onTap: () => Navigator.pop(context),
                          backgroundColor: AppColors.pageBackground,
                          textColor: AppColors.textPrimary,
                        ),
                      ),
                      vSpace(12),
                      Expanded(
                        child: CustomButton(
                          text: isDeleting
                              ? 'admin.attendance.delete'.tr(context: context)
                              : 'admin.attendance.saveChanges'.tr(
                                  context: context,
                                ),
                          onTap: _handleSubmit,
                          backgroundColor: isDeleting
                              ? AppColors.error
                              : AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
