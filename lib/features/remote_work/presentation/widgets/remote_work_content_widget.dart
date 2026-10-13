import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/models/remote_work_request_model.dart';
import '../cubit/remote_work_cubit.dart';
import 'remote_work_action_button_widget.dart';
import 'remote_work_policy_card_widget.dart';
import 'remote_work_policy_sheet_widget.dart';
import 'remote_work_request_sheet_widget.dart';
import 'remote_work_request_card_widget.dart';
import 'remote_work_section_title_widget.dart';

class RemoteWorkContentWidget extends StatelessWidget {
  const RemoteWorkContentWidget({
    required this.isAdmin,
    required this.canReview,
    required this.canRequest,
    this.currentEmployeeId,
    this.assignedPolicyId,
    required this.policies,
    required this.requests,
    required this.policyType,
    super.key,
  });

  final bool isAdmin;
  final bool canReview;
  final bool canRequest;
  final String? currentEmployeeId;
  final String? assignedPolicyId;
  final List<RemoteWorkPolicyModel> policies;
  final List<RemoteWorkRequestModel> requests;
  final String policyType;

  @override
  Widget build(BuildContext context) {
    final visiblePolicies = policies
        .where(
          (policy) =>
              policy.effectivePolicyType == policyType &&
              (assignedPolicyId == null || policy.id == assignedPolicyId),
        )
        .toList();

    final titleKey = switch (policyType) {
      'onsite' => 'remoteWork.onsitePolicies',
      'hybrid' => 'remoteWork.hybridPolicies',
      _ => 'remoteWork.policies',
    };

    final addLabelKey = switch (policyType) {
      'onsite' => 'remoteWork.addOnsitePolicy',
      'hybrid' => 'remoteWork.addHybridPolicy',
      _ => 'remoteWork.addPolicy',
    };

    return RefreshIndicator(
      onRefresh: context.read<RemoteWorkCubit>().load,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RemoteWorkSectionTitleWidget(title: titleKey.tr()),
              if (isAdmin)
                RemoteWorkActionButtonWidget(
                  label: addLabelKey.tr(),
                  icon: Icons.add_rounded,
                  onTap: () => _showPolicyDialog(context),
                ),
            ],
          ),
          if (canRequest && policyType == 'hybrid') ...[
            hSpace(12),
            RemoteWorkActionButtonWidget(
              label: canReview
                  ? 'remoteWork.requestLocation'.tr(context: context)
                  : 'remoteWork.requestToSupervisor'.tr(context: context),
              icon: Icons.swap_horiz_rounded,
              onTap: () => _showRequestDialog(context),
            ),
          ],
          if (canRequest && policyType == 'hybrid' && requests.isNotEmpty) ...[
            hSpace(16),
            RemoteWorkSectionTitleWidget(
              title: 'remoteWork.myRequests'.tr(context: context),
            ),
            ...requests.map(
              (request) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.schedule_outlined, size: 20.r),
                title: Text(
                  request.requestDate.split('T').first,
                  style: AppTextStyles.font13SemiBold,
                ),
                subtitle: Text(
                  request.targetWorkSystem == 'onsite'
                      ? 'remoteWork.onsiteTab'.tr(context: context)
                      : 'remoteWork.remoteTab'.tr(context: context),
                ),
                trailing: Text(
                  'remoteWork.status.${request.status.toLowerCase()}'.tr(
                    context: context,
                  ),
                  style: AppTextStyles.font12Medium,
                ),
              ),
            ),
          ],
          if (canReview && policyType == 'hybrid') ...[
            hSpace(16),
            RemoteWorkSectionTitleWidget(
              title: 'remoteWork.requestsForReview'.tr(context: context),
            ),
            if (requests.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 18.h),
                child: Text(
                  'remoteWork.noRequests'.tr(context: context),
                  style: AppTextStyles.font13Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              )
            else
              ...requests.map(
                (request) => RemoteWorkRequestCardWidget(
                  request: request,
                  canReview: canReview,
                  isOwnRequest: request.employeeId == currentEmployeeId,
                  onApprove: () => context.read<RemoteWorkCubit>().updateStatus(
                    id: request.id,
                    status: 'Approved',
                  ),
                  onReject: () => context.read<RemoteWorkCubit>().updateStatus(
                    id: request.id,
                    status: 'Rejected',
                  ),
                ),
              ),
          ],
          if (visiblePolicies.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Center(
                child: Text(
                  'remoteWork.noPolicies'.tr(context: context),
                  style: AppTextStyles.font14Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            )
          else
            ...visiblePolicies.asMap().entries.map(
              (entry) => AnimatedListItemWidget(
                index: entry.key,
                child: RemoteWorkPolicyCardWidget(
                  policy: entry.value,
                  isAdmin: isAdmin,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showRequestDialog(BuildContext context) async {
    final cubit = context.read<RemoteWorkCubit>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: RemoteWorkRequestSheetWidget(
          policies: policies,
          onSubmit: cubit.createRequest,
        ),
      ),
    );
  }

  Future<void> _showPolicyDialog(BuildContext context) async {
    final cubit = context.read<RemoteWorkCubit>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: RemoteWorkPolicySheetWidget(initialPolicyType: policyType),
      ),
    );
  }
}
