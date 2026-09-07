import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/admin_plan_model.dart';
import 'supervisor_plan_card_widget.dart';

class SupervisorPlansListWidget extends StatelessWidget {
  const SupervisorPlansListWidget({
    required this.plans,
    super.key,
    this.onDelete,
  });

  final List<AdminPlanModel> plans;
  final ValueChanged<AdminPlanModel>? onDelete;

  @override
  Widget build(BuildContext context) {
    if (plans.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 36.h),
          child: Text(
            'supervisor.plans.empty'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) {
        final plan = plans[index];
        return AnimatedListItemWidget(
          index: index,
          child: SupervisorPlanCardWidget(
            plan: plan,
            onDelete: onDelete != null ? () => onDelete!(plan) : null,
          ),
        );
      },
    );
  }
}
