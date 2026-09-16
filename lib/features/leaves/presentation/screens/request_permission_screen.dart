import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../data/models/short_leave_request_body.dart';
import '../../data/repos/leaves_repo_impl.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_date_formatter.dart';

class RequestPermissionScreen extends StatefulWidget {
  const RequestPermissionScreen({super.key});

  @override
  State<RequestPermissionScreen> createState() =>
      _RequestPermissionScreenState();
}

class _RequestPermissionScreenState extends State<RequestPermissionScreen> {
  final _reasonController = TextEditingController();
  final _repo = sl<LeavesRepoImpl>();
  final _formKey = GlobalKey<FormState>();

  bool _isSubmitting = false;
  DateTime? _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  String _selectedPermitType = 'LateArrival';

  final _permitTypes = {
    'LateArrival': 'permits.type.lateArrival',
    'EarlyDeparture': 'permits.type.earlyDeparture',
    'TemporaryExit': 'permits.type.temporaryExit',
  };

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  Future<void> _selectTime(bool isStart) async {
    final time = await showTimePicker(
      context: context,
      initialTime: isStart
          ? (_startTime ?? TimeOfDay.now())
          : (_endTime ?? TimeOfDay.now()),
    );
    if (time != null) {
      setState(() {
        if (isStart)
          _startTime = time;
        else
          _endTime = time;
      });
    }
  }

  String _formatTime(TimeOfDay? time) {
    if (time == null) return '';
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedDate == null || _startTime == null || _endTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('employee.leaves.dateRequired'.tr())),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final body = ShortLeaveRequestBody(
      date: _selectedDate!,
      startTime: _formatTime(_startTime),
      endTime: _formatTime(_endTime),
      permitType: _selectedPermitType,
      reason: _reasonController.text.trim(),
    );

    try {
      await _repo.api.submitShortLeaveRequest(body);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('permissions.request.success'.tr()),
            backgroundColor: AppColors.success,
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'permissions.request.title'.tr(),
          style: AppTextStyles.font16Bold,
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'leaves.request.type'.tr(),
                style: AppTextStyles.font14Medium,
              ),
              SizedBox(height: 8.h),
              DropdownButtonFormField<String>(
                value: _selectedPermitType,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: AppColors.border),
                  ),
                  filled: true,
                  fillColor: AppColors.cardBackground,
                ),
                items: _permitTypes.entries
                    .map(
                      (e) => DropdownMenuItem(
                        value: e.key,
                        child: Text(e.value.tr()),
                      ),
                    )
                    .toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedPermitType = val);
                },
              ),

              SizedBox(height: 16.h),
              Text(
                'employee.leaves.startDate'.tr(),
                style: AppTextStyles.font14Medium,
              ),
              SizedBox(height: 8.h),
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedDate != null
                            ? AppDateFormatter.formatDate(_selectedDate!)
                            : 'employee.leaves.dateHint'.tr(),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: _selectedDate != null
                              ? AppColors.textPrimary
                              : AppColors.placeholder,
                        ),
                      ),
                      const Icon(
                        Icons.calendar_today,
                        color: AppColors.brandPrimary,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From Time', style: AppTextStyles.font14Medium),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () => _selectTime(true),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
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
                                const Icon(
                                  Icons.access_time,
                                  color: AppColors.brandPrimary,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('To Time', style: AppTextStyles.font14Medium),
                        SizedBox(height: 8.h),
                        InkWell(
                          onTap: () => _selectTime(false),
                          child: Container(
                            padding: EdgeInsets.all(16.w),
                            decoration: BoxDecoration(
                              color: AppColors.cardBackground,
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
                                const Icon(
                                  Icons.access_time,
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

              SizedBox(height: 16.h),
              Text(
                'leaves.request.reason'.tr(),
                style: AppTextStyles.font14Medium,
              ),
              SizedBox(height: 8.h),
              CustomTextFormField(
                controller: _reasonController,
                hintText: 'employee.leaves.reasonHint'.tr(),
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.trim().isEmpty) {
                    return 'employee.leaves.reasonRequired'.tr();
                  }
                  return null;
                },
              ),

              SizedBox(height: 32.h),
              CustomButton(
                onTap: _isSubmitting ? () {} : _submit,
                text: 'leaves.request.submit'.tr(),
                isLoading: _isSubmitting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
