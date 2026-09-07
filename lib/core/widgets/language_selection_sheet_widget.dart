import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../app/app_spaces.dart';
import '../styles/app_colors.dart';
import '../styles/app_text_styles.dart';
import 'language_option_tile_widget.dart';

class LanguageSelectionSheetWidget extends StatelessWidget {
  const LanguageSelectionSheetWidget({super.key});

  static const _options = <({String label, String sublabel, Locale locale})>[
    (label: 'English', sublabel: 'English', locale: Locale('en')),
    (label: 'العربية', sublabel: 'الفصحى', locale: Locale('ar')),
    (label: 'العامية المصرية', sublabel: 'المصرية', locale: Locale('ar', 'EG')),
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
            LanguageOptionTileWidget(
              label: option.label,
              sublabel: option.sublabel,
              isSelected:
                  currentLocale == option.locale ||
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
