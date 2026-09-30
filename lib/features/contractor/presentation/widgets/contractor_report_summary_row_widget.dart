import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorReportSummaryRowWidget extends StatelessWidget {
  const ContractorReportSummaryRowWidget({
    super.key,
    required this.month,
    required this.present,
    required this.late,
    required this.absent,
  });

  final String month;
  final String present;
  final String late;
  final String absent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(month, style: AppTextStyles.font14SemiBold),
        Row(
          children: [
            Text(present, style: AppTextStyles.font11Medium.copyWith(color: AppColors.success)),
            wSpace(8),
            Text(late, style: AppTextStyles.font11Medium.copyWith(color: AppColors.warning)),
            wSpace(8),
            Text(absent, style: AppTextStyles.font11Medium.copyWith(color: AppColors.error)),
          ],
        ),
      ],
    );
  }
}
