import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';

class LoginBlocListenerWidget extends StatelessWidget {
  const LoginBlocListenerWidget({
    required this.child,
    required this.onDeviceTransferRequired,
    this.onAccountLocked,
    this.onOutsideZone,
    super.key,
  });

  final Widget child;
  final VoidCallback onDeviceTransferRequired;
  final void Function(int lockoutMinutes)? onAccountLocked;
  final void Function(String? siteName)? onOutsideZone;

  @override
  Widget build(BuildContext context) => BlocListener<LoginCubit, LoginState>(
    listener: (context, state) {
      switch (state) {
        case LoginSuccess(:final user, :final selectedRole):
          final role =
              (selectedRole ??
                      (user.roles != null && user.roles!.isNotEmpty
                          ? user.roles!.first
                          : user.role ?? 'employee'))
                  .trim()
                  .toLowerCase();
          if (role == 'admin' || role == 'hr') {
            context.pushReplacementNamed(AppRoutes.admin);
          } else if (role == 'supervisor' || role == 'sitesupervisor') {
            context.pushReplacementNamed(AppRoutes.supervisor);
          } else if (role == 'contractor') {
            context.pushReplacementNamed(AppRoutes.contractor);
          } else {
            context.pushReplacementNamed(AppRoutes.employee);
          }
        case LoginError(:final messageKey):
          if (messageKey == 'deviceTransferSuccess') {
            CustomSnackBar.showSuccess(
              context,
              message: 'auth.login.deviceTransferSuccess'.tr(context: context),
            );
          } else {
            CustomSnackBar.showError(
              context,
              message: messageKey.tr(context: context),
            );
          }
        case LoginAccountLocked(:final lockoutMinutes):
          if (onAccountLocked != null) {
            onAccountLocked!(lockoutMinutes);
          }
          CustomSnackBar.showError(
            context,
            message: 'errors.accountLockedWithTime'.tr(
              context: context,
              args: [lockoutMinutes.toString()],
            ),
          );
        case LoginOutsideZone(:final siteName, :final rawMessage):
          if (onOutsideZone != null) {
            onOutsideZone!(siteName);
          } else {
            final translatedMessage = siteName != null && siteName.isNotEmpty
                ? 'auth.login.outsideZoneMessageWithSite'.tr(
                    context: context,
                    args: [siteName],
                  )
                : 'auth.login.outsideZoneMessage'.tr(context: context);

            showDialog(
              context: context,
              builder: (dialogContext) => CustomDialogWidget(
                title: 'auth.login.outsideZoneTitle'.tr(context: context),
                message: rawMessage != null && rawMessage.isNotEmpty
                    ? '$translatedMessage\n\n📌 $rawMessage'
                    : translatedMessage,
                icon: Icons.location_off_rounded,
                onConfirm: () => Navigator.pop(dialogContext),
              ),
            );
          }
        case LoginDeviceTransferRequired():
          onDeviceTransferRequired();
        default:
          break;
      }
    },
    child: child,
  );
}
