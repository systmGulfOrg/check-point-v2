import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/language_selection_sheet_widget.dart';

class SupervisorProfileOptionsWidget extends StatelessWidget {
  const SupervisorProfileOptionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguageLabel = switch ((
      context.locale.languageCode,
      context.locale.countryCode,
    )) {
      ('en', _) => 'English',
      ('ar', 'EG') => 'العامية المصرية',
      _ => 'العربية',
    };

    final options = <(IconData, String, String?, VoidCallback?)>[
      (
        Icons.person_outline_rounded,
        'supervisor.profile.profileInformation',
        null,
        null,
      ),
      (Icons.key_outlined, 'supervisor.profile.changePassword', null, null),
      (
        Icons.notifications_none_rounded,
        'supervisor.profile.notifications',
        null,
        null,
      ),
      (
        Icons.language_rounded,
        'admin.settings.language',
        currentLanguageLabel,
        () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            backgroundColor: AppColors.transparent,
            builder: (_) => const LanguageSelectionSheetWidget(),
          );
        },
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < options.length; i++) ...[
            if (i > 0) const Divider(color: AppColors.border, height: 1),
            InkWell(
              onTap: options[i].$4,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Row(
                  children: [
                    Icon(
                      options[i].$1,
                      color: AppColors.textSecondary,
                      size: 20.r,
                    ),
                    wSpace(12),
                    Expanded(
                      child: Text(
                        options[i].$2.tr(context: context),
                        style: AppTextStyles.font14SemiBold,
                      ),
                    ),
                    if (options[i].$3 != null) ...[
                      Text(
                        options[i].$3!,
                        style: AppTextStyles.font13Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      wSpace(6),
                    ],
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.placeholder,
                      size: 20.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
