import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class ProjectTaskDetailSectionHeaderWidget extends StatelessWidget {
  const ProjectTaskDetailSectionHeaderWidget({
    required this.title,
    required this.icon,
    this.action,
    super.key,
  });

  final String title;
  final IconData icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20.r, color: AppColors.brandPrimary),
        SizedBox(width: 8.w),
        Text(title, style: AppTextStyles.font16Bold),
        const Spacer(),
        ?action,
      ],
    );
  }
}
