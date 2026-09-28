import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_contractor_headcount_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class SupervisorSiteContractorsScreen extends StatelessWidget {
  const SupervisorSiteContractorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'supervisor.samco.contractorsCount'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final data = state.mapOrNull(success: (value) => value);
          final attendance = data?.attendanceLogs ?? const [];
          final workersByContractor = <String, int>{};
          for (final worker in data?.workers ?? const []) {
            final id = worker.contractorId ?? '';
            workersByContractor[id] = (workersByContractor[id] ?? 0) + 1;
          }
          return ListView.builder(
            padding: EdgeInsets.all(16.r),
            itemCount: data?.contractors.length ?? 0,
            itemBuilder: (context, index) {
              final contractor = data!.contractors[index];
              final logs = attendance
                  .where((item) => item.contractorId == contractor.id)
                  .toList();
              return SupervisorContractorHeadcountCardWidget(
                contractorName: contractor.name,
                code: contractor.code,
                presentCount: logs
                    .where((item) => item.status.toLowerCase() == 'present')
                    .length,
                totalCount:
                    workersByContractor[contractor.id] ??
                    contractor.workerCount,
                lateCount: logs
                    .where((item) => item.status.toLowerCase() == 'late')
                    .length,
                outsideGeofenceCount: logs
                    .where((item) => !item.isInsideGeofence)
                    .length,
              );
            },
          );
        },
      ),
    );
  }
}
