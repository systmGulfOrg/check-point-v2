import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'language_selection_sheet_widget.dart';

class LanguageSwitcherWidget extends StatelessWidget {
  const LanguageSwitcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    final label = switch ((locale.languageCode, locale.countryCode)) {
      ('en', _) => '🇬🇧 EN',
      ('ar', 'EG') => '🇪🇬 العامية المصرية',
      _ => '🇸🇦 العربية',
    };

    return OutlinedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.transparent,
          builder: (_) => const LanguageSelectionSheetWidget(),
        );
      },
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        side: const BorderSide(color: AppColors.border),
        foregroundColor: AppColors.textPrimary,
        backgroundColor: AppColors.white,
        textStyle: AppTextStyles.font12Bold,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Text(label),
    );
  }
}
