import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_state.dart';

class SupervisorWorkerRollCallBlocListenerWidget extends StatelessWidget {
  const SupervisorWorkerRollCallBlocListenerWidget({
    required this.child,
    required this.onSuccess,
    super.key,
  });

  final Widget child;
  final VoidCallback onSuccess;

  @override
  Widget build(BuildContext context) {
    return BlocListener<
      SupervisorWorkerRollCallCubit,
      SupervisorWorkerRollCallState
    >(
      listenWhen: (prev, current) => switch (current) {
        SupervisorWorkerRollCallLoaded(
          :final successMessage,
          :final errorMessage,
        ) =>
          successMessage != null || errorMessage != null,
        _ => false,
      },
      listener: (context, state) {
        if (state case SupervisorWorkerRollCallLoaded(
          :final successMessage,
          :final errorMessage,
        )) {
          if (successMessage != null) {
            onSuccess();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(successMessage.tr(context: context)),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorMessage.tr(context: context)),
                backgroundColor: AppColors.error,
              ),
            );
          }
        }
      },
      child: child,
    );
  }
}
