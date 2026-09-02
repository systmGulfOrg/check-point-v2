import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';

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
