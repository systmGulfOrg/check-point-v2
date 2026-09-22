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
    selectedStatus = const [
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

  Future<void> _handleSubmit() async {
    final cubit = context.read<AdminAttendanceCubit>();
    final checkIn = checkInController.text.trim();
    final checkOut = checkOutController.text.trim();
    final reason = reasonController.text.trim();

    if (isDeleting) {
      Navigator.pop(context);
      await cubit.deleteAttendance(widget.attendanceId);
      return;
    }

    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('admin.attendance.reasonRequired'.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    Navigator.pop(context);
    await cubit.updateAttendance(
      id: widget.attendanceId,
      clockInTime: checkIn.isNotEmpty ? checkIn : null,
      clockOutTime: checkOut.isNotEmpty ? checkOut : null,
      status: selectedStatus,
      reason: reason,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20.w,
          18.h,
          20.w,
          16.h + MediaQuery.of(context).viewInsets.bottom,
        ),
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
                ),
              ] else ...[
                hSpace(14),
                Row(
                  children: [
                    Expanded(
                      child: AdminAttendanceTimeFieldWidget(
                        labelKey: 'admin.attendance.manual.checkIn',
                        controller: checkInController,
                      ),
                    ),
                    vSpace(12),
                    Expanded(
                      child: AdminAttendanceTimeFieldWidget(
                        labelKey: 'admin.attendance.manual.checkOut',
                        controller: checkOutController,
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
                  onChanged: (value) =>
                      setState(() => selectedStatus = value ?? selectedStatus),
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
                          : 'admin.attendance.saveChanges'.tr(context: context),
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
    );
  }
}
