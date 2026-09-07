import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../admin/data/models/employee_model.dart';
import 'supervisor_team_member_card_widget.dart';

class SupervisorTeamListWidget extends StatelessWidget {
  const SupervisorTeamListWidget({
    required this.team,
    required this.searchQuery,
    super.key,
  });

  final List<EmployeeModel> team;
  final String searchQuery;

  @override
  Widget build(BuildContext context) {
    final filtered = searchQuery.isEmpty
        ? team
        : team.where((e) {
            final q = searchQuery.toLowerCase();
            final name = (e.name ?? '').toLowerCase();
            final code = (e.userName ?? '').toLowerCase();
            final dept = (e.departmentName ?? '').toLowerCase();
            return name.contains(q) || code.contains(q) || dept.contains(q);
          }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: Text(
            'supervisor.team.empty'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.only(bottom: 24.h),
      itemCount: filtered.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) => AnimatedListItemWidget(
        index: index,
        child: SupervisorTeamMemberCardWidget(employee: filtered[index]),
      ),
    );
  }
}
