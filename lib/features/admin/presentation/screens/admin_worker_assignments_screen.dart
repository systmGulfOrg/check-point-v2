import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/worker_site_assignment_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../widgets/admin_assign_worker_sheet_widget.dart';

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
              return _AssignmentCard(assignment: assignment);
            },
          );
        },
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  const _AssignmentCard({required this.assignment});

  final WorkerSiteAssignmentModel assignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      assignment.workerName,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    hSpace(2),
                    Text(
                      assignment.contractorName ?? '',
                      style: AppTextStyles.font13Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.softGreenBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'admin.assignments.active'.tr(),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.success,
                  ),
                ),
              ),
            ],
          ),
          hSpace(12),
          const Divider(height: 1, color: AppColors.border),
          hSpace(12),
          Row(
            children: [
              Icon(
                Icons.location_city_rounded,
                size: 16.r,
                color: AppColors.brandPrimary,
              ),
              vSpace(6),
              Text(
                '${'admin.assignments.site'.tr()}: ${assignment.siteName}',
                style: AppTextStyles.font13Medium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          hSpace(6),
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16.r,
                color: AppColors.textSecondary,
              ),
              vSpace(6),
              Text(
                '${'admin.assignments.validFrom'.tr()}: ${assignment.validFrom ?? '-'}  →  ${'admin.assignments.validUntil'.tr()}: ${assignment.validUntil ?? '-'}',
                style: AppTextStyles.font12Regular.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
