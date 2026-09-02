import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';

class RoleSwitcherItemWidget extends StatelessWidget {
  const RoleSwitcherItemWidget({
    required this.roleKey,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String roleKey;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.selectedBackground
            : AppColors.transparent,
        borderRadius: BorderRadius.circular(7.r),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(7.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(vertical: 10.h),
          child: Text(
            roleKey.tr(context: context),
            textAlign: TextAlign.center,
            style: AppTextStyles.font13SemiBold.copyWith(
              color: isSelected ? AppColors.brandPrimary : AppColors.brandInk,
            ),
          ),
        ),
      ),
    );
  }
}
