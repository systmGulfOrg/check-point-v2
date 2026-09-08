import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/login/login_state.dart';

class LoginSubmitButtonWidget extends StatelessWidget {
  const LoginSubmitButtonWidget({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) => BlocBuilder<LoginCubit, LoginState>(
    builder: (context, state) => CustomButton(
      text: 'auth.login.submit'.tr(context: context),
      onTap: onSubmit,
      isLoading: state is LoginLoading,
    ),
  );
}
