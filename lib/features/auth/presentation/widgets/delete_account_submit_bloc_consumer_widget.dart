import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_state.dart';

/// Cancel / delete buttons of the delete-account dialog, with the server's
/// error shown above them. Closes the dialog with `true` on success.
class DeleteAccountSubmitBlocConsumerWidget extends StatelessWidget {
  const DeleteAccountSubmitBlocConsumerWidget({
    required this.onSubmit,
    super.key,
  });

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<AuthSessionCubit, AuthSessionState>(
        listener: (context, state) {
          if (state is AuthSessionSuccess) Navigator.pop(context, true);
        },
        builder: (context, state) {
          final isLoading = state is AuthSessionLoading;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (state case AuthSessionError(:final messageKey)) ...[
                Text(
                  messageKey.tr(context: context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.error,
                  ),
                ),
                hSpace(12),
              ],
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'auth.deleteAccount.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(context, false),
                      enabled: !isLoading,
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                      height: 44,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'auth.deleteAccount.confirm'.tr(context: context),
                      onTap: onSubmit,
                      isLoading: isLoading,
                      backgroundColor: AppColors.error,
                      textColor: AppColors.white,
                      height: 44,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
}
