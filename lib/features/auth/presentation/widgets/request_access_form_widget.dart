import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'request_account_submit_button_widget.dart';

class RequestAccessFormWidget extends StatefulWidget {
  const RequestAccessFormWidget({super.key});

  @override
  State<RequestAccessFormWidget> createState() =>
      _RequestAccessFormWidgetState();
}

class _RequestAccessFormWidgetState extends State<RequestAccessFormWidget> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController fullNameController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'auth.requestAccess.cardTitle'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(color: AppColors.brandInk),
        ),
        hSpace(6),
        Text(
          'auth.requestAccess.cardDescription'.tr(context: context),
          style: AppTextStyles.font13Regular.copyWith(height: 1.5),
        ),
        hSpace(22),
        Text(
          'auth.requestAccess.fullName'.tr(context: context),
          textAlign: TextAlign.start,
          style: AppTextStyles.font14SemiBold,
        ),
        hSpace(8),
        CustomTextFormField(
          hintText: 'auth.requestAccess.fullNameHint'.tr(context: context),
          controller: fullNameController,
          prefixIcon: Icon(
            Icons.person_outline_rounded,
            size: 21.r,
            color: AppColors.placeholder,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'auth.requestAccess.fullNameRequired'.tr(context: context);
            }
            return null;
          },
        ),
        hSpace(22),
        RequestAccountSubmitButtonWidget(
          onSubmit: () {
            FocusScope.of(context).unfocus();
            if (!(formKey.currentState?.validate() ?? false)) return;
            context.read<RequestAccountCubit>().submit(
              name: fullNameController.text.trim(),
            );
          },
        ),
      ],
    ),
  );
}
