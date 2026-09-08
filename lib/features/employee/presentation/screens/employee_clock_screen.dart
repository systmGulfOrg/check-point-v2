import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/employee_attendance_cubit.dart';
import '../cubit/employee_attendance_state.dart';
import '../widgets/employee_attendance_record_card_widget.dart';
import '../widgets/employee_attendance_record_data.dart';
import '../widgets/employee_clock_card_widget.dart';

class EmployeeClockScreen extends StatefulWidget {
  const EmployeeClockScreen({super.key});

  @override
  State<EmployeeClockScreen> createState() => _EmployeeClockScreenState();
}

class _EmployeeClockScreenState extends State<EmployeeClockScreen> {
  bool _isCheckedIn = false;
  bool _hasCheckedOut = true;
  String _checkInTime = '--:--';
  String _checkOutTime = '--:--';
  String? _workedHours;

  @override
  void initState() {
    super.initState();
    context.read<EmployeeAttendanceCubit>().loadAttendanceHistory();
  }

  void _toggleCheckInOut() {
    final cubit = context.read<EmployeeAttendanceCubit>();
    if (_isCheckedIn) {
      cubit.checkOut();
    } else {
      cubit.checkIn(area: 'Office');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'employee.clock.title'.tr(context: context),
                style: AppTextStyles.font24Bold,
              ),
              hSpace(20),
              BlocConsumer<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                listener: (context, state) {
                  switch (state) {
                    case EmployeeAttendanceStateCheckInSuccess(:final attendance):
                      setState(() {
                        _isCheckedIn = true;
                        _hasCheckedOut = false;
                        _checkInTime = attendance.clockInTime ?? DateFormat('HH:mm').format(DateTime.now());
                        _checkOutTime = '—';
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checked in successfully')),
                      );
                    case EmployeeAttendanceStateCheckOutSuccess(:final attendance):
                      setState(() {
                        _isCheckedIn = false;
                        _hasCheckedOut = true;
                        _checkOutTime = attendance.clockOutTime ?? DateFormat('HH:mm').format(DateTime.now());
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Checked out successfully')),
                      );
                    case EmployeeAttendanceStateError(:final messageKey):
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(messageKey)),
                      );
                    default:
                      break;
                  }
                },
                builder: (context, state) {
                  return EmployeeClockCardWidget(
                    policyText: 'Standard Policy — 08:00–16:00',
                    checkInTime: _checkInTime,
                    checkOutTime: _checkOutTime,
                    isCheckedIn: _isCheckedIn,
                    hasCheckedOut: _hasCheckedOut,
                    workedHours: _workedHours,
                    onToggleCheckInOut: _toggleCheckInOut,
                  );
                },
              ),
              hSpace(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'employee.clock.recentAttendance'.tr(context: context),
                    style: AppTextStyles.font18Bold,
                  ),
                  hSpace(12),
                  BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                    builder: (context, state) {
                      final historyRecords = switch (state) {
                        EmployeeAttendanceStateHistoryLoaded(:final history) => history
                            .map((item) => EmployeeAttendanceRecordData(
                                  date: item.attendanceDate ?? 'Today',
                                  checkIn: 'In ${item.clockInTime ?? '--:--'} · Out ${item.clockOutTime ?? '--:--'}',
                                  status: item.isLate == true ? 'Late' : 'On Time',
                                ))
                            .toList(),
                        _ => const <EmployeeAttendanceRecordData>[],
                      };

                      if (historyRecords.isEmpty) {
                        return Container(
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: const Center(
                            child: Text('No attendance history found'),
                          ),
                        );
                      }

                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.border),
                          boxShadow: const [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            for (int i = 0; i < historyRecords.length; i++) ...[
                              EmployeeAttendanceRecordCardWidget(
                                record: historyRecords[i],
                              ),
                              if (i < historyRecords.length - 1)
                                const Divider(
                                  height: 1,
                                  thickness: 1,
                                  color: AppColors.border,
                                ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
