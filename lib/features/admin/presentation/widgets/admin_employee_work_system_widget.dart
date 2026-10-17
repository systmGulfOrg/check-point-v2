import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/remote_work/data/models/remote_work_policy_model.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_cubit.dart';
import 'package:check_point_v2/features/remote_work/presentation/cubit/remote_work_state.dart';

class AdminEmployeeWorkSystemWidget extends StatelessWidget {
  const AdminEmployeeWorkSystemWidget({
    required this.selectedSystem,
    required this.selectedPolicyId,
    required this.onSystemChanged,
    required this.onPolicyChanged,
    super.key,
  });

  final String selectedSystem;
  final String? selectedPolicyId;
  final ValueChanged<String> onSystemChanged;
  final ValueChanged<String?> onPolicyChanged;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteWorkCubit, RemoteWorkState>(
      builder: (context, state) {
        final policies = state.maybeWhen(
          success: (items, _) => items,
          orElse: () => const <RemoteWorkPolicyModel>[],
        );
        final systemPolicies = policies
            .where((policy) => policy.effectivePolicyType == selectedSystem)
            .toList();
        final hasSelectedPolicy = systemPolicies.any(
          (policy) => policy.id == selectedPolicyId,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'admin.employeeWizard.workSystem'.tr(context: context),
              style: AppTextStyles.font13SemiBold,
            ),
            hSpace(8),
            DropdownButtonFormField<String>(
              key: ValueKey('work_system_$selectedSystem'),
              initialValue: selectedSystem,
              isExpanded: true,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.fieldBackground,
                hintText: 'admin.employeeWizard.workSystem'.tr(
                  context: context,
                ),
              ),
              items: [
                DropdownMenuItem(
                  value: 'onsite',
                  child: Text(
                    'admin.employeeWizard.workSystemOnsite'.tr(
                      context: context,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 'remote',
                  child: Text('remoteWork.remotePolicy'.tr(context: context)),
                ),
                DropdownMenuItem(
                  value: 'hybrid',
                  child: Text('remoteWork.hybridPolicy'.tr(context: context)),
                ),
              ],
              onChanged: (value) {
                if (value != null) onSystemChanged(value);
              },
            ),
            hSpace(12),
            Text(
              'admin.employeeWizard.workPolicy'.tr(context: context),
              style: AppTextStyles.font13SemiBold,
            ),
            hSpace(8),
            DropdownButtonFormField<String>(
              key: ValueKey(
                'work_policy_${selectedSystem}_${hasSelectedPolicy ? selectedPolicyId : 'none'}',
              ),
              initialValue: hasSelectedPolicy ? selectedPolicyId : null,
              isExpanded: true,
              hint: Text(
                systemPolicies.isEmpty
                    ? 'admin.employeeWizard.noWorkPolicies'.tr(context: context)
                    : 'admin.employeeWizard.selectWorkPolicy'.tr(
                        context: context,
                      ),
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.fieldBackground,
                prefixIcon: Icon(
                  selectedSystem == 'hybrid'
                      ? Icons.swap_horiz_rounded
                      : selectedSystem == 'onsite'
                      ? Icons.business_rounded
                      : Icons.home_work_outlined,
                  color: systemPolicies.isEmpty
                      ? AppColors.placeholder
                      : AppColors.info,
                  size: 20.r,
                ),
              ),
              items: systemPolicies
                  .map(
                    (policy) => DropdownMenuItem<String>(
                      value: policy.id,
                      child: Text(policy.name),
                    ),
                  )
                  .toList(),
              onChanged: systemPolicies.isEmpty ? null : onPolicyChanged,
            ),
            if (systemPolicies.isEmpty) ...[
              hSpace(4),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 4.w),
                child: Text(
                  'admin.employeeWizard.noWorkPolicies'.tr(context: context),
                  style: AppTextStyles.font11Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
