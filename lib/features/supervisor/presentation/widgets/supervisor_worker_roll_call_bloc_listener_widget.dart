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
      listenWhen: (prev, current) =>
          current is SupervisorWorkerRollCallLoaded &&
          (current.successMessage != null || current.errorMessage != null),
      listener: (context, state) {
        if (state is SupervisorWorkerRollCallLoaded) {
          if (state.successMessage != null) {
            onSuccess();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.successMessage!.tr(context: context)),
                backgroundColor: AppColors.success,
              ),
            );
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!.tr(context: context)),
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
