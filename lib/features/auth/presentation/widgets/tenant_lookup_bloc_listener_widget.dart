import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/tenant_lookup/tenant_lookup_state.dart';

class TenantLookupBlocListenerWidget extends StatelessWidget {
  const TenantLookupBlocListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<TenantLookupCubit, TenantLookupState>(
        listener: (context, state) {
          switch (state) {
            case TenantLookupSuccess():
              context.pushReplacementNamed(AppRoutes.login);
            case TenantLookupError(:final messageKey):
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
