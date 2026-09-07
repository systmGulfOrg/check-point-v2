import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/language_selection_sheet_widget.dart';
import '../widgets/admin_settings_profile_card_widget.dart';
import '../widgets/admin_settings_section_card_widget.dart';
import '../widgets/admin_settings_sign_out_button_widget.dart';
import '../widgets/admin_settings_tile_widget.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

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

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'admin.settings.title'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Image.asset(AppAssets.logo, height: 32.h, fit: BoxFit.contain),
              ],
            ),
            hSpace(20),
            const AdminSettingsProfileCardWidget(),
            hSpace(20),
            AdminSettingsSectionCardWidget(
              sectionTitleKey: 'admin.settings.sectionAccount',
              tiles: const [
                AdminSettingsTileWidget(
                  icon: Icons.person_outline_rounded,
                  titleKey: 'admin.settings.profileInfo',
                  valueKey: 'admin.settings.userName',
                ),
                AdminSettingsTileWidget(
                  icon: Icons.key_outlined,
                  titleKey: 'admin.settings.changePassword',
                  valueKey: '••••••••',
                ),
                AdminSettingsTileWidget(
                  icon: Icons.notifications_none_rounded,
                  titleKey: 'admin.settings.notifications',
                  valueKey: 'admin.settings.enabled',
                ),
              ],
            ),
            hSpace(20),
            AdminSettingsSectionCardWidget(
              sectionTitleKey: 'admin.settings.sectionSystem',
              tiles: [
                AdminSettingsTileWidget(
                  icon: Icons.language_rounded,
                  titleKey: 'admin.settings.language',
                  valueKey: currentLanguageLabel,
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.transparent,
                      builder: (_) => const LanguageSelectionSheetWidget(),
                    );
                  },
                ),
                const AdminSettingsTileWidget(
                  icon: Icons.shield_outlined,
                  titleKey: 'admin.settings.permissions',
                  valueKey: 'admin.settings.roleBased',
                ),
              ],
            ),
            hSpace(24),
            const AdminSettingsSignOutButtonWidget(),
            hSpace(20),
            Center(
              child: Text(
                'admin.settings.footer'.tr(context: context),
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.placeholder,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
