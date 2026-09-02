import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_new_shift_button_widget.dart';
import '../widgets/admin_shifts_list_widget.dart';

class AdminShiftsPoliciesScreen extends StatelessWidget {
  const AdminShiftsPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.shifts.title'.tr(context: context),
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
                    'admin.shifts.count'.tr(context: context, args: ['3']),
                    style: AppTextStyles.font12Regular,
                  ),
                  const AdminNewShiftButtonWidget(),
                ],
              ),
              hSpace(12),
              AdminShiftsListWidget(
                onShiftTap: (shiftKey) => Navigator.pushNamed(
                  context,
                  AppRoutes.adminShiftDetails,
                  arguments: shiftKey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
