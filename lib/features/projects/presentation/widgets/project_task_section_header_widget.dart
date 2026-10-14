import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

/// Section title row with a leading icon and an optional trailing action,
/// used across the project task detail sheet.
class ProjectTaskSectionHeaderWidget extends StatelessWidget {
  const ProjectTaskSectionHeaderWidget({
    required this.title,
    required this.icon,
    this.action,
    super.key,
  });

  final String title;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, size: 20.r, color: AppColors.brandPrimary),
      SizedBox(width: 8.w),
      Text(title, style: AppTextStyles.font16Bold),
      const Spacer(),
      ?action,
    ],
  );
}
