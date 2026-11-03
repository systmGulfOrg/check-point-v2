import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorWorkerRollCallBottomBarWidget extends StatelessWidget {
  const SupervisorWorkerRollCallBottomBarWidget({
    required this.selectedCount,
    required this.clockInTime,
    required this.clockOutTime,
    required this.isSubmitting,
    required this.onPickClockIn,
    required this.onPickClockOut,
    required this.onSubmit,
    super.key,
  });

  final int selectedCount;
  final TimeOfDay clockInTime;
  final TimeOfDay? clockOutTime;
  final bool isSubmitting;
  final VoidCallback onPickClockIn;
  final VoidCallback onPickClockOut;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onPickClockIn,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'contractorWorker.rollCall.checkInTime'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            clockInTime.format(context),
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                vSpace(8),
                Expanded(
                  child: InkWell(
                    onTap: onPickClockOut,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.border),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'contractorWorker.rollCall.checkOutTime'.tr(
                              context: context,
                            ),
                            style: AppTextStyles.font11Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            clockOutTime?.format(context) ?? '--:--',
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            hSpace(12),
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: ElevatedButton(
                onPressed: selectedCount > 0 && !isSubmitting ? onSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'contractorWorker.rollCall.recordAction'.tr(
                          context: context,
                          args: [selectedCount.toString()],
                        ),
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
