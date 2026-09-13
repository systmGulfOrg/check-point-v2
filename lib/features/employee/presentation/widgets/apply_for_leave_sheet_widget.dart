import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ApplyForLeaveSheetWidget extends StatefulWidget {
  const ApplyForLeaveSheetWidget({required this.onSubmit, super.key});

  final void Function({
    required String startDate,
    required String endDate,
    required String reason,
    required String remark,
    required String leaveRequestType,
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

  DateTime? _startDate;
  DateTime? _endDate;
  String _selectedLeaveRequestType = 'LeaveRequest';
  final _leaveRequestTypes = const [
    'LeaveRequest',
    'RequestClaim',
    'LeaveSchedule',
    'LeavePlanner',
    'Icident',
    'DocumentWorkflow',
  ];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    _remarkController.dispose();
    super.dispose();
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
    final formatted = DateFormat('dd/MM/yyyy').format(selected);
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
                  Text(
                    'employee.leaves.applyTitle'.tr(context: context),
                    style: AppTextStyles.font18Bold,
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
                    items: _leaveRequestTypes.map((type) {
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
                      onTap: () {
                        if (!(_formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        widget.onSubmit(
                          leaveRequestType: _selectedLeaveRequestType,
                          startDate: DateFormat(
                            'yyyy-MM-dd',
                          ).format(_startDate!),
                          endDate: DateFormat('yyyy-MM-dd').format(_endDate!),
                          reason: _reasonController.text.trim(),
                          remark: _remarkController.text.trim(),
                        );
                        Navigator.pop(context);
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
