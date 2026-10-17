import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';

/// The small grab bar shown at the top of a modal bottom sheet.
///
/// Extracted because the same 40x4 rounded bar was duplicated across 19 sheet
/// widgets. Use this instead of rebuilding it per sheet.
class AppSheetHandleWidget extends StatelessWidget {
  const AppSheetHandleWidget({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: AppColors.border,
        borderRadius: BorderRadius.circular(2.r),
      ),
    ),
  );
}
