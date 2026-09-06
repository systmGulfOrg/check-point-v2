import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_create_plan_sheet_widget.dart';
import '../cubit/admin_plans_cubit.dart';
import '../cubit/admin_plans_state.dart';

class AdminPlansScreen extends StatelessWidget {
  const AdminPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.plans.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AdminPlansCubit, AdminPlansState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (messageKey) => Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Center(
                        child: Text(
                          messageKey.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    actionSuccess: (_) => const SizedBox.shrink(),
                    success: (plans) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'admin.plans.count'.tr(
                                context: context,
                                args: ['${plans.length}'],
                              ),
                              style: AppTextStyles.font12Regular,
                            ),
                            InkWell(
                              onTap: () => showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: AppColors.cardBackground,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (_) =>
                                    const SupervisorCreatePlanSheetWidget(),
                              ),
                              child: Text(
                                'admin.plans.newPlan'.tr(context: context),
                                style: AppTextStyles.font13SemiBold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hSpace(12),
                        if (plans.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: Text(
                                'admin.requests.emptyAll'.tr(context: context),
                                style: AppTextStyles.font14Regular,
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: plans.length,
                            separatorBuilder: (_, _) => hSpace(10),
                            itemBuilder: (context, index) {
                              final plan = plans[index];
                              return Container(
                                padding: EdgeInsets.all(14.r),
                                decoration: AppDecorations.card,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      plan.title ?? 'Plan',
                                      style: AppTextStyles.font16Bold,
                                    ),
                                    hSpace(4),
                                    Text(
                                      plan.description ?? '',
                                      style: AppTextStyles.font13Regular,
                                    ),
                                    hSpace(8),
                                    Text(
                                      'Duration: ${plan.startDate ?? '-'} to ${plan.endDate ?? '-'}',
                                      style: AppTextStyles.font12Regular,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
