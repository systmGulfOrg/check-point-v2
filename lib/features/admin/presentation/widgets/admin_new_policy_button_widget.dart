import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'admin_new_policy_sheet_widget.dart';

class AdminNewPolicyButtonWidget extends StatelessWidget {
  const AdminNewPolicyButtonWidget({super.key, this.labelKey, this.shiftId});

  final String? labelKey;
  final int? shiftId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final cubit = context.read<AdminShiftsPoliciesCubit>();
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.cardBackground,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: AdminNewPolicySheetWidget(shiftId: shiftId),
          ),
        );
      },
      child: Text(
        (labelKey ?? 'admin.shifts.policies.newPolicy').tr(context: context),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
