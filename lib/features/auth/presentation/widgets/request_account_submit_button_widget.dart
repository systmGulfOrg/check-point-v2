import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/request_account_cubit.dart';
import '../cubit/request_account_state.dart';

class RequestAccountSubmitButtonWidget extends StatelessWidget {
  const RequestAccountSubmitButtonWidget({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RequestAccountCubit, RequestAccountState>(
        builder: (context, state) => CustomButton(
          text: 'auth.requestAccess.submit'.tr(context: context),
          onTap: onSubmit,
          isLoading: state is RequestAccountLoading,
          gradient: AppColors.brandGradient,
          height: 54,
        ),
      );
}
