import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';

class LanguageSelectionSheetWidget extends StatelessWidget {
  const LanguageSelectionSheetWidget({super.key});

  static const _options = <({String label, String sublabel, Locale locale})>[
    (
      label: 'English',
      sublabel: 'English',
      locale: Locale('en'),
    ),
    (
      label: 'العربية',
      sublabel: 'الفصحى',
      locale: Locale('ar'),
    ),
    (
      label: 'العامية المصرية',
      sublabel: 'المصرية',
      locale: Locale('ar', 'EG'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Language / اختر اللغة',
                style: AppTextStyles.font18Bold,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.textSecondary,
                  size: 22.r,
                ),
              ),
            ],
          ),
          hSpace(16),
          for (final option in _options) ...[
            _LanguageOptionTile(
              label: option.label,
              sublabel: option.sublabel,
              isSelected: currentLocale == option.locale ||
                  (currentLocale.languageCode == option.locale.languageCode &&
                      currentLocale.countryCode == option.locale.countryCode),
              onTap: () {
                context.setLocale(option.locale);
                Navigator.pop(context);
              },
            ),
            hSpace(10),
          ],
        ],
      ),
    );
  }
}

class _LanguageOptionTile extends StatelessWidget {
  const _LanguageOptionTile({
    required this.label,
    required this.sublabel,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String sublabel;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.softBrandBackground
              : AppColors.pageBackground,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.brandPrimary : AppColors.border,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font14SemiBold.copyWith(
                    color: isSelected
                        ? AppColors.brandPrimary
                        : AppColors.textPrimary,
                  ),
                ),
                hSpace(2),
                Text(
                  sublabel,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.brandPrimary,
                size: 22.r,
              ),
          ],
        ),
      ),
    );
  }
}
