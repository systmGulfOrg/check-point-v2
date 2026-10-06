import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/data/models/tasks/employee_task_log_model.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/tasks/employee_tasks_cubit.dart';

class EmployeeTaskLogsSheetWidget extends StatelessWidget {
  const EmployeeTaskLogsSheetWidget({required this.taskId, super.key});

  final String taskId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<EmployeeTasksCubit>().loadTaskLogs(taskId),
      builder: (context, snapshot) {
        final result = snapshot.data;
        if (snapshot.connectionState != ConnectionState.done) {
          return Padding(
            padding: EdgeInsets.all(20.r),
            child: Skeletonizer(
              enabled: true,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loading Task Logs Placeholder Title',
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(14),
                  const Text('2026-09-20 • 60 min • Skeleton task log item'),
                  hSpace(10),
                  const Text('2026-09-20 • 45 min • Skeleton task log item'),
                ],
              ),
            ),
          );
        }
        final errorKey = switch (result) {
          Failure<List<EmployeeTaskLogModel>>(:final failure) =>
            failure.messageKey,
          _ => null,
        };
        if (errorKey != null) {
          return Padding(
            padding: EdgeInsets.all(24.r),
            child: Text(errorKey.tr()),
          );
        }
        final logs = switch (result) {
          Success<List<EmployeeTaskLogModel>>(:final data) => data,
          _ => const <EmployeeTaskLogModel>[],
        };
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
            child: logs.isEmpty
                ? Text('employee.tasks.noLogs'.tr())
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'employee.tasks.logs'.tr(),
                        style: AppTextStyles.font18Bold,
                      ),
                      hSpace(14),
                      for (final log in logs)
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: Text(
                            '${log.workDate} • ${log.durationMinutes} ${'employee.tasks.minutes'.tr()}${log.note == null ? '' : ' • ${log.note}'}',
                            style: AppTextStyles.font13Regular,
                          ),
                        ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
