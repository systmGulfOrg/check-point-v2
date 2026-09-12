import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeAttendanceLocationTypeSelectorWidget extends StatelessWidget {
  const EmployeeAttendanceLocationTypeSelectorWidget({
    required this.selectedType,
    required this.onTypeChanged,
    super.key,
  });

  final String selectedType;
  final ValueChanged<String> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    const options = [
      ('Branch', 'attendance.branch'),
      ('Customer', 'attendance.customer'),
      ('Site', 'attendance.site'),
    ];

    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          for (final option in options)
            Expanded(
              child: Semantics(
                button: true,
                selected: selectedType == option.$1,
                label: option.$2.tr(),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.r),
                  onTap: () => onTypeChanged(option.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      color: selectedType == option.$1
                          ? AppColors.selectedBackground
                          : AppColors.transparent,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: selectedType == option.$1
                          ? const [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 4,
                                offset: Offset(0, 1),
                              ),
                            ]
                          : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (selectedType == option.$1) ...[
                          Icon(
                            Icons.check_rounded,
                            size: 16.r,
                            color: AppColors.brandPrimaryDark,
                          ),
                          wSpace(4),
                        ],
                        Text(
                          option.$2.tr(),
                          style: AppTextStyles.font12SemiBold.copyWith(
                            color: selectedType == option.$1
                                ? AppColors.textPrimary
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
