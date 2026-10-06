import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_correction_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_correction_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_new_request_sheet_widget.dart';

class ContractorRequestsScreen extends StatefulWidget {
  const ContractorRequestsScreen({super.key});

  @override
  State<ContractorRequestsScreen> createState() =>
      _ContractorRequestsScreenState();
}

class _ContractorRequestsScreenState extends State<ContractorRequestsScreen> {
  void _openNewRequestSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final attendance =
              state.mapOrNull(success: (value) => value.attendanceLogs) ??
              const [];
          return ContractorNewRequestSheetWidget(
            attendance: attendance,
            onSubmit: (body) async {
              final succeeded = await context
                  .read<ContractorCubit>()
                  .submitCorrectionRequest(body);
              if (succeeded && context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('contractor.requests.pending'.tr()),
                    backgroundColor: AppColors.info,
                  ),
                );
              }
              return succeeded;
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'contractor.requests.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'contractor.requests.title'.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: () => _openNewRequestSheet(context),
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 16.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(4),
                            Text(
                              'contractor.requests.newRequest'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(14),
                BlocBuilder<ContractorCubit, ContractorState>(
                  builder: (context, state) {
                    final isLoading = state.maybeMap(
                      loading: (_) => true,
                      initial: (_) => true,
                      orElse: () => false,
                    );

                    if (isLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 3,
                          separatorBuilder: (_, _) => hSpace(12),
                          itemBuilder: (_, index) =>
                              const ContractorCorrectionCardWidget(
                            correction: ContractorCorrectionModel(
                              id: 'sk-correction-id',
                              workerId: 'sk-w',
                              workerName: 'Loading Worker Name...',
                              workerCode: 'WRK-001',
                              date: '2026-01-01',
                              requestedCheckIn: '08:00',
                              requestedCheckOut: '17:00',
                              reason: 'Loading reason details...',
                              status: 'pending',
                              createdAt: '2026-01-01',
                            ),
                          ),
                        ),
                      );
                    }

                    final requests = state.mapOrNull(
                          success: (value) => value.corrections,
                        ) ??
                        const [];

                    if (requests.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'no_data'.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: requests.length,
                      separatorBuilder: (context, index) => hSpace(12),
                      itemBuilder: (context, index) {
                        final item = requests[index];
                        return ContractorCorrectionCardWidget(correction: item);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
