import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ApplyForLeaveSheetWidget extends StatefulWidget {
  const ApplyForLeaveSheetWidget({required this.onSubmit, super.key});

  final void Function({
    required String leaveType,
    required String startDate,
    required String endDate,
    String? reason,
  })
  onSubmit;

  @override
  State<ApplyForLeaveSheetWidget> createState() =>
      _ApplyForLeaveSheetWidgetState();
}

class _ApplyForLeaveSheetWidgetState extends State<ApplyForLeaveSheetWidget> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _reasonController = TextEditingController();

  String _selectedLeaveType = 'Annual Leave';
  final _leaveTypes = ['Annual Leave', 'Sick Leave', 'Casual Leave'];

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

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
                  value: _selectedLeaveType,
                  isExpanded: true,
                  icon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.textSecondary,
                  ),
                  items: _leaveTypes.map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(
                        type,
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) {
                      setState(() => _selectedLeaveType = val);
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
                        hintText: 'dd/mm/yyyy',
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
                        hintText: 'dd/mm/yyyy',
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
                      widget.onSubmit(
                        leaveType: _selectedLeaveType,
                        startDate: _startDateController.text.isNotEmpty
                            ? _startDateController.text
                            : '2026-09-10',
                        endDate: _endDateController.text.isNotEmpty
                            ? _endDateController.text
                            : '2026-09-12',
                        reason: _reasonController.text.isNotEmpty
                            ? _reasonController.text
                            : null,
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
    );
  }
}
