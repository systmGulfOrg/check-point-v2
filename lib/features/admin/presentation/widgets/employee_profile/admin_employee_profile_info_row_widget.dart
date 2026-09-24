import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminEmployeeProfileInfoRowWidget extends StatelessWidget {
  const AdminEmployeeProfileInfoRowWidget({
    required this.label,
    required this.value,
    this.icon,
    this.isCopyable = false,
    this.valueColor,
    this.trailingWidget,
    super.key,
  });

  final String label;
  final String value;
  final IconData? icon;
  final bool isCopyable;
  final Color? valueColor;
  final Widget? trailingWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Container(
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: AppColors.pageBackground,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(icon, size: 16.r, color: AppColors.brandPrimary),
            ),
            wSpace(10),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font11Medium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(2),
                Text(
                  value.isEmpty ? '-' : value,
                  style: AppTextStyles.font13Medium.copyWith(
                    color: valueColor ?? AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          if (trailingWidget != null) ...[
            wSpace(8),
            trailingWidget!,
          ] else if (isCopyable && value.isNotEmpty && value != '-') ...[
            wSpace(6),
            InkWell(
              onTap: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$label copied'),
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              borderRadius: BorderRadius.circular(6.r),
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: Icon(
                  Icons.copy_rounded,
                  size: 16.r,
                  color: AppColors.placeholder,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
