import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';
import 'employee_create_task_sheet_widget.dart';

class EmployeeNewTaskButtonWidget extends StatelessWidget {
  const EmployeeNewTaskButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.cardBackground,
        builder: (_) => BlocProvider.value(
          value: context.read<EmployeeTasksCubit>(),
          child: const EmployeeCreateTaskSheetWidget(),
        ),
      ),
      child: Text(
        'supervisor.tasks.newTask'.tr(),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
