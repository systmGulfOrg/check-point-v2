import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employees_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_employee_filter_row_widget.dart';

class AdminEmployeesScreen extends StatefulWidget {
  const AdminEmployeesScreen({super.key});

  @override
  State<AdminEmployeesScreen> createState() => _AdminEmployeesScreenState();
}

class _AdminEmployeesScreenState extends State<AdminEmployeesScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'admin.employees.filterAll';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'admin.employees.title'.tr(context: context),
                    style: AppTextStyles.font20Bold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Image.asset(AppAssets.logo, height: 32.h, fit: BoxFit.contain),
              ],
            ),
            hSpace(16),
            CustomTextFormField(
              controller: _searchController,
              hintText: 'admin.employees.searchHint'.tr(context: context),
              onChanged: context.read<AdminEmployeesCubit>().search,
              prefixIcon: Icon(
                Icons.search_rounded,
                size: 20.r,
                color: AppColors.placeholder,
              ),
            ),
            hSpace(14),
            AdminEmployeeFilterRowWidget(
              selectedFilter: _selectedFilter,
              onFilterSelected: (filter) {
                setState(() => _selectedFilter = filter);
                context.read<AdminEmployeesCubit>().setRoleFilter(
                  switch (filter) {
                    'admin.employees.filterEmployee' => 'employee',
                    'admin.employees.filterSupervisor' => 'supervisor',
                    'admin.employees.filterAdmin' => 'admin',
                    _ => null,
                  },
                );
              },
            ),
            hSpace(14),
            const AdminEmployeesBlocBuilderWidget(),
          ],
        ),
      ),
    );
  }
}
