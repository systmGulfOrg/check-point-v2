import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class EmployeeAssigneeAvatarWidget extends StatelessWidget {
  const EmployeeAssigneeAvatarWidget({
    required this.assignees,
    super.key,
  });

  final List<String> assignees;

  @override
  Widget build(BuildContext context) {
    if (assignees.isEmpty) return const SizedBox.shrink();

    final avatarSize = 28.r;
    final step = 20.w;
    final totalWidth = avatarSize + (assignees.length - 1) * step;

    return SizedBox(
      width: totalWidth,
      height: avatarSize,
      child: Stack(
        children: [
          for (int i = 0; i < assignees.length; i++)
            Positioned(
              left: Directionality.of(context) == TextDirection.ltr
                  ? i * step
                  : null,
              right: Directionality.of(context) == TextDirection.rtl
                  ? i * step
                  : null,
              child: Container(
                width: avatarSize,
                height: avatarSize,
                decoration: BoxDecoration(
                  color: AppColors.softGreenBackground,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    assignees[i],
                    style: AppTextStyles.font11Medium.copyWith(
                      color: AppColors.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
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
