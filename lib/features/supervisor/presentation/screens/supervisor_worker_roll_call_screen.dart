import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_state.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_worker_roll_call_bloc_builder_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_worker_roll_call_bloc_listener_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_worker_roll_call_bottom_bar_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_worker_roll_call_header_widget.dart';

class SupervisorWorkerRollCallScreen extends StatefulWidget {
  const SupervisorWorkerRollCallScreen({super.key});

  @override
  State<SupervisorWorkerRollCallScreen> createState() =>
      _SupervisorWorkerRollCallScreenState();
}

class _SupervisorWorkerRollCallScreenState
    extends State<SupervisorWorkerRollCallScreen> {
  final Set<String> _selectedWorkerIds = {};
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _clockInTime = TimeOfDay.now();
  TimeOfDay? _clockOutTime;

  @override
  void initState() {
    super.initState();
    context.read<SupervisorWorkerRollCallCubit>().loadRollCallData();
  }

  void _onToggleWorker(String workerId, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedWorkerIds.add(workerId);
      } else {
        _selectedWorkerIds.delete(workerId);
      }
    });
  }

  void _onSelectAll(bool selectAll) {
    final state = context.read<SupervisorWorkerRollCallCubit>().state;
    if (state is! SupervisorWorkerRollCallLoaded) return;
    setState(() {
      _selectedWorkerIds.clear();
      if (selectAll) {
        final currentSiteName = state.sites
            .where((s) => s.id?.toString() == state.selectedSiteId)
            .firstOrNull
            ?.name;
        for (final w in state.workers) {
          final isOther = w.attendance?.siteId != null &&
              w.attendance?.siteId != state.selectedSiteId &&
              (currentSiteName == null ||
                  w.attendance?.siteName != currentSiteName);
          if (w.isActive &&
              w.attendance?.clockOutTime == null &&
              !isOther) {
            _selectedWorkerIds.add(w.id);
          }
        }
      }
    });
  }

  Future<void> _submit() async {
    final state = context.read<SupervisorWorkerRollCallCubit>().state;
    if (state is! SupervisorWorkerRollCallLoaded) return;
    final siteId = state.selectedSiteId;
    if (siteId == null || siteId.isEmpty) return;

    final clockInStr =
        '${_clockInTime.hour.toString().padLeft(2, '0')}:${_clockInTime.minute.toString().padLeft(2, '0')}';
    final clockOutStr = _clockOutTime != null
        ? '${_clockOutTime!.hour.toString().padLeft(2, '0')}:${_clockOutTime!.minute.toString().padLeft(2, '0')}'
        : null;

    await context.read<SupervisorWorkerRollCallCubit>().submitRollCall(
      siteId: siteId,
      date: _selectedDate,
      workerIds: _selectedWorkerIds.toList(),
      clockIn: clockInStr,
      clockOut: clockOutStr,
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SupervisorWorkerRollCallCubit>().state;
    final (sites, selectedSiteId, isSubmitting, workersCount) = switch (state) {
      SupervisorWorkerRollCallLoaded(
        :final sites,
        :final selectedSiteId,
        :final isSubmitting,
        :final workers,
      ) =>
        (sites, selectedSiteId, isSubmitting, workers.length),
      _ => (const [], null, false, 0),
    };

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractorWorker.rollCall.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SupervisorWorkerRollCallBlocListenerWidget(
        onSuccess: () => setState(() => _selectedWorkerIds.clear()),
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => context
              .read<SupervisorWorkerRollCallCubit>()
              .loadRollCallData(date: _selectedDate, siteId: selectedSiteId),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SupervisorWorkerRollCallHeaderWidget(
                  sites: sites.cast(),
                  selectedSiteId: selectedSiteId,
                  selectedDate: _selectedDate,
                  onSiteChanged: (id) {
                    if (id != null) {
                      context
                          .read<SupervisorWorkerRollCallCubit>()
                          .selectSite(id);
                      setState(() => _selectedWorkerIds.clear());
                    }
                  },
                  onDateChanged: (d) {
                    setState(() {
                      _selectedDate = d;
                      _selectedWorkerIds.clear();
                    });
                    context
                        .read<SupervisorWorkerRollCallCubit>()
                        .loadRollCallData(date: d, siteId: selectedSiteId);
                  },
                  onSearchChanged: (q) {
                    context
                        .read<SupervisorWorkerRollCallCubit>()
                        .loadRollCallData(
                          date: _selectedDate,
                          siteId: selectedSiteId,
                          search: q,
                        );
                  },
                  isAllSelected:
                      _selectedWorkerIds.isNotEmpty &&
                      workersCount > 0 &&
                      _selectedWorkerIds.length >= workersCount,
                  onSelectAllChanged: _onSelectAll,
                ),
                hSpace(12),
                SupervisorWorkerRollCallBlocBuilderWidget(
                  selectedWorkerIds: _selectedWorkerIds,
                  onWorkerToggled: _onToggleWorker,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SupervisorWorkerRollCallBottomBarWidget(
        selectedCount: _selectedWorkerIds.length,
        clockInTime: _clockInTime,
        clockOutTime: _clockOutTime,
        isSubmitting: isSubmitting,
        onPickClockIn: () async {
          final t = await showTimePicker(
            context: context,
            initialTime: _clockInTime,
          );
          if (t != null) setState(() => _clockInTime = t);
        },
        onPickClockOut: () async {
          final t = await showTimePicker(
            context: context,
            initialTime: _clockOutTime ?? TimeOfDay.now(),
          );
          if (t != null) setState(() => _clockOutTime = t);
        },
        onSubmit: _submit,
      ),
    );
  }
}

extension on Set<String> {
  void delete(String value) => remove(value);
}
