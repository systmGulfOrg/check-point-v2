import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../../core/widgets/animated_list_item_widget.dart';
import 'supervisor_plan_card_widget.dart';
import 'supervisor_plan_data.dart';

class SupervisorPlansListWidget extends StatelessWidget {
  const SupervisorPlansListWidget({super.key});

  static const _plans = <SupervisorPlanData>[
    SupervisorPlanData(
      titleKey: 'supervisor.plans.items.emergency.title',
      typeKey: 'supervisor.plans.type.mission',
      dateTime: '2026-09-15 09:00',
      descriptionKey: 'supervisor.plans.items.emergency.description',
      assigneeInitials: ['JM', 'PN', 'FA'],
      iconColor: AppColors.info,
      iconBackgroundColor: AppColors.softBlueBackground,
    ),
    SupervisorPlanData(
      titleKey: 'supervisor.plans.items.site.title',
      typeKey: 'supervisor.plans.type.customerVisit',
      dateTime: '2026-09-10 10:00',
      descriptionKey: 'supervisor.plans.items.site.description',
      assigneeInitials: ['JM', 'SJ'],
      iconColor: AppColors.success,
      iconBackgroundColor: AppColors.softGreenBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _plans.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) => AnimatedListItemWidget(
        index: index,
        child: SupervisorPlanCardWidget(plan: _plans[index]),
      ),
    );
  }
}
