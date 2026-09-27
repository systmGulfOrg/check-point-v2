import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/deleted_employees/admin_deleted_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/deleted_employees/admin_deleted_employees_bloc_builder_widget.dart';

class AdminDeletedEmployeesScreen extends StatelessWidget {
  const AdminDeletedEmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'admin.deletedEmployees.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(color: AppColors.textPrimary),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<AdminDeletedEmployeesCubit>().load,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.softRedBackground,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 18.r,
                        color: AppColors.error,
                      ),
                      wSpace(8),
                      Expanded(
                        child: Text(
                          'admin.deletedEmployees.infoNote'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                hSpace(16),
                const AdminDeletedEmployeesBlocBuilderWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
