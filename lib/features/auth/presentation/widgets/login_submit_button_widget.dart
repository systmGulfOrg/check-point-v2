import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';

class LoginSubmitButtonWidget extends StatelessWidget {
  const LoginSubmitButtonWidget({
    required this.onSubmit,
    this.rateLimitSeconds = 0,
    super.key,
  });

  final VoidCallback onSubmit;
  final int rateLimitSeconds;

  String _formatDuration(BuildContext context, int totalSeconds) {
    if (totalSeconds >= 60) {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      final formattedTime =
          '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      return 'auth.login.countdownWait'.tr(
        context: context,
        args: [formattedTime],
      );
    }
    return 'auth.login.countdownWait'.tr(
      context: context,
      args: ['$totalSeconds ثانية'],
    );
  }

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
    builder: (context, state) => CustomButton(
      text: rateLimitSeconds > 0
          ? _formatDuration(context, rateLimitSeconds)
          : 'auth.login.submit'.tr(context: context),
      enabled: rateLimitSeconds == 0,
      onTap: onSubmit,
      isLoading: state is LoginLoading,
    ),
  );
}
