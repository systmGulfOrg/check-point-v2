import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee_record/presentation/cubit/employee_record_cubit.dart';

/// Previous / next month. Chevrons mirror in RTL (matchTextDirection icons).
class EmployeeRecordMonthPickerWidget extends StatelessWidget {
  const EmployeeRecordMonthPickerWidget({required this.month, super.key});

  final DateTime month;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EmployeeRecordCubit>();
    return Padding(
      padding: EdgeInsetsDirectional.only(bottom: 12.h),
      child: Row(
        children: [
          IconButton(
            tooltip: 'record.previousMonth'.tr(context: context),
            onPressed: cubit.previousMonth,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Expanded(
            child: Text(
              DateFormat.yMMMM(context.locale.toString()).format(month),
              textAlign: TextAlign.center,
              style: AppTextStyles.font16Bold,
            ),
          ),
          IconButton(
            tooltip: 'record.nextMonth'.tr(context: context),
            onPressed: cubit.canGoNext ? cubit.nextMonth : null,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }
}
