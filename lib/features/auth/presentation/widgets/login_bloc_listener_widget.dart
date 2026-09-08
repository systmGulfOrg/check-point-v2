import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';

class LoginBlocListenerWidget extends StatelessWidget {
  const LoginBlocListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocListener<LoginCubit, LoginState>(
    listener: (context, state) {
      switch (state) {
        case LoginSuccess(:final user):
          final role = user.roles != null && user.roles!.isNotEmpty
              ? user.roles!.first.toLowerCase()
              : null;
          if (role == 'admin') {
            context.pushReplacementNamed(AppRoutes.admin);
          } else if (role == 'supervisor') {
            context.pushReplacementNamed(AppRoutes.supervisor);
          } else {
            context.pushReplacementNamed(AppRoutes.employee);
          }
        case LoginError(:final messageKey):
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(messageKey.tr(context: context))),
          );
        default:
          break;
      }
    },
    child: child,
  );
}
