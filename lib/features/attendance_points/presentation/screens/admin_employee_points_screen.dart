import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/points_cubit.dart';
import '../widgets/admin_employee_points_bloc_builder_widget.dart';

class AdminEmployeePointsScreen extends StatelessWidget {
  const AdminEmployeePointsScreen({required this.employeeId, super.key});

  final String employeeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'admin.points.employeeDetails'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
      ),
      body: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: () => context.read<PointsCubit>().loadAllPointsData(
          employeeId: employeeId,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          child: AdminEmployeePointsBlocBuilderWidget(employeeId: employeeId),
        ),
      ),
    );
  }
}
