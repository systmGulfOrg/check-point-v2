import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_new_policy_sheet_widget.dart';

class AdminNewPolicyButtonWidget extends StatelessWidget {
  const AdminNewPolicyButtonWidget({super.key, this.labelKey});

  final String? labelKey;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.cardBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => const AdminNewPolicySheetWidget(),
      ),
      child: Text(
        (labelKey ?? 'admin.shifts.policies.newPolicy').tr(context: context),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
