import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_corrections_bloc_builder_widget.dart';

class SupervisorCorrectionsScreen extends StatelessWidget {
  const SupervisorCorrectionsScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.pageBackground,
    appBar: AppBar(
      title: Text(
        'supervisor.corrections.title'.tr(),
        style: AppTextStyles.font16Bold.copyWith(color: AppColors.textPrimary),
      ),
      backgroundColor: AppColors.cardBackground,
      elevation: 0,
    ),
    body: const SupervisorCorrectionsBlocBuilderWidget(),
  );
}
