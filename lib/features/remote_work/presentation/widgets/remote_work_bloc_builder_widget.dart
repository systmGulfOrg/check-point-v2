import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/models/remote_work_request_model.dart';
import '../cubit/remote_work_cubit.dart';
import '../cubit/remote_work_state.dart';
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
        loading: () => const Center(child: CircularProgressIndicator()),
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
    return RefreshIndicator(
      onRefresh: context.read<RemoteWorkCubit>().load,
      child: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SectionTitle(
                title: policyType == 'hybrid'
                    ? 'remoteWork.hybridPolicies'.tr()
                    : 'remoteWork.policies'.tr(),
              ),
              if (isAdmin)
                _ActionButton(
                  label: policyType == 'hybrid'
                      ? 'remoteWork.addHybridPolicy'.tr()
                      : 'remoteWork.addPolicy'.tr(),
                  icon: Icons.add_rounded,
                  onTap: () => _showPolicyDialog(context),
                ),
            ],
          ),
          ...visiblePolicies.asMap().entries.map(
            (entry) => AnimatedListItemWidget(
              index: entry.key,
              child: _PolicyCard(policy: entry.value),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: unused_element, kept for the request API compatibility layer.
  Future<void> _showRequestDialog(
    BuildContext context,
    List<RemoteWorkPolicyModel> policies,
  ) async {
    final reasonController = TextEditingController();
    DateTime selectedDate = DateTime.now();
    String? policyId = policies.where((p) => p.isActive).firstOrNull?.id;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('remoteWork.requestTitle'.tr()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text('remoteWork.date'.tr()),
                subtitle: Text(selectedDate.toIso8601String().split('T').first),
                trailing: const Icon(Icons.calendar_today_outlined),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 90)),
                    initialDate: selectedDate,
                  );
                  if (picked != null) setState(() => selectedDate = picked);
                },
              ),
              if (policies.isNotEmpty)
                DropdownButtonFormField<String>(
                  initialValue: policyId,
                  items: policies
                      .where((p) => p.isActive)
                      .map(
                        (p) =>
                            DropdownMenuItem(value: p.id, child: Text(p.name)),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => policyId = value),
                  decoration: InputDecoration(
                    labelText: 'remoteWork.policy'.tr(),
                  ),
                ),
              SizedBox(height: 12.h),
              CustomTextFormField(
                controller: reasonController,
                hintText: 'remoteWork.reason'.tr(),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text('common.cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(dialogContext);
                await context.read<RemoteWorkCubit>().createRequest(
                  requestDate: selectedDate.toIso8601String(),
                  policyId: policyId,
                  reason: reasonController.text.trim(),
                );
              },
              child: Text('remoteWork.submit'.tr()),
            ),
          ],
        ),
      ),
    );
    reasonController.dispose();
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
  const _PolicyCard({required this.policy});
  final RemoteWorkPolicyModel policy;
  @override
  Widget build(BuildContext context) {
    final isHybrid = policy.effectivePolicyType == 'hybrid';
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
                    color: isHybrid
                        ? AppColors.softBlueBackground
                        : AppColors.softBrandBackground,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    isHybrid
                        ? Icons.swap_horiz_rounded
                        : Icons.home_work_outlined,
                    color: isHybrid ? AppColors.info : AppColors.brandPrimary,
                    size: 22.r,
                  ),
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
            Text(
              '${'remoteWork.remoteDays'.tr(context: context)}: $remoteDays',
              style: AppTextStyles.font12Regular,
            ),
            if (isHybrid && onsiteDays.isNotEmpty) ...[
              hSpace(4),
              Text(
                '${'remoteWork.onsiteDays'.tr(context: context)}: $onsiteDays',
                style: AppTextStyles.font12Regular,
              ),
            ],
            hSpace(4),
            Text(
              '${policy.workingHoursStart ?? '--'} - ${policy.workingHoursEnd ?? '--'}  •  ${'remoteWork.gracePeriod'.tr(context: context)}: ${policy.allowedDelayTime ?? 0}',
              style: AppTextStyles.font12Regular,
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: unused_element, kept for existing request data compatibility.
class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request, required this.canReview});
  final RemoteWorkRequestModel request;
  final bool canReview;
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(
        Icons.laptop_mac_rounded,
        color: request.status == 'Approved'
            ? AppColors.success
            : AppColors.warning,
      ),
      title: Text(request.employeeName ?? 'remoteWork.myRequest'.tr()),
      subtitle: Text(
        '${request.requestDate.split('T').first}\n${request.reason ?? ''}',
      ),
      isThreeLine: true,
      trailing: canReview && request.status == 'Pending'
          ? Wrap(
              children: [
                IconButton(
                  onPressed: () => context.read<RemoteWorkCubit>().updateStatus(
                    id: request.id,
                    status: 'Approved',
                  ),
                  icon: const Icon(Icons.check, color: AppColors.success),
                ),
                IconButton(
                  onPressed: () => context.read<RemoteWorkCubit>().updateStatus(
                    id: request.id,
                    status: 'Rejected',
                  ),
                  icon: const Icon(Icons.close, color: AppColors.error),
                ),
              ],
            )
          : Text(request.status),
    ),
  );
}
