import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/employee_work_access_cubit.dart';
import '../cubit/employee_work_access_state.dart';
import '../cubit/remote_work_cubit.dart';
import 'remote_work_tabs_widget.dart';

class RemoteWorkAccessGateWidget extends StatelessWidget {
  const RemoteWorkAccessGateWidget({
    required this.isAdmin,
    required this.canReview,
    required this.canRequest,
    this.currentEmployeeId,
    super.key,
  });

  final bool isAdmin;
  final bool canReview;
  final bool canRequest;
  final String? currentEmployeeId;

  @override
  Widget build(BuildContext context) {
    final availablePolicyTypes = context
        .watch<RemoteWorkCubit>()
        .state
        .maybeWhen(
          success: (policies, _) =>
              policies.map((policy) => policy.effectivePolicyType).toSet(),
          orElse: () => null,
        );

    if (isAdmin) {
      return RemoteWorkTabsWidget(
        isAdmin: isAdmin,
        canReview: canReview,
        canRequest: canRequest,
        currentEmployeeId: currentEmployeeId,
        availablePolicyTypes: null,
        showOnsite: true,
        showRemote: true,
        showHybrid: true,
      );
    }

    return BlocBuilder<EmployeeWorkAccessCubit, EmployeeWorkAccessState>(
      builder: (context, state) => switch (state) {
        EmployeeWorkAccessInitial() ||
        EmployeeWorkAccessLoading() => Skeletonizer(
          enabled: true,
          child: RemoteWorkTabsWidget(
            isAdmin: isAdmin,
            canReview: canReview,
            canRequest: canRequest,
            currentEmployeeId: currentEmployeeId,
            assignedPolicyId: null,
            availablePolicyTypes: availablePolicyTypes,
            showOnsite: true,
            showRemote: true,
            showHybrid: false,
          ),
        ),
        EmployeeWorkAccessAllowed(:final workSystem, :final policyId) =>
          RemoteWorkTabsWidget(
            isAdmin: isAdmin,
            canReview: canReview,
            canRequest: canRequest,
            currentEmployeeId: currentEmployeeId,
            assignedPolicyId: policyId,
            availablePolicyTypes: availablePolicyTypes,
            showOnsite: workSystem == 'onsite',
            showRemote: workSystem == 'remote',
            showHybrid: workSystem == 'hybrid',
          ),
        EmployeeWorkAccessDenied(:final messageKey) => Center(
          child: AppMessageWidget(
            messageKey: messageKey,
            icon: Icons.lock_outline_rounded,
            iconBackgroundColor: AppColors.softYellowBackground,
            iconColor: AppColors.warningOrange,
          ),
        ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
