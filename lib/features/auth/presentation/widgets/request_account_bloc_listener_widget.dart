import 'package:check_point_v2/core/core.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/request_account/request_account_state.dart';

class RequestAccountBlocListenerWidget extends StatelessWidget {
  const RequestAccountBlocListenerWidget({
    required this.child,
    required this.onSuccess,
    super.key,
  });

  final Widget child;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) =>
      BlocListener<RequestAccountCubit, RequestAccountState>(
        listener: (context, state) {
          switch (state) {
            case RequestAccountSuccess():
              onSuccess();
            case RequestAccountError(:final messageKey):
              CustomSnackBar.show(
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
