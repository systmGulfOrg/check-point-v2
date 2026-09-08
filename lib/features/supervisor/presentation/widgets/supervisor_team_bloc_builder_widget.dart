import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_cubit.dart';
import 'package:check_point_v2/features/supervisor/presentation/cubit/team/supervisor_team_state.dart';
import 'supervisor_team_list_widget.dart';
import 'supervisor_team_member_card_widget.dart';

class SupervisorTeamBlocBuilderWidget extends StatelessWidget {
  const SupervisorTeamBlocBuilderWidget({required this.searchQuery, super.key});

  final String searchQuery;

  static const _dummyEmployees = [
    EmployeeModel(
      name: 'Loading Employee Full Name',
      role: 'Employee',
      userName: 'EMP-2024-001',
      departmentName: 'Operations Department',
    ),
    EmployeeModel(
      name: 'Loading Another Employee Name',
      role: 'Employee',
      userName: 'EMP-2024-002',
      departmentName: 'Information Technology',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SupervisorTeamCubit, SupervisorTeamState>(
      builder: (context, state) {
        return switch (state) {
          SupervisorTeamLoading() => Skeletonizer(
            enabled: true,
            child: ListView.separated(
              padding: EdgeInsets.only(bottom: 24.h),
              itemCount: _dummyEmployees.length,
              separatorBuilder: (_, _) => hSpace(10),
              itemBuilder: (context, index) => SupervisorTeamMemberCardWidget(
                employee: _dummyEmployees[index],
              ),
            ),
          ),
          SupervisorTeamSuccess(:final members) => SupervisorTeamListWidget(
            team: members,
            searchQuery: searchQuery,
          ),
          SupervisorTeamError(:final messageKey) => Center(
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }
}
