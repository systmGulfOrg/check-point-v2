import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';

void showEditProfileSheet(BuildContext context) {
  final profileCubit = context.read<AuthProfileCubit>();

  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.cardBackground,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
    ),
    builder: (_) => BlocProvider.value(
      value: profileCubit,
      child: const EditProfileSheetWidget(),
    ),
  );
}

class EditProfileSheetWidget extends StatefulWidget {
  const EditProfileSheetWidget({super.key});

  @override
  State<EditProfileSheetWidget> createState() => _EditProfileSheetWidgetState();
}

class _EditProfileSheetWidgetState extends State<EditProfileSheetWidget> {
  late final TextEditingController nameController;
  late final TextEditingController usernameController;
  final formKey = GlobalKey<FormState>();
  bool isSaving = false;

  @override
  void initState() {
    super.initState();
    final state = context.read<AuthProfileCubit>().state;
    String currentName = '';
    String currentUsername = '';

    if (state is AuthProfileSuccess) {
      currentName = state.name;
      currentUsername = state.username;
    }

    nameController = TextEditingController(text: currentName);
    usernameController = TextEditingController(text: currentUsername);
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    setState(() => isSaving = true);
    final name = nameController.text.trim();
    final username = usernameController.text.trim();

    await context.read<AuthProfileCubit>().updateProfile(
      name: name,
      username: username,
    );

    if (mounted) {
      setState(() => isSaving = false);
      CustomSnackBar.showSuccess(
        context,
        message: 'profile.edit.success'.tr(context: context),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.border,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                hSpace(16),
                Text(
                  'profile.edit.title'.tr(context: context),
                  style: AppTextStyles.font18Bold,
                ),
                hSpace(16),
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'profile.edit.nameHint'.tr(context: context),
                  prefixIcon: Icon(Icons.person_outline_rounded, size: 19.r),
                  validator: AppValidators.name(
                    message: 'profile.edit.nameRequired'.tr(context: context),
                    context: context,
                  ),
                ),
                hSpace(12),
                CustomTextFormField(
                  controller: usernameController,
                  hintText: 'profile.edit.usernameHint'.tr(context: context),
                  prefixIcon: Icon(Icons.alternate_email_rounded, size: 19.r),
                  validator: AppValidators.required(
                    message: 'profile.edit.usernameRequired'.tr(
                      context: context,
                    ),
                    context: context,
                  ),
                ),
                hSpace(20),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: 'profile.edit.save'.tr(context: context),
                    isLoading: isSaving,
                    onTap: _handleSave,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
