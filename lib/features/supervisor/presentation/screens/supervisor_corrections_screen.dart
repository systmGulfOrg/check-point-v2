import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_correction_card_widget.dart';

class SupervisorCorrectionsScreen extends StatelessWidget {
  const SupervisorCorrectionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        'supervisor.corrections.title'.tr(),
        style: AppTextStyles.font16Bold.copyWith(color: AppColors.textPrimary),
      ),
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
    ),
    body: BlocBuilder<ContractorCubit, ContractorState>(
      builder: (context, state) {
        final success = state.mapOrNull(success: (value) => value);
        if (success == null) {
          return const Center(child: CircularProgressIndicator());
        }
        final requests = success.corrections;
        if (requests.isEmpty) {
          return Center(child: Text('common.noData'.tr()));
        }
        return ListView.builder(
          padding: EdgeInsets.all(16.w),
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final request = requests[index];
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
                      SizedBox(width: 10.w),
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
                SizedBox(height: 12.h),
              ],
            );
          },
        );
      },
    ),
  );
}
