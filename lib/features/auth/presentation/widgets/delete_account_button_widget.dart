import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'delete_account_dialog_widget.dart';

/// Settings entry that lets the user delete their own account
/// (App Store Guideline 5.1.1(v)).
class DeleteAccountButtonWidget extends StatelessWidget {
  const DeleteAccountButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: () async {
          final authSessionCubit = context.read<AuthSessionCubit>();
          final deleted = await showDialog<bool>(
            context: context,
            builder: (_) => BlocProvider.value(
              value: authSessionCubit,
              child: const DeleteAccountDialogWidget(),
            ),
          );
          if (deleted != true || !context.mounted) return;
          CustomSnackBar.show(
            context,
            message: 'auth.deleteAccount.deleted'.tr(context: context),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
        },
        icon: Icon(
          Icons.delete_forever_outlined,
          color: AppColors.error,
          size: 18.r,
        ),
        label: Text(
          'auth.deleteAccount.button'.tr(context: context),
          style: AppTextStyles.font14Regular.copyWith(color: AppColors.error),
        ),
      ),
    );
  }
}
