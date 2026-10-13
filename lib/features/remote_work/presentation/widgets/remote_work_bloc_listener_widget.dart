import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/remote_work_cubit.dart';
import '../cubit/remote_work_state.dart';

class RemoteWorkBlocListenerWidget extends StatelessWidget {
  const RemoteWorkBlocListenerWidget({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<RemoteWorkCubit, RemoteWorkState>(
        listenWhen: (previous, current) =>
            current.maybeWhen(error: (_) => true, orElse: () => false),
        listener: (context, state) {
          state.maybeWhen(
            error: (messageKey) {
              CustomSnackBar.showError(
                context,
                message: messageKey.tr(context: context),
              );
              unawaited(context.read<RemoteWorkCubit>().load());
            },
            orElse: () {},
          );
        },
        child: child,
      );
}
