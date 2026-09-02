import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class AdminWizardStepperWidget extends StatelessWidget {
  const AdminWizardStepperWidget({required this.currentStep, super.key});

  final int currentStep;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      for (var index = 0; index < 4; index++) ...[
        Expanded(
          child: Column(
            children: [
              Container(
                width: 30.r,
                height: 30.r,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: index <= currentStep
                      ? AppColors.brandPrimary
                      : AppColors.fieldBackground,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: index <= currentStep
                        ? AppColors.brandPrimary
                        : AppColors.border,
                  ),
                ),
                child: Text(
                  '${index + 1}',
                  style: AppTextStyles.font12Bold.copyWith(
                    color: index <= currentStep
                        ? AppColors.white
                        : AppColors.textSecondary,
                  ),
                ),
              ),
              hSpace(6),
              Text(
                [
                  'admin.employeeWizard.personal',
                  'admin.employeeWizard.work',
                  'admin.employeeWizard.attendance',
                  'admin.employeeWizard.review',
                ][index].tr(context: context),
                textAlign: TextAlign.center,
                style: AppTextStyles.font11Medium.copyWith(
                  color: index <= currentStep
                      ? AppColors.brandPrimary
                      : AppColors.placeholder,
                ),
              ),
            ],
          ),
        ),
        if (index < 3)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: Container(
                height: 2.h,
                color: index < currentStep
                    ? AppColors.brandPrimary
                    : AppColors.border,
              ),
            ),
          ),
      ],
    ],
  );
}
