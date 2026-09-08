import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_plan_card_widget.dart';
import 'package:check_point_v2/features/admin/data/models/plans/admin_plan_model.dart';

class AdminPlansListWidget extends StatelessWidget {
  const AdminPlansListWidget({super.key});

  static const plans = <AdminPlanModel>[
    AdminPlanModel(
      title: 'supervisor.plans.items.emergency.title',
      startDate: '2026-09-15 09:00',
      description: 'supervisor.plans.items.emergency.description',
      assignedEmployeeName: 'JM, PN, FA',
    ),
    AdminPlanModel(
      title: 'supervisor.plans.items.site.title',
      startDate: '2026-09-10 10:00  -  Al Futtaim Group',
      description: 'supervisor.plans.items.site.description',
      assignedEmployeeName: 'JM, SJ',
    ),
    AdminPlanModel(
      title: 'admin.plans.items.audit.title',
      startDate: '2026-09-08 08:00  -  Emaar Properties',
      description: 'admin.plans.items.audit.description',
      assignedEmployeeName: 'DC',
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
