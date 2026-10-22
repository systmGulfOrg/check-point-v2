import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';

class RoleSwitchDialogWidget extends StatelessWidget {
  const RoleSwitchDialogWidget({
    required this.currentRole,
    required this.availableRoles,
    super.key,
  });

  final String currentRole;
  final List<String> availableRoles;

  static void show(
    BuildContext context, {
    required String currentRole,
    required List<String> availableRoles,
  }) {
    final cubit = context.read<AuthProfileCubit>();
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: RoleSwitchDialogWidget(
          currentRole: currentRole,
          availableRoles: availableRoles,
        ),
      ),
    );
  }

  String _roleName(BuildContext context, String role) {
    return switch (role.trim().toLowerCase()) {
      'admin' => 'auth.role.admin'.tr(context: context),
      'supervisor' => 'auth.role.supervisor'.tr(context: context),
      'employee' => 'auth.role.employee'.tr(context: context),
      _ => role,
    };
  }

  IconData _roleIcon(String role) {
    return switch (role.trim().toLowerCase()) {
      'admin' => Icons.admin_panel_settings_outlined,
      'supervisor' => Icons.supervised_user_circle_outlined,
      _ => Icons.person_outline_rounded,
    };
  }

  void _onSelectRole(BuildContext context, String selectedRole) {
    if (selectedRole.trim().toLowerCase() == currentRole.trim().toLowerCase()) {
      Navigator.of(context).pop();
      return;
    }

    final targetRoute = switch (selectedRole.trim().toLowerCase()) {
      'admin' => AppRoutes.admin,
      'supervisor' => AppRoutes.supervisor,
      _ => AppRoutes.employee,
    };

    final profileCubit = context.read<AuthProfileCubit>();
    final navigator = Navigator.of(context, rootNavigator: true);

    Navigator.of(context).pop();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await profileCubit.switchRole(selectedRole);
      navigator.pushNamedAndRemoveUntil(targetRoute, (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    Icons.swap_horiz_rounded,
                    color: AppColors.brandPrimary,
                    size: 24.r,
                  ),
                ),
                wSpace(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'auth.role.switchRole'.tr(context: context),
                        style: AppTextStyles.font18Bold,
                      ),
                      hSpace(2),
                      Text(
                        'auth.role.switchPrompt'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            hSpace(20),
            for (final role in availableRoles) ...[
              Builder(
                builder: (ctx) {
                  final isSelected =
                      role.trim().toLowerCase() ==
                      currentRole.trim().toLowerCase();
                  return Padding(
                    padding: EdgeInsets.only(bottom: 10.h),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onSelectRole(context, role),
                        borderRadius: BorderRadius.circular(14.r),
                        child: Ink(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.softBrandBackground
                                : AppColors.pageBackground,
                            borderRadius: BorderRadius.circular(14.r),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.brandPrimary
                                  : AppColors.border,
                              width: isSelected ? 1.5 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.brandPrimary
                                      : AppColors.cardBackground,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _roleIcon(role),
                                  color: isSelected
                                      ? AppColors.white
                                      : AppColors.textSecondary,
                                  size: 20.r,
                                ),
                              ),
                              wSpace(14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _roleName(context, role),
                                      style: AppTextStyles.font16Bold.copyWith(
                                        color: isSelected
                                            ? AppColors.brandPrimary
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                    if (isSelected)
                                      Text(
                                        'auth.role.currentRole'.tr(
                                          context: context,
                                        ),
                                        style: AppTextStyles.font11Regular
                                            .copyWith(
                                              color: AppColors.brandPrimary,
                                            ),
                                      ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.brandPrimary,
                                  size: 22.r,
                                )
                              else
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: AppColors.placeholder,
                                  size: 14.r,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
            hSpace(8),
          ],
        ),
      ),
    );
  }
}
