import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_kpi_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_report_summary_row_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_report_export_button_widget.dart';

class ContractorReportsScreen extends StatelessWidget {
  const ContractorReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractor.reports.title'.tr(),
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
          final workers = data?.workers.length ?? 0;
          final attendance = data?.attendanceLogs ?? const [];
          final present = attendance
              .where((item) => item.status.toLowerCase() == 'present')
              .length;
          final rate = workers == 0 ? 0 : (present * 100 / workers).round();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.reports.totalHeadcount'.tr(),
                        value: '$workers',
                        icon: Icons.groups_3_rounded,
                        color: AppColors.info,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ContractorKpiCardWidget(
                        title: 'contractor.reports.attendanceRate'.tr(),
                        value: '$rate%',
                        icon: Icons.pie_chart_outline_rounded,
                        color: AppColors.success,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'contractor.reports.monthlySummary'.tr(),
                        style: AppTextStyles.font14Bold,
                      ),
                      SizedBox(height: 12.h),
                      ContractorReportSummaryRowWidget(
                        month: DateTime.now().toIso8601String().substring(0, 7),
                        present:
                            '$present ${'contractor.reports.present'.tr()}',
                        late:
                            '${attendance.where((item) => item.status.toLowerCase() == 'late').length} ${'contractor.reports.late'.tr()}',
                        absent:
                            '${workers > attendance.length ? workers - attendance.length : 0} ${'contractor.reports.absent'.tr()}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                ContractorReportExportButtonWidget(
                  csvBuilder: context
                      .read<ContractorCubit>()
                      .buildAttendanceCsv,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
