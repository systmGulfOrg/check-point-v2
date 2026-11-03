import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';

class SupervisorAttendanceSiteRollCallButtonWidget extends StatelessWidget {
  const SupervisorAttendanceSiteRollCallButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isContractor = context.select<AuthProfileCubit, bool>(
      (cubit) => switch (cubit.state) {
        AuthProfileSuccess(:final isContractorWorker) => isContractorWorker,
        _ => false,
      },
    );

    if (!isContractor) return const SizedBox.shrink();

    return IconButton(
      icon: const Icon(
        Icons.engineering_outlined,
        color: AppColors.brandPrimary,
      ),
      tooltip: 'contractorWorker.rollCall.title'.tr(context: context),
      onPressed: () =>
          Navigator.pushNamed(context, AppRoutes.supervisorWorkerRollCall),
    );
  }
}
