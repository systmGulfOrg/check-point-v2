import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_branches_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_add_button_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_sites_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_tab_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

class AdminLocationsScreen extends StatefulWidget {
  const AdminLocationsScreen({super.key});

  @override
  State<AdminLocationsScreen> createState() => _AdminLocationsScreenState();
}

class _AdminLocationsScreenState extends State<AdminLocationsScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final category = AdminLocationCategory.values[selectedIndex];
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.locations.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => switch (category) {
            AdminLocationCategory.branches =>
              context.read<AdminBranchesCubit>().load(),
            AdminLocationCategory.sites =>
              context.read<ContractorCubit>().loadDashboardData(),
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminLocationsFilterWidget(
                  selectedIndex: selectedIndex,
                  onSelected: (index) {
                    setState(() => selectedIndex = index);
                    if (index == 1) {
                      context.read<ContractorCubit>().loadDashboardData();
                    }
                  },
                ),
                hSpace(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'admin.locations.title'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    AdminLocationsAddButtonWidget(category: category),
                  ],
                ),
                hSpace(10),
                switch (category) {
                  AdminLocationCategory.branches =>
                    const AdminBranchesBlocBuilderWidget(),
                  AdminLocationCategory.sites =>
                    const AdminSitesBlocBuilderWidget(),
                },
              ],
            ),
          ),
        ),
      ),
    );
  }
}
