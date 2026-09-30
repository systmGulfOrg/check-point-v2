import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../widgets/admin_assign_worker_sheet_widget.dart';
import '../widgets/admin_worker_assignment_card_widget.dart';

class AdminWorkerAssignmentsScreen extends StatefulWidget {
  const AdminWorkerAssignmentsScreen({super.key});

  @override
  State<AdminWorkerAssignmentsScreen> createState() =>
      _AdminWorkerAssignmentsScreenState();
}

class _AdminWorkerAssignmentsScreenState
    extends State<AdminWorkerAssignmentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ContractorCubit>().loadDashboardData();
  }

  void _openAssignSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ContractorCubit>(),
        child: const AdminAssignWorkerSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'admin.assignments.title'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAssignSheet,
        backgroundColor: AppColors.brandPrimary,
        icon: const Icon(
          Icons.person_add_alt_1_rounded,
          color: AppColors.white,
        ),
        label: Text(
          'admin.assignments.newAssignment'.tr(),
          style: AppTextStyles.font14Medium.copyWith(color: AppColors.white),
        ),
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final assignments =
              state.mapOrNull(success: (s) => s.assignments) ?? const [];

          if (assignments.isEmpty) {
            return Center(
              child: Text(
                'no_data'.tr(),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }

          return ListView.separated(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
            itemCount: assignments.length,
            separatorBuilder: (context, index) => hSpace(12),
            itemBuilder: (context, index) {
              final assignment = assignments[index];
              return AdminWorkerAssignmentCardWidget(assignment: assignment);
            },
          );
        },
      ),
    );
  }
}
