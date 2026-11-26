import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPermitRulesNumberFieldWidget extends StatelessWidget {
  const AdminPermitRulesNumberFieldWidget({
    required this.controller,
    required this.label,
    required this.suffix,
    required this.enabled,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final String suffix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.fieldBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.font12Medium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
          wSpace(12),
          SizedBox(
            width: 70.w,
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: AppTextStyles.font13SemiBold,
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: const BorderSide(color: AppColors.border),
                ),
                suffixText: suffix,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
