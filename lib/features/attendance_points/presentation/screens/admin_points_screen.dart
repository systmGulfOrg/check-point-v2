import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/admin_points_cubit.dart';
import '../widgets/admin_points_bloc_builder_widget.dart';

class AdminPointsScreen extends StatefulWidget {
  const AdminPointsScreen({super.key});

  @override
  State<AdminPointsScreen> createState() => _AdminPointsScreenState();
}

class _AdminPointsScreenState extends State<AdminPointsScreen> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'admin.points.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: context.read<AdminPointsCubit>().loadEmployees,
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.brandPrimary,
        onRefresh: context.read<AdminPointsCubit>().loadEmployees,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'admin.points.subtitle'.tr(context: context),
                style: AppTextStyles.font13Regular,
              ),
              hSpace(12),
              CustomTextFormField(
                controller: searchController,
                hintText: 'admin.points.searchHint'.tr(context: context),
                onChanged: (value) {
                  unawaited(
                    context.read<AdminPointsCubit>().loadEmployees(
                      search: value,
                    ),
                  );
                },
                prefixIcon: Icon(
                  Icons.search_rounded,
                  size: 20.r,
                  color: AppColors.placeholder,
                ),
              ),
              hSpace(16),
              AdminPointsBlocBuilderWidget(
                onEmployeeTap: (employeeId) => Navigator.pushNamed(
                  context,
                  AppRoutes.adminEmployeePoints,
                  arguments: employeeId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
