import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_help_support_sheet_widget.dart';

class SupportContactButtonWidget extends StatelessWidget {
  const SupportContactButtonWidget({
    this.onPanStart,
    this.onPanEnd,
    this.onPanUpdate,
    super.key,
  });

  final VoidCallback? onPanStart;
  final VoidCallback? onPanEnd;
  final ValueChanged<Offset>? onPanUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: onPanStart == null ? null : (_) => onPanStart!(),
      onPanUpdate: onPanUpdate == null
          ? null
          : (details) => onPanUpdate!(details.delta),
      onPanEnd: onPanEnd == null ? null : (_) => onPanEnd!(),
      child: Material(
        color: AppColors.softBrandBackground,
        borderRadius: BorderRadius.circular(14.r),
        child: InkWell(
          onTap: () => showAuthHelpSupportSheet(context),
          borderRadius: BorderRadius.circular(14.r),
          child: SizedBox(
            width: 48.r,
            height: 48.r,
            child: Icon(
              Icons.error_outline_rounded,
              color: AppColors.brandPrimary,
              size: 24.r,
            ),
          ),
        ),
      ),
    );
  }
}
