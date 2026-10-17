import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/subscription/subscription_summary_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/subscription/admin_subscription_cubit.dart';
import 'admin_request_more_seats_sheet_widget.dart';
import 'admin_subscription_pending_request_card_widget.dart';
import 'admin_subscription_plan_card_widget.dart';

class AdminSubscriptionContentWidget extends StatelessWidget {
  const AdminSubscriptionContentWidget({required this.summary, super.key});

  final SubscriptionSummaryModel summary;

  @override
  Widget build(BuildContext context) {
    final seatLimit = summary.seatLimit;
    final usedSeats = summary.usage?.employees ?? 0;
    final pendingRequest = summary.pendingRequest;

    return RefreshIndicator(
      color: AppColors.brandPrimary,
      onRefresh: () => context.read<AdminSubscriptionCubit>().load(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        children: [
          AdminSubscriptionPlanCardWidget(
            companyName: summary.companyName,
            planName: summary.plan?.name,
            isTrial: summary.isTrial ?? false,
            trialEndsAt: summary.trialEndsAt,
            seatLimit: seatLimit,
            usedSeats: usedSeats,
          ),
          if (pendingRequest != null && pendingRequest.id != null) ...[
            hSpace(16),
            AdminSubscriptionPendingRequestCardWidget(
              requestedLimit: pendingRequest.requestedLimit,
              onCancel: () => context
                  .read<AdminSubscriptionCubit>()
                  .cancelPendingRequest(pendingRequest.id!),
            ),
          ],
          hSpace(20),
          if (pendingRequest == null)
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: 'admin.subscription.requestMoreSeats'.tr(
                  context: context,
                ),
                onTap: () => showRequestMoreSeatsSheet(
                  context,
                  currentLimit: seatLimit ?? usedSeats,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
