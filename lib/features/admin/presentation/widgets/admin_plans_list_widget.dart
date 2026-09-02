import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_plan_card_widget.dart';
import '../../../supervisor/presentation/widgets/supervisor_plan_data.dart';

class AdminPlansListWidget extends StatelessWidget {
  const AdminPlansListWidget({super.key});

  static const plans = <SupervisorPlanData>[
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
      dateTime: '2026-09-10 10:00  -  Al Futtaim Group',
      descriptionKey: 'supervisor.plans.items.site.description',
      assigneeInitials: ['JM', 'SJ'],
      iconColor: AppColors.success,
      iconBackgroundColor: AppColors.softGreenBackground,
    ),
    SupervisorPlanData(
      titleKey: 'admin.plans.items.audit.title',
      typeKey: 'admin.plans.type.siteVisit',
      dateTime: '2026-09-08 08:00  -  Emaar Properties',
      descriptionKey: 'admin.plans.items.audit.description',
      assigneeInitials: ['DC'],
      iconColor: AppColors.warningOrange,
      iconBackgroundColor: AppColors.softYellowBackground,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: plans.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (_, index) => SupervisorPlanCardWidget(plan: plans[index]),
    );
  }
}
