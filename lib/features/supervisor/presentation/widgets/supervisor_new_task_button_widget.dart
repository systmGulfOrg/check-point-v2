import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/supervisor_tasks_cubit.dart';
import '../cubit/supervisor_team_cubit.dart';
import 'supervisor_create_task_sheet_widget.dart';

class SupervisorNewTaskButtonWidget extends StatelessWidget {
  const SupervisorNewTaskButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.cardBackground,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider.value(value: context.read<SupervisorTasksCubit>()),
              BlocProvider.value(value: context.read<SupervisorTeamCubit>()),
            ],
            child: const SupervisorCreateTaskSheetWidget(),
          ),
        );
      },
      child: Text(
        'supervisor.tasks.newTask'.tr(context: context),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
