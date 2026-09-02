import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_team_member_card_widget.dart';

class SupervisorTeamScreen extends StatelessWidget {
  const SupervisorTeamScreen({super.key});

  static const _members = [
    (
      initials: 'JM',
      name: 'James Martinez',
      email: 'james.martinez@checkpoint.app',
      employeeCode: 'EMP-2024-0087',
      departmentKey: 'supervisor.team.department.operations',
    ),
    (
      initials: 'PN',
      name: 'Priya Nair',
      email: 'priya.nair@checkpoint.app',
      employeeCode: 'EMP-2024-0091',
      departmentKey: 'supervisor.team.department.informationTechnology',
    ),
    (
      initials: 'DC',
      name: 'David Chen',
      email: 'david.chen@checkpoint.app',
      employeeCode: 'EMP-2024-0104',
      departmentKey: 'supervisor.team.department.finance',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'supervisor.team.title'.tr(context: context),
                style: AppTextStyles.font20Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(16),
              Text(
                'supervisor.team.count'.tr(
                  context: context,
                  args: ['${_members.length}'],
                ),
                style: AppTextStyles.font13Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              hSpace(16),
              Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(bottom: 24.h),
                  itemCount: _members.length,
                  separatorBuilder: (_, _) => hSpace(10),
                  itemBuilder: (context, index) {
                    final member = _members[index];
                    return SupervisorTeamMemberCardWidget(
                      initials: member.initials,
                      name: member.name,
                      roleKey: 'auth.role.employee',
                      email: member.email,
                      employeeCode: member.employeeCode,
                      departmentKey: member.departmentKey,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
