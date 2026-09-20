import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/password/employee_change_password_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/password/employee_change_password_state.dart';

void showChangePasswordSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardBackground,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => BlocProvider<EmployeeChangePasswordCubit>(
      create: (_) => sl<EmployeeChangePasswordCubit>(),
      child: const ChangePasswordSheetWidget(),
    ),
  );
}

class ChangePasswordSheetWidget extends StatefulWidget {
  const ChangePasswordSheetWidget({super.key});

  @override
  State<ChangePasswordSheetWidget> createState() =>
      _ChangePasswordSheetWidgetState();
}

class _ChangePasswordSheetWidgetState extends State<ChangePasswordSheetWidget> {
  late final TextEditingController oldPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<EmployeeChangePasswordCubit>().state;
    final isLoading = state is EmployeeChangePasswordStateLoading;

    return BlocListener<
      EmployeeChangePasswordCubit,
      EmployeeChangePasswordState
    >(
      listener: (context, state) {
        switch (state) {
          case EmployeeChangePasswordStateSuccess():
            CustomSnackBar.showSuccess(
              context,
              message: 'profile.password.success'.tr(context: context),
            );
            Navigator.pop(context);
          case EmployeeChangePasswordStateError(:final messageKey):
            CustomSnackBar.showError(
              context,
              message: messageKey.tr(context: context),
            );
          default:
            break;
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            18.h,
            20.w,
            MediaQuery.viewInsetsOf(context).bottom + 16.h,
          ),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'profile.password.title'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(16),
                  CustomTextFormField(
                    controller: oldPasswordController,
                    hintText: 'profile.password.currentHint'.tr(
                      context: context,
                    ),
                    obscureText: true,
                    prefixIcon: Icon(Icons.lock_outline_rounded, size: 19.r),
                    validator: (value) => value == null || value.isEmpty
                        ? 'profile.password.currentRequired'.tr(
                            context: context,
                          )
                        : null,
                  ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: newPasswordController,
                    hintText: 'profile.password.newHint'.tr(context: context),
                    obscureText: true,
                    prefixIcon: Icon(Icons.key_outlined, size: 19.r),
                    validator: (value) => value == null || value.length < 6
                        ? 'profile.password.minimumLength'.tr(context: context)
                        : null,
                  ),
                  hSpace(12),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    hintText: 'profile.password.confirmHint'.tr(
                      context: context,
                    ),
                    obscureText: true,
                    prefixIcon: Icon(Icons.verified_user_outlined, size: 19.r),
                    validator: (value) => value != newPasswordController.text
                        ? 'profile.password.confirmMismatch'.tr(
                            context: context,
                          )
                        : null,
                  ),
                  hSpace(20),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      text: 'profile.password.save'.tr(context: context),
                      isLoading: isLoading,
                      onTap: () {
                        if (!(formKey.currentState?.validate() ?? false)) {
                          return;
                        }
                        context
                            .read<EmployeeChangePasswordCubit>()
                            .changePassword(
                              oldPassword: oldPasswordController.text.trim(),
                              newPassword: newPasswordController.text.trim(),
                            );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
