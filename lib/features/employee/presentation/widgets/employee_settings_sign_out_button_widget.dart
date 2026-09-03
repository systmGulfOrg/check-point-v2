import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../auth/presentation/cubit/auth_session_cubit.dart';

class EmployeeSettingsSignOutButtonWidget extends StatelessWidget {
  const EmployeeSettingsSignOutButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () async {
          final didLogout = await context.read<AuthSessionCubit>().logout();
          if (!context.mounted) return;
          if (!didLogout) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('errors.logoutFailed'.tr(context: context)),
              ),
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
          backgroundColor: const Color(0xFFFEE2E2),
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
