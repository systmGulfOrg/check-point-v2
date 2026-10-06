import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class SupervisorAssigneeOptionWidget extends StatelessWidget {
  const SupervisorAssigneeOptionWidget({
    required this.initials,
    required this.nameKey,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String initials;
  final String nameKey;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.softBrandBackground
                : AppColors.pageBackground,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? AppColors.brandPrimary : AppColors.border,
            ),
          ),
          child: Row(
            children: [
              AppAvatarWidget(
                name: nameKey.tr(context: context),
                initials: initials,
                radius: 11.r,
                backgroundColor: AppColors.softGreenBackground,
                textColor: AppColors.success,
                enablePreview: true,
              ),
              vSpace(10),
              Expanded(
                child: Text(
                  nameKey.tr(context: context),
                  style: AppTextStyles.font12Medium,
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check_rounded,
                  color: AppColors.brandPrimary,
                  size: 16.r,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
