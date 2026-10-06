import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/widgets/biometric_logout_warning_dialog_widget.dart';

class EmployeeSettingsSignOutButtonWidget extends StatelessWidget {
  const EmployeeSettingsSignOutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () async {
          final authSessionCubit = context.read<AuthSessionCubit>();
          final biometricEnabled = await authSessionCubit.isBiometricEnabled();
          if (!context.mounted) return;
          if (biometricEnabled) {
            final shouldLogout = await showDialog<bool>(
              context: context,
              builder: (_) => const BiometricLogoutWarningDialogWidget(),
            );
            if (shouldLogout != true || !context.mounted) return;
          }
          final didLogout = await authSessionCubit.logout();
          if (!context.mounted) return;
          if (!didLogout) {
            CustomSnackBar.show(
              context,
              message: 'errors.logoutFailed'.tr(context: context),
            );
            return;
          }
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        },
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 14.h),
          side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
          backgroundColor: AppColors.softRedBackground,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout_rounded, color: AppColors.error, size: 20.r),
            wSpace(8),
            Text(
              'employee.settings.signOut'.tr(context: context),
              style: AppTextStyles.font16Bold.copyWith(color: AppColors.error),
            ),
          ],
        ),
      ),
    );
  }
}
