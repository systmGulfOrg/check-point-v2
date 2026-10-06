import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/widgets/app_reject_reason_dialog_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_correction_card_widget.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

import 'package:skeletonizer/skeletonizer.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_correction_model.dart';

class SupervisorCorrectionsBlocBuilderWidget extends StatelessWidget {
  const SupervisorCorrectionsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorCubit, ContractorState>(
      builder: (context, state) {
        final success = state.mapOrNull(success: (value) => value);
        if (success == null) {
          return Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: 4,
              itemBuilder: (context, index) => Column(
                children: [
                  const ContractorCorrectionCardWidget(
                    correction: ContractorCorrectionModel(
                      id: 'sk-1',
                      workerId: 'w-1',
                      workerName: 'Worker Name Placeholder',
                      workerCode: 'WRK-001',
                      date: '2026-10-05',
                      requestedCheckIn: '08:00',
                      requestedCheckOut: '17:00',
                      reason: 'Reason placeholder details',
                      status: 'pending',
                      createdAt: '2026-10-05',
                    ),
                  ),
                  hSpace(12),
                ],
              ),
            ),
          );
        }
        if (success.corrections.isEmpty) {
          return Center(child: Text('common.noData'.tr()));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: success.corrections.length,
          itemBuilder: (context, index) {
            final request = success.corrections[index];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ContractorCorrectionCardWidget(correction: request),
                if (request.status.toLowerCase() == 'pending')
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            final reason =
                                await AppRejectReasonDialogWidget.show(
                                  context,
                                  title: 'سبب رفض طلب التصحيح',
                                  hintText: 'يرجى كتابة سبب رفض الطلب...',
                                  confirmLabel: 'رفض الطلب',
                                );
                            if (reason != null && context.mounted) {
                              context
                                  .read<ContractorCubit>()
                                  .updateCorrectionStatus(
                                    correctionId: request.id,
                                    status: 'reject',
                                    notes: reason,
                                  );
                            }
                          },
                          child: Text('supervisor.corrections.reject'.tr()),
                        ),
                      ),
                      wSpace(10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context
                              .read<ContractorCubit>()
                              .updateCorrectionStatus(
                                correctionId: request.id,
                                status: 'approve',
                              ),
                          child: Text('supervisor.corrections.approve'.tr()),
                        ),
                      ),
                    ],
                  ),
                hSpace(12),
              ],
            );
          },
        );
      },
    );
  }
}
