import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/data/models/employee_record_args.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_cubit.dart';
import 'package:check_point_v2/features/employee_record/presentation/widgets/employee_record_bloc_builder_widget.dart';

/// Attendance, leave, holidays, weekly days off and permits, day by day.
class EmployeeRecordScreen extends StatelessWidget {
  const EmployeeRecordScreen({required this.args, super.key});

  final EmployeeRecordArgs args;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        args.employeeName ?? 'record.title'.tr(context: context),
        style: AppTextStyles.font18Bold,
      ),
    ),
    body: RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: context.read<EmployeeRecordCubit>().load,
      child: const EmployeeRecordBlocBuilderWidget(),
    ),
  );
}
