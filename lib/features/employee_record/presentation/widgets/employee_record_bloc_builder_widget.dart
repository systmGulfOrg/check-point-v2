import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_cubit.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_state.dart';
import 'employee_record_day_tile_widget.dart';
import 'employee_record_month_picker_widget.dart';
import 'employee_record_skeleton_widget.dart';
import 'employee_record_totals_widget.dart';

/// Month picker + totals + one tile per day, with loading / error / empty states.
class EmployeeRecordBlocBuilderWidget extends StatelessWidget {
  const EmployeeRecordBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EmployeeRecordCubit, EmployeeRecordState>(
        builder: (context, state) => ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 28.h),
          children: switch (state) {
            EmployeeRecordLoading(:final month) => [
              EmployeeRecordMonthPickerWidget(month: month),
              const EmployeeRecordSkeletonWidget(),
            ],
            EmployeeRecordError(:final messageKey, :final month) => [
              EmployeeRecordMonthPickerWidget(month: month),
              AppErrorStateWidget(
                messageKey: messageKey,
                onRetry: () => context.read<EmployeeRecordCubit>().load(),
              ),
            ],
            EmployeeRecordSuccess(:final record, :final month) => [
              EmployeeRecordMonthPickerWidget(month: month),
              EmployeeRecordTotalsWidget(totals: record.totals),
              if (record.days.isEmpty)
                const AppMessageWidget(messageKey: 'record.empty')
              else
                for (final day in record.days.reversed) EmployeeRecordDayTileWidget(day: day),
            ],
            _ => const [SizedBox.shrink()],
          },
        ),
      );
}
