import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/trial_signup/trial_signup_state.dart';

class TrialSignupBlocListenerWidget extends StatelessWidget {
  const TrialSignupBlocListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<TrialSignupCubit, TrialSignupState>(
        listener: (context, state) {
          switch (state) {
            case TrialSignupSuccess(:final signup):
              final slug = signup.slug;
              if (slug != null && slug.isNotEmpty) {
                unawaited(sl<AuthSessionStorage>().saveTenantSlug(slug));
              }
              CustomSnackBar.showSuccess(
                context,
                message: 'auth.trialSignup.successMessage'.tr(
                  context: context,
                ),
              );
              context.pushNamedAndRemoveUntil(AppRoutes.login);
            case TrialSignupError(:final messageKey):
              CustomSnackBar.showError(
                context,
                message: messageKey.tr(context: context),
              );
            default:
              break;
          }
        },
        child: child,
      );
}
