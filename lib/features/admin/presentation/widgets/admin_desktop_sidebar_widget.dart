import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';

class AdminDesktopSidebarWidget extends StatelessWidget {
  const AdminDesktopSidebarWidget({
    required this.selectedIndex,
    required this.onTabSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  static const items = <(IconData, String)>[
    (Icons.home_outlined, 'admin.nav.home'),
    (Icons.person_outline_rounded, 'admin.nav.requests'),
    (Icons.group_outlined, 'admin.nav.employees'),
    (Icons.grid_view_rounded, 'admin.nav.manage'),
    (Icons.settings_outlined, 'admin.nav.settings'),
  ];

  @override
  Widget build(BuildContext context) => Container(
    width: 238.w,
    padding: EdgeInsetsDirectional.fromSTEB(18.w, 28.h, 18.w, 20.h),
    decoration: const BoxDecoration(
      color: AppColors.darkPageBackground,
      border: BorderDirectional(
        end: BorderSide(color: AppColors.darkCardBorder),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(AppAssets.logo, height: 48.h, fit: BoxFit.contain),
        hSpace(30),
        for (var index = 0; index < items.length; index++)
          Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: InkWell(
              onTap: () => onTabSelected(index),
              borderRadius: BorderRadius.circular(14.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
                decoration: BoxDecoration(
                  color: selectedIndex == index
                      ? AppColors.brandPrimary
                      : AppColors.transparent,
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(items[index].$1, color: AppColors.white, size: 20.r),
                    vSpace(12),
                    Text(
                      items[index].$2.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        const Spacer(),
        Image.asset(
          AppAssets.logo,
          height: 24.h,
          alignment: AlignmentDirectional.centerStart,
        ),
        hSpace(8),
        Text(
          'admin.desktop.poweredBy'.tr(context: context),
          style: AppTextStyles.font11Medium.copyWith(
            color: AppColors.darkTextMuted,
          ),
        ),
      ],
    ),
  );
}
