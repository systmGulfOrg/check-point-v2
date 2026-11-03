import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/worker_roll_call/supervisor_worker_roll_call_state.dart';
import 'supervisor_worker_roll_call_item_widget.dart';

class SupervisorWorkerRollCallBlocBuilderWidget extends StatelessWidget {
  const SupervisorWorkerRollCallBlocBuilderWidget({
    required this.selectedWorkerIds,
    required this.onWorkerToggled,
    super.key,
  });

  final Set<String> selectedWorkerIds;
  final void Function(String workerId, bool isSelected) onWorkerToggled;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      SupervisorWorkerRollCallCubit,
      SupervisorWorkerRollCallState
    >(
      builder: (context, state) {
        return switch (state) {
          SupervisorWorkerRollCallLoading() => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(color: AppColors.brandPrimary),
            ),
          ),
          SupervisorWorkerRollCallError(:final messageKey) => Center(
            child: Padding(
              padding: EdgeInsets.all(24.r),
              child: Text(
                messageKey.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
          SupervisorWorkerRollCallLoaded(
            :final workers,
            :final selectedSiteId,
          ) =>
            workers.isEmpty
                ? Center(
                    child: Padding(
                      padding: EdgeInsets.all(32.r),
                      child: Text(
                        'contractorWorker.rollCall.noWorkers'.tr(
                          context: context,
                        ),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: workers.length,
                    itemBuilder: (context, index) {
                      final worker = workers[index];
                      return SupervisorWorkerRollCallItemWidget(
                        worker: worker,
                        currentSiteId: selectedSiteId,
                        isSelected: selectedWorkerIds.contains(worker.id),
                        onToggle: (checked) =>
                            onWorkerToggled(worker.id, checked),
                      );
                    },
                  ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
