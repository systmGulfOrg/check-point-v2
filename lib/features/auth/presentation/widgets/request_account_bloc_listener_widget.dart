import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/request_account_cubit.dart';
import '../cubit/request_account_state.dart';

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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(messageKey.tr(context: context))),
              );
            default:
              break;
          }
        },
        child: child,
      );
}
