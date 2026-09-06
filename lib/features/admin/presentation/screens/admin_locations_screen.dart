import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_branches_bloc_builder_widget.dart';
import '../widgets/admin_customers_bloc_builder_widget.dart';
import '../widgets/admin_departments_bloc_builder_widget.dart';
import '../widgets/admin_locations_add_button_widget.dart';
import '../widgets/admin_locations_filter_widget.dart';
import '../widgets/admin_locations_tab_widget.dart';

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
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminLocationsFilterWidget(
                selectedIndex: selectedIndex,
                onSelected: (index) => setState(() => selectedIndex = index),
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
                AdminLocationCategory.departments =>
                  const AdminDepartmentsBlocBuilderWidget(),
                AdminLocationCategory.sites =>
                  const AdminCustomersBlocBuilderWidget(type: 'site'),
                AdminLocationCategory.customers =>
                  const AdminCustomersBlocBuilderWidget(type: 'customer'),
              },
            ],
          ),
        ),
      ),
    );
  }
}
