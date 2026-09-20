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
    super.key,
  });

  final Widget child;
  final VoidCallback onDeviceTransferRequired;

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
          if (role == 'admin') {
            context.pushReplacementNamed(AppRoutes.admin);
          } else if (role == 'supervisor') {
            context.pushReplacementNamed(AppRoutes.supervisor);
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
        case LoginDeviceTransferRequired():
          onDeviceTransferRequired();
        default:
          break;
      }
    },
    child: child,
  );
}
