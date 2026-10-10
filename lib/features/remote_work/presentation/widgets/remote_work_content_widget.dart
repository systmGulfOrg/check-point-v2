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
import 'remote_work_section_title_widget.dart';

class RemoteWorkContentWidget extends StatelessWidget {
  const RemoteWorkContentWidget({
    required this.isAdmin,
    required this.canReview,
    required this.policies,
    required this.requests,
    required this.policyType,
    super.key,
  });

  final bool isAdmin;
  final bool canReview;
  final List<RemoteWorkPolicyModel> policies;
  final List<RemoteWorkRequestModel> requests;
  final String policyType;

  @override
  Widget build(BuildContext context) {
    final visiblePolicies = policies
        .where((policy) => policy.effectivePolicyType == policyType)
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
