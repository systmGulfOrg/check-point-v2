import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';

class SupervisorSiteRollCallCardWidget extends StatelessWidget {
  const SupervisorSiteRollCallCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isContractor = context.select<AuthProfileCubit, bool>(
      (cubit) => switch (cubit.state) {
        AuthProfileSuccess(:final isContractorWorker) => isContractorWorker,
        _ => false,
      },
    );

    if (!isContractor) return const SizedBox.shrink();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.brandPrimary.withValues(alpha: 0.08),
            AppColors.cardBackground,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.brandPrimary.withValues(alpha: 0.25),
        ),
      ),
      child: InkWell(
        onTap: () =>
            Navigator.pushNamed(context, AppRoutes.supervisorWorkerRollCall),
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                      color: AppColors.brandPrimary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.engineering_rounded,
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  vSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'contractorWorker.rollCall.title'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font16Bold.copyWith(
                            color: AppColors.textPrimary,
                          ),
                        ),
                        hSpace(4),
                        Text(
                          'contractorWorker.rollCall.subtitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors.brandPrimary,
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
