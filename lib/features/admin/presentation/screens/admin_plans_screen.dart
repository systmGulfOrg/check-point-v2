import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../../supervisor/presentation/widgets/supervisor_create_plan_sheet_widget.dart';
import '../widgets/admin_plans_list_widget.dart';

class AdminPlansScreen extends StatelessWidget {
  const AdminPlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.plans.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin.plans.count'.tr(context: context, args: ['3']),
                    style: AppTextStyles.font12Regular,
                  ),
                  InkWell(
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.cardBackground,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => const SupervisorCreatePlanSheetWidget(),
                    ),
                    child: Text(
                      'admin.plans.newPlan'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(12),
              const AdminPlansListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
