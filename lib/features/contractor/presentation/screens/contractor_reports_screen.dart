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
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorReportsScreen extends StatefulWidget {
  const ContractorReportsScreen({super.key});

  @override
  State<ContractorReportsScreen> createState() =>
      _ContractorReportsScreenState();
}

class _ContractorReportsScreenState extends State<ContractorReportsScreen> {
  DateTime? from;
  DateTime? to;

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
          final attendance = context.read<ContractorCubit>().attendanceForRange(
            from: from,
            to: to,
          );
          final present = attendance
              .where((item) => item.status.toLowerCase() == 'present')
              .length;
          final rate = workers == 0 ? 0 : (present * 100 / workers).round();
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton.icon(
                    onPressed: () async {
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                        initialDateRange: from != null && to != null
                            ? DateTimeRange(start: from!, end: to!)
                            : null,
                      );
                      if (!context.mounted || picked == null) return;
                      setState(() {
                        from = picked.start;
                        to = picked.end;
                      });
                    },
                    icon: const Icon(Icons.date_range_outlined),
                    label: Text(
                      from == null || to == null
                          ? 'contractor.reports.selectDateRange'.tr()
                          : '${DateFormat.yMd(context.locale.toString()).format(from!)} - ${DateFormat.yMd(context.locale.toString()).format(to!)}',
                    ),
                  ),
                ),
                hSpace(8),
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
                    wSpace(12),
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
                hSpace(20),
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
                      hSpace(12),
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
                hSpace(24),
                ContractorReportExportButtonWidget(
                  csvBuilder: () => context
                      .read<ContractorCubit>()
                      .buildAttendanceCsv(from: from, to: to),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
