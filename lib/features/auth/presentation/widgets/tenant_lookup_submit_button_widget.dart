import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_state.dart';

class TenantLookupSubmitButtonWidget extends StatelessWidget {
  const TenantLookupSubmitButtonWidget({required this.onSubmit, super.key});

  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TenantLookupCubit, TenantLookupState>(
        builder: (context, state) => CustomButton(
          text: 'auth.companyCode.continueButton'.tr(context: context),
          onTap: onSubmit,
          isLoading: state is TenantLookupLoading,
        ),
      );
}
