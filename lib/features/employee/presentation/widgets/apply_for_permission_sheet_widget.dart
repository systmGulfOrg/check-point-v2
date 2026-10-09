import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/short_leave_request_body.dart';

class ApplyForPermissionSheetWidget extends StatefulWidget {
  const ApplyForPermissionSheetWidget({
    required this.onSubmit,
    this.isLoading = false,
    super.key,
  });

  final Future<void> Function(ShortLeaveRequestBody body) onSubmit;
  final bool isLoading;

  @override
  State<ApplyForPermissionSheetWidget> createState() =>
      _ApplyForPermissionSheetWidgetState();
}

class _ApplyForPermissionSheetWidgetState
    extends State<ApplyForPermissionSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _dateController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _selectedPermitType = 'LateArrival';
  bool _isSubmitting = false;

  final _permitTypes = const {
    'LateArrival': 'permits.type.lateArrival',
    'EarlyDeparture': 'permits.type.earlyDeparture',
    'TemporaryExit': 'permits.type.temporaryExit',
  };

  @override
  void initState() {
    super.initState();
    _dateController.text = AppDateFormatter.formatDate(
      _selectedDate,
      pattern: 'dd/MM/yyyy',
    );
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null && mounted) {
      setState(() {
        _selectedDate = date;
        _dateController.text = AppDateFormatter.formatDate(
          date,
          pattern: 'dd/MM/yyyy',
        );
      });
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );
    if (time != null && mounted) {
      setState(() {
        if (isStart) {
          _startTime = time;
        } else {
          _endTime = time;
        }
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  int? _durationMinutes() {
    if (_startTime == null || _endTime == null) return null;
    final start = _startTime!.hour * 60 + _startTime!.minute;
    final end = _endTime!.hour * 60 + _endTime!.minute;
    final duration = end - start;
    return duration > 0 ? duration : null;
  }

  String _formatDuration(int minutes) {
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    if (hours > 0 && remainingMinutes > 0) {
      return '$hours ${'common.hours'.tr(context: context)} $remainingMinutes ${'common.minutes'.tr(context: context)}';
    } else if (hours > 0) {
      return '$hours ${'common.hours'.tr(context: context)}';
    } else {
      return '$minutes ${'common.minutes'.tr(context: context)}';
    }
  }

  Future<void> _handleSubmit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    if (_startTime == null || _endTime == null) {
      CustomSnackBar.showError(
        context,
        message: 'permissions.request.timeRequired'.tr(context: context),
      );
      return;
    }

    final duration = _durationMinutes();
    if (duration == null || duration <= 0) {
      CustomSnackBar.showError(
        context,
        message: 'permissions.request.invalidTimeRange'.tr(context: context),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final body = ShortLeaveRequestBody(
      date: _selectedDate,
      startTime: _formatTime(_startTime),
      endTime: _formatTime(_endTime),
      permitType: _selectedPermitType,
      durationMinutes: duration,
      reason: _reasonController.text.trim(),
    );

    try {
      await widget.onSubmit(body);
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (_) {
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final duration = _durationMinutes();

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
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.brandSecondary.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.timer_outlined,
                          color: AppColors.brandSecondary,
                          size: 20.r,
                        ),
                      ),
                      wSpace(10),
                      Text(
                        'permissions.request.title'.tr(context: context),
                        style: AppTextStyles.font18Bold,
                      ),
                    ],
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

              // Permit Type
              Text(
                'leaves.request.type'.tr(context: context),
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
                    value: _selectedPermitType,
                    isExpanded: true,
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                    ),
                    items: _permitTypes.entries.map((e) {
                      return DropdownMenuItem<String>(
                        value: e.key,
                        child: Text(
                          e.value.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedPermitType = val);
                      }
                    },
                  ),
                ),
              ),
              hSpace(14),

              // Date Picker
              Text(
                'employee.leaves.startDate'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _dateController,
                hintText: 'employee.leaves.dateHint'.tr(context: context),
                readOnly: true,
                onTap: _selectDate,
                suffixIcon: Icon(
                  Icons.calendar_today_outlined,
                  size: 18.r,
                  color: AppColors.textSecondary,
                ),
                validator: AppValidators.required(
                  message: 'employee.leaves.dateRequired'.tr(context: context),
                  context: context,
                ),
              ),
              hSpace(14),

              // Time Range Pickers
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'permissions.request.fromTime'.tr(context: context),
                          style: AppTextStyles.font13SemiBold,
                        ),
                        hSpace(6),
                        InkWell(
                          onTap: () => _selectTime(true),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _startTime != null
                                      ? _startTime!.format(context)
                                      : '--:--',
                                  style: AppTextStyles.font14Regular.copyWith(
                                    color: _startTime != null
                                        ? AppColors.textPrimary
                                        : AppColors.placeholder,
                                  ),
                                ),
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 18.r,
                                  color: AppColors.brandPrimary,
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
                          'permissions.request.toTime'.tr(context: context),
                          style: AppTextStyles.font13SemiBold,
                        ),
                        hSpace(6),
                        InkWell(
                          onTap: () => _selectTime(false),
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 14.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _endTime != null
                                      ? _endTime!.format(context)
                                      : '--:--',
                                  style: AppTextStyles.font14Regular.copyWith(
                                    color: _endTime != null
                                        ? AppColors.textPrimary
                                        : AppColors.placeholder,
                                  ),
                                ),
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 18.r,
                                  color: AppColors.brandPrimary,
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

              // Duration Badge
              if (duration != null && duration > 0) ...[
                hSpace(10),
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
                        Icons.timelapse_rounded,
                        size: 15.r,
                        color: AppColors.brandPrimary,
                      ),
                      wSpace(6),
                      Text(
                        _formatDuration(duration),
                        style: AppTextStyles.font12Medium.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              hSpace(14),

              // Reason Field
              Text(
                'employee.leaves.reason'.tr(context: context),
                style: AppTextStyles.font13SemiBold,
              ),
              hSpace(6),
              CustomTextFormField(
                controller: _reasonController,
                hintText: 'employee.leaves.reasonHint'.tr(context: context),
                maxLines: 3,
                validator: AppValidators.required(
                  message: 'employee.leaves.reasonRequired'.tr(
                    context: context,
                  ),
                  context: context,
                ),
              ),
              hSpace(20),

              // Buttons
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
                      isLoading: _isSubmitting || widget.isLoading,
                      onTap: _handleSubmit,
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
