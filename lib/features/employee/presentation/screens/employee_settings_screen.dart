import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/language_selection_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/auth_profile_card_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/change_password_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/edit_profile_sheet_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/role_switch_dialog_widget.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/user_permissions_sheet_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_settings_section_card_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_settings_sign_out_button_widget.dart';
import 'package:check_point_v2/features/employee/presentation/widgets/employee_settings_tile_widget.dart';

class EmployeeSettingsScreen extends StatelessWidget {
  const EmployeeSettingsScreen({super.key});

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

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'employee.settings.title'.tr(context: context),
                    style: AppTextStyles.font24Bold,
                  ),
                  Image.asset(
                    AppAssets.logo,
                    height: 32.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              hSpace(20),
              const AuthProfileCardWidget(),
              hSpace(20),
              EmployeeSettingsSectionCardWidget(
                sectionTitleKey: 'employee.settings.sectionAccount',
                tiles: [
                  EmployeeSettingsTileWidget(
                    icon: Icons.person_outline_rounded,
                    titleKey: 'employee.settings.profileInfo',
                    valueKey: 'employee.settings.userName',
                    onTap: () => showEditProfileSheet(context),
                  ),
                  EmployeeSettingsTileWidget(
                    icon: Icons.key_outlined,
                    titleKey: 'employee.settings.changePassword',
                    valueKey: '••••••••',
                    onTap: () => showChangePasswordSheet(context),
                  ),
                  EmployeeSettingsTileWidget(
                    icon: Icons.notifications_none_rounded,
                    titleKey: 'employee.settings.notifications',
                    valueKey: 'employee.settings.enabled',
                  ),
                  EmployeeSettingsTileWidget(
                    icon: Icons.shield_outlined,
                    titleKey: 'admin.settings.permissions',
                    valueKey: 'admin.settings.roleBased',
                    onTap: () => showUserPermissionsSheet(context),
                  ),
                  BlocBuilder<AuthProfileCubit, AuthProfileState>(
                    builder: (context, state) {
                      final (role, roles) = state.maybeWhen(
                        success: (
                          name,
                          userId,
                          role,
                          username,
                          permissions,
                          roles,
                        ) => (role, roles),
                        orElse: () => ('', const <String>[]),
                      );
                      if (roles.length <= 1) return const SizedBox.shrink();
                      return EmployeeSettingsTileWidget(
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
              EmployeeSettingsSectionCardWidget(
                sectionTitleKey: 'remoteWork.title',
                tiles: [
                  EmployeeSettingsTileWidget(
                    icon: Icons.home_work_outlined,
                    titleKey: 'remoteWork.title',
                    valueKey: 'remoteWork.manageRequest',
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.remoteWork),
                  ),
                ],
              ),
              hSpace(20),
              EmployeeSettingsSectionCardWidget(
                sectionTitleKey: 'employee.settings.sectionSystem',
                tiles: [
                  EmployeeSettingsTileWidget(
                    icon: Icons.language_rounded,
                    titleKey: 'employee.settings.language',
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
                  const EmployeeSettingsTileWidget(
                    icon: Icons.info_outline_rounded,
                    titleKey: 'employee.settings.appVersion',
                    valueKey: 'v1.0.0',
                  ),
                ],
              ),
              hSpace(24),
              const EmployeeSettingsSignOutButtonWidget(),
              hSpace(20),
              Center(
                child: Text(
                  'employee.settings.footer'.tr(context: context),
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.placeholder,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
