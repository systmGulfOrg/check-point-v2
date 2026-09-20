import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/routes/routes.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../cubit/leaves_cubit.dart';
import '../cubit/leaves_state.dart';
import 'leave_balance_summary_widget.dart';
import 'leave_policy_dialog_widget.dart';
import 'leave_request_card_widget.dart';

class LeaveProfileSheetWidget extends StatelessWidget {
  const LeaveProfileSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
            SizedBox(height: 14.h),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'leaves.profile.title'.tr(context: context),
                    style: AppTextStyles.font20Bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close_rounded, size: 22.r),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Flexible(
              child: BlocBuilder<LeavesCubit, LeavesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => SizedBox(
                      height: 180.h,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                    error: (message) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Center(
                        child: Text(
                          message.tr(context: context),
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font14Regular,
                        ),
                      ),
                    ),
                    success: (balances, _, requests) => ListView(
                      shrinkWrap: true,
                      children: [
                        LeaveBalanceSummaryWidget(balances: balances),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'leaves.profile.requests'.tr(context: context),
                                style: AppTextStyles.font16Bold,
                              ),
                            ),
                            TextButton.icon(
                              onPressed: () => showLeavePolicyDialog(context),
                              icon: Icon(Icons.policy_outlined, size: 18.r),
                              label: Text(
                                'leaves.profile.policy'.tr(context: context),
                              ),
                            ),
                          ],
                        ),
                        if (requests.isEmpty)
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 20.h),
                            child: Center(
                              child: Text(
                                'employee.leaves.empty'.tr(context: context),
                                style: AppTextStyles.font14Regular,
                              ),
                            ),
                          )
                        else
                          for (final request in requests) ...[
                            LeaveRequestCardWidget(request: request),
                            SizedBox(height: 10.h),
                          ],
                      ],
                    ),
                    holidaysLoaded: (_) => const SizedBox.shrink(),
                    submitting: () => const SizedBox.shrink(),
                    submitSuccess: () => const SizedBox.shrink(),
                    actionSuccess: (_) => const SizedBox.shrink(),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AppRoutes.leavesRequest);
                },
                icon: const Icon(Icons.add_rounded),
                label: Text('leaves.dashboard.requestLeave'.tr()),
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.brandPrimary,
                  padding: EdgeInsets.symmetric(vertical: 13.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
