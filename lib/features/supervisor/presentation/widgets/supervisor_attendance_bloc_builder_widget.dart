import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/attendance/admin_attendance_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/attendance/supervisor_attendance_state.dart';
import 'supervisor_attendance_list_widget.dart';

class SupervisorAttendanceBlocBuilderWidget extends StatelessWidget {
  const SupervisorAttendanceBlocBuilderWidget({
    required this.selectedFilterIndex,
    super.key,
  });

  final int selectedFilterIndex;

  static const _dummyRecords = [
    AdminAttendanceModel(
      employeeName: 'Loading Employee',
      clockInTime: '08:00',
      isLate: false,
    ),
    AdminAttendanceModel(
      employeeName: 'Loading Employee',
      clockInTime: '09:20',
      isLate: true,
    ),
    AdminAttendanceModel(
      employeeName: 'Loading Employee',
      clockInTime: '08:30',
      isLate: false,
    ),
  ];

  Widget _buildAttendanceList(
    BuildContext context,
    List<AdminAttendanceModel> attendance,
    List<AdminAttendanceModel> lateComers,
    List<AdminAttendanceModel> earlyLeavers,
  ) {
    return SupervisorAttendanceListWidget(
      records: switch (selectedFilterIndex) {
        1 => lateComers,
        2 => earlyLeavers,
        _ => attendance,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SupervisorAttendanceCubit>();

    return BlocListener<SupervisorAttendanceCubit, SupervisorAttendanceState>(
      listener: (context, state) {
        if (state is SupervisorAttendanceError &&
            cubit.allAttendance.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.messageKey.tr(context: context)),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: BlocBuilder<SupervisorAttendanceCubit, SupervisorAttendanceState>(
        builder: (context, state) {
          return switch (state) {
            SupervisorAttendanceLoading() => cubit.allAttendance.isNotEmpty
                ? _buildAttendanceList(
                    context,
                    cubit.allAttendance,
                    cubit.lateComers,
                    cubit.earlyLeavers,
                  )
                : const Skeletonizer(
                    enabled: true,
                    child:
                        SupervisorAttendanceListWidget(records: _dummyRecords),
                  ),
            SupervisorAttendanceSuccess(
              :final attendance,
              :final lateComers,
              :final earlyLeavers,
            ) =>
              _buildAttendanceList(
                context,
                attendance,
                lateComers,
                earlyLeavers,
              ),
            SupervisorAttendanceError(:final messageKey) =>
              cubit.allAttendance.isNotEmpty
                  ? _buildAttendanceList(
                      context,
                      cubit.allAttendance,
                      cubit.lateComers,
                      cubit.earlyLeavers,
                    )
                  : Center(
                      child: Text(
                        messageKey.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ),
            _ => const SupervisorAttendanceListWidget(records: []),
          };
        },
      ),
    );
  }
}
