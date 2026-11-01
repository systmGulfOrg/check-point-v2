import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/session/auth_session_cubit.dart';
import 'delete_account_submit_bloc_consumer_widget.dart';

/// Asks for the password before deleting the account. Pops `true` once the
/// account is deleted.
class DeleteAccountDialogWidget extends StatefulWidget {
  const DeleteAccountDialogWidget({super.key});

  @override
  State<DeleteAccountDialogWidget> createState() =>
      _DeleteAccountDialogWidgetState();
}

class _DeleteAccountDialogWidgetState extends State<DeleteAccountDialogWidget> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Dialog(
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
    child: SingleChildScrollView(
      padding: EdgeInsets.all(20.r),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56.r,
              height: 56.r,
              decoration: const BoxDecoration(
                color: AppColors.softRedBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_forever_outlined,
                color: AppColors.error,
                size: 28.r,
              ),
            ),
            hSpace(16),
            Text(
              'auth.deleteAccount.title'.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyles.font18Bold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            hSpace(8),
            Text(
              'auth.deleteAccount.message'.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(16),
            CustomTextFormField(
              controller: passwordController,
              hintText: 'auth.deleteAccount.passwordHint'.tr(context: context),
              obscureText: true,
              validator: (value) => (value == null || value.isEmpty)
                  ? 'auth.deleteAccount.passwordRequired'.tr(context: context)
                  : null,
            ),
            hSpace(20),
            DeleteAccountSubmitBlocConsumerWidget(
              onSubmit: () {
                if (formKey.currentState?.validate() ?? false) {
                  context.read<AuthSessionCubit>().deleteAccount(
                    passwordController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    ),
  );
}
