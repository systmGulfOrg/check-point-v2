import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';
import 'employee_create_project_sheet_widget.dart';

class EmployeeNewProjectButtonWidget extends StatelessWidget {
  const EmployeeNewProjectButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.cardBackground,
        builder: (_) => BlocProvider.value(
          value: context.read<EmployeePlansCubit>(),
          child: const EmployeeCreateProjectSheetWidget(),
        ),
      ),
      child: Text(
        'employee.plans.create'.tr(),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
