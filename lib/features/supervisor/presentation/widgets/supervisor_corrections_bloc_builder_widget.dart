import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_correction_card_widget.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class SupervisorCorrectionsBlocBuilderWidget extends StatelessWidget {
  const SupervisorCorrectionsBlocBuilderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContractorCubit, ContractorState>(
      builder: (context, state) {
        final success = state.mapOrNull(success: (value) => value);
        if (success == null) {
          return const Center(child: CircularProgressIndicator());
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
                          onPressed: () => context
                              .read<ContractorCubit>()
                              .updateCorrectionStatus(
                                correctionId: request.id,
                                status: 'reject',
                              ),
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
