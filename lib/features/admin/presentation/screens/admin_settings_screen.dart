import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/language_selection_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_profile_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/change_password_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/edit_profile_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/user_permissions_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_settings_section_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_settings_sign_out_button_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_settings_tile_widget.dart';

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
            const AuthProfileCardWidget(),
            hSpace(20),
            AdminSettingsSectionCardWidget(
              sectionTitleKey: 'admin.settings.sectionAccount',
              tiles: [
                AdminSettingsTileWidget(
                  icon: Icons.person_outline_rounded,
                  titleKey: 'admin.settings.profileInfo',
                  valueKey: 'admin.settings.userName',
                  onTap: () => showEditProfileSheet(context),
                ),
                AdminSettingsTileWidget(
                  icon: Icons.key_outlined,
                  titleKey: 'admin.settings.changePassword',
                  valueKey: '••••••••',
                  onTap: () => showChangePasswordSheet(context),
                ),
                AdminSettingsTileWidget(
                  icon: Icons.notifications_none_rounded,
                  titleKey: 'admin.settings.notifications',
                  valueKey: 'admin.settings.enabled',
                ),
                BlocBuilder<AuthProfileCubit, AuthProfileState>(
                  builder: (context, state) {
                    final (role, roles) = switch (state) {
                      AuthProfileSuccess(:final role, :final roles) => (
                        role,
                        roles,
                      ),
                      _ => ('', const <String>[]),
                    };
                    if (roles.length <= 1) return const SizedBox.shrink();
                    return AdminSettingsTileWidget(
                      icon: Icons.swap_horiz_rounded,
                      titleKey: 'auth.role.switchRole',
                      valueKey: role,
                      onTap: () => RoleSwitchDialogWidget.show(
                        context,
                        currentRole: role,
                        availableRoles: roles,
                      ),
                    );
                  },
                ),
              ],
            ),
            hSpace(20),
            AdminSettingsSectionCardWidget(
              sectionTitleKey: 'admin.settings.sectionSubscription',
              tiles: [
                AdminSettingsTileWidget(
                  icon: Icons.workspace_premium_outlined,
                  titleKey: 'admin.settings.subscriptionPlan',
                  valueKey: 'admin.settings.manage',
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.adminSubscription),
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
                AdminSettingsTileWidget(
                  icon: Icons.shield_outlined,
                  titleKey: 'admin.settings.permissions',
                  valueKey: 'admin.settings.roleBased',
                  onTap: () => showUserPermissionsSheet(context),
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
