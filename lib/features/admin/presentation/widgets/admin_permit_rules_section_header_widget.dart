import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';

class AdminPermitRulesSectionHeaderWidget extends StatelessWidget {
  const AdminPermitRulesSectionHeaderWidget({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.font13SemiBold.copyWith(
        color: AppColors.textPrimary,
      ),
    );
  }
}
