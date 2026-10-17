import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_state.dart';

class TrialSignupSubmitButtonWidget extends StatelessWidget {
  const TrialSignupSubmitButtonWidget({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TrialSignupCubit, TrialSignupState>(
        builder: (context, state) => CustomButton(
          text: 'auth.trialSignup.submit'.tr(context: context),
          onTap: onSubmit,
          isLoading: state is TrialSignupLoading,
        ),
      );
}
