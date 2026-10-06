import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/models/remote_work_request_model.dart';
import '../cubit/remote_work_cubit.dart';
import '../cubit/remote_work_state.dart';
import 'remote_work_policy_employees_sheet_widget.dart';
import 'remote_work_policy_sheet_widget.dart';

class RemoteWorkBlocBuilderWidget extends StatelessWidget {
  const RemoteWorkBlocBuilderWidget({
    required this.isAdmin,
    required this.canReview,
    required this.policyType,
    super.key,
  });
  final bool isAdmin;
  final bool canReview;
  final String policyType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteWorkCubit, RemoteWorkState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => Skeletonizer(
          enabled: true,
          child: _RemoteWorkContent(
            isAdmin: isAdmin,
            canReview: canReview,
            policyType: policyType,
            policies: const [
              RemoteWorkPolicyModel(
                id: '1',
                name: 'Loading Policy Name 1',
                allowedDays: ['Sunday', 'Monday', 'Tuesday'],
                onsiteDays: ['Wednesday', 'Thursday'],
                workingHoursStart: '09:00',
                workingHoursEnd: '17:00',
                allowedDelayTime: 15,
                employeeCount: 3,
              ),
              RemoteWorkPolicyModel(
                id: '2',
                name: 'Loading Policy Name 2',
                allowedDays: ['Sunday', 'Monday', 'Tuesday'],
                onsiteDays: ['Wednesday', 'Thursday'],
                workingHoursStart: '09:00',
                workingHoursEnd: '17:00',
                allowedDelayTime: 15,
                employeeCount: 5,
              ),
            ],
            requests: const [],
          ),
        ),
        error: (messageKey) => Center(child: Text(messageKey.tr())),
        success: (policies, requests) => _RemoteWorkContent(
          isAdmin: isAdmin,
          canReview: canReview,
          policyType: policyType,
          policies: policies,
          requests: requests,
        ),
      ),
    );
  }
}

class _RemoteWorkContent extends StatelessWidget {
  const _RemoteWorkContent({
    required this.isAdmin,
    required this.canReview,
    required this.policies,
    required this.requests,
    required this.policyType,
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
              _SectionTitle(title: titleKey.tr()),
              if (isAdmin)
                _ActionButton(
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
                child: _PolicyCard(policy: entry.value, isAdmin: isAdmin),
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

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) =>
      Text(title, style: AppTextStyles.font16Bold);
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8.r),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.r, color: AppColors.brandPrimary),
          SizedBox(width: 3.w),
          Text(
            label,
            style: AppTextStyles.font13SemiBold.copyWith(
              color: AppColors.brandPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}

class _PolicyCard extends StatelessWidget {
  const _PolicyCard({required this.policy, required this.isAdmin});

  final RemoteWorkPolicyModel policy;
  final bool isAdmin;

  void _showEditPolicyDialog(BuildContext context) {
    final cubit = context.read<RemoteWorkCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: RemoteWorkPolicySheetWidget(
          initialPolicyType: policy.effectivePolicyType,
          existingPolicy: policy,
        ),
      ),
    );
  }

  void _showDeletePolicyDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'remoteWork.deletePolicyTitle'.tr(context: context),
        message: 'remoteWork.deletePolicyMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<RemoteWorkCubit>().deactivatePolicy(policy.id);
        },
      ),
    );
  }

  void _showEmployeesSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => RemoteWorkPolicyEmployeesSheetWidget(policy: policy),
    );
  }

  @override
  Widget build(BuildContext context) {
    final type = policy.effectivePolicyType;
    final isHybrid = type == 'hybrid';
    final isOnsite = type == 'onsite';

    String dayLabel(String value) => switch (value.toLowerCase()) {
      'sun' || 'sunday' => 'admin.shifts.days.sun'.tr(context: context),
      'mon' || 'monday' => 'admin.shifts.days.mon'.tr(context: context),
      'tue' || 'tuesday' => 'admin.shifts.days.tue'.tr(context: context),
      'wed' || 'wednesday' => 'admin.shifts.days.wed'.tr(context: context),
      'thu' || 'thursday' => 'admin.shifts.days.thu'.tr(context: context),
      'fri' || 'friday' => 'admin.shifts.days.fri'.tr(context: context),
      'sat' || 'saturday' => 'admin.shifts.days.sat'.tr(context: context),
      _ => value,
    };

    final remoteDays = policy.allowedDays.map(dayLabel).join('، ');
    final onsiteDays = policy.onsiteDays.map(dayLabel).join('، ');

    final icon = isOnsite
        ? Icons.business_rounded
        : (isHybrid ? Icons.swap_horiz_rounded : Icons.home_work_outlined);

    final iconBg = isOnsite
        ? AppColors.softBrandBackground
        : (isHybrid
              ? AppColors.softBlueBackground
              : AppColors.softBrandBackground);

    final iconColor = isOnsite
        ? AppColors.brandPrimary
        : (isHybrid ? AppColors.info : AppColors.brandPrimary);

    return AppCardContainerWidget(
      margin: EdgeInsets.only(top: 10.h),
      backgroundColor: AppColors.cardBackground,
      child: Padding(
        padding: EdgeInsets.all(14.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 42.r,
                  height: 42.r,
                  decoration: BoxDecoration(
                    color: iconBg,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: iconColor, size: 22.r),
                ),
                wSpace(12),
                Expanded(
                  child: Text(policy.name, style: AppTextStyles.font14SemiBold),
                ),
                Text(
                  policy.isActive
                      ? 'remoteWork.active'.tr(context: context)
                      : 'remoteWork.inactive'.tr(context: context),
                  style: AppTextStyles.font12Medium.copyWith(
                    color: policy.isActive
                        ? AppColors.success
                        : AppColors.placeholder,
                  ),
                ),
              ],
            ),
            hSpace(12),
            if (!isOnsite && remoteDays.isNotEmpty) ...[
              Text(
                '${'remoteWork.remoteDays'.tr(context: context)}: $remoteDays',
                style: AppTextStyles.font12Regular,
              ),
              hSpace(4),
            ],
            if ((isHybrid || isOnsite) && onsiteDays.isNotEmpty) ...[
              Text(
                '${'remoteWork.onsiteDays'.tr(context: context)}: $onsiteDays',
                style: AppTextStyles.font12Regular,
              ),
              hSpace(4),
            ],
            Text(
              '${policy.workingHoursStart ?? '--'} - ${policy.workingHoursEnd ?? '--'}  •  ${'remoteWork.gracePeriod'.tr(context: context)}: ${policy.allowedDelayTime ?? 0}',
              style: AppTextStyles.font12Regular,
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _showEmployeesSheet(context),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.people_alt_outlined,
                          size: 16.r,
                          color: AppColors.brandPrimary,
                        ),
                        wSpace(6),
                        Text(
                          'remoteWork.viewEmployeesCount'.tr(
                            context: context,
                            args: ['${policy.employeeCount}'],
                          ),
                          style: AppTextStyles.font12Medium.copyWith(
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isAdmin)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => _showEditPolicyDialog(context),
                        icon: Icon(
                          Icons.edit_outlined,
                          size: 20.r,
                          color: AppColors.brandPrimary,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      IconButton(
                        onPressed: () => _showDeletePolicyDialog(context),
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          size: 20.r,
                          color: AppColors.error,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
