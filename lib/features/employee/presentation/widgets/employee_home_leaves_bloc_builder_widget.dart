import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_balance_model.dart';
import 'package:check_point_v2/features/leaves/data/models/leave_request_model.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_cubit.dart';
import 'package:check_point_v2/features/leaves/presentation/cubit/leaves_state.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_balances_list_widget.dart';
import 'package:check_point_v2/features/leaves/presentation/widgets/leave_request_card_widget.dart';
import 'employee_empty_leaves_card_widget.dart';

class EmployeeHomeLeavesBlocBuilderWidget extends StatelessWidget {
  const EmployeeHomeLeavesBlocBuilderWidget({
    required this.onViewAllLeaves,
    required this.onRequestLeave,
    super.key,
  });

  final VoidCallback onViewAllLeaves;
  final VoidCallback onRequestLeave;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeavesCubit, LeavesState>(
      builder: (context, state) {
        final (balances, requests, isLoading) = state.maybeWhen(
          success: (balances, types, requests) => (balances, requests, false),
          loading: () =>
              (const <LeaveBalanceModel>[], const <LeaveRequestModel>[], true),
          orElse: () =>
              (const <LeaveBalanceModel>[], const <LeaveRequestModel>[], false),
        );

        if (isLoading) {
          return Skeletonizer(
            enabled: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'employee.home.leaveBalances'.tr(context: context),
                  style: AppTextStyles.font16Bold,
                ),
                hSpace(12),
                Container(
                  height: 120.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
              ],
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (balances.isNotEmpty) ...[
              Text(
                'employee.home.leaveBalances'.tr(context: context),
                style: AppTextStyles.font16Bold,
              ),
              hSpace(10),
              LeaveBalancesListWidget(balances: balances),
              hSpace(20),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'employee.home.recentLeaves'.tr(context: context),
                  style: AppTextStyles.font16Bold,
                ),
                if (requests.isNotEmpty)
                  GestureDetector(
                    onTap: onViewAllLeaves,
                    child: Text(
                      'employee.home.viewAll'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
              ],
            ),
            hSpace(12),
            if (requests.isEmpty)
              EmployeeEmptyLeavesCardWidget(onRequestLeave: onRequestLeave)
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: requests.take(3).length,
                separatorBuilder: (_, _) => hSpace(10),
                itemBuilder: (context, index) {
                  return LeaveRequestCardWidget(request: requests[index]);
                },
              ),
          ],
        );
      },
    );
  }
}
