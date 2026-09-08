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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorAttendanceCubit, SupervisorAttendanceState>(
      builder: (context, state) {
        return switch (state) {
          SupervisorAttendanceLoading() => const Skeletonizer(
            enabled: true,
            child: SupervisorAttendanceListWidget(records: _dummyRecords),
          ),
          SupervisorAttendanceSuccess(
            :final attendance,
            :final lateComers,
            :final earlyLeavers,
          ) =>
            SupervisorAttendanceListWidget(
              records: switch (selectedFilterIndex) {
                1 => lateComers,
                2 => earlyLeavers,
                _ => attendance,
              },
            ),
          SupervisorAttendanceError(:final messageKey) => Center(
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
    );
  }
}
