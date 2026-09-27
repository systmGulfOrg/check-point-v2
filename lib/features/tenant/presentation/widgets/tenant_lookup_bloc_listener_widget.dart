import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/tenant/presentation/cubit/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/tenant/presentation/cubit/tenant_lookup_state.dart';

class TenantLookupBlocListenerWidget extends StatelessWidget {
  const TenantLookupBlocListenerWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<TenantLookupCubit, TenantLookupState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (tenant) {
            final companyName = tenant.companyName ?? tenant.tenantCode ?? '';
            CustomSnackBar.showSuccess(
              context,
              message:
                  '${'tenant.lookup.welcomeTo'.tr(context: context)} $companyName',
            );
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          },
          error: (message) {
            CustomSnackBar.showError(
              context,
              message: message.tr(context: context),
            );
          },
        );
      },
      child: child,
    );
  }
}
