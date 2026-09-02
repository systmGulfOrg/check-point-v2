import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_employee_card_widget.dart';
import '../widgets/admin_employee_filter_row_widget.dart';

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
                Text(
                  'admin.employees.title'.tr(context: context),
                  style: AppTextStyles.font20Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
                Image.asset(
                  AppAssets.logo,
                  height: 32.h,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            hSpace(16),
            CustomTextFormField(
              controller: _searchController,
              hintText: 'admin.employees.searchHint'.tr(context: context),
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
              },
            ),
            hSpace(14),
            Text(
              'admin.employees.countHeader'.tr(
                context: context,
                args: ['5'],
              ),
              style: AppTextStyles.font13Regular.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            hSpace(12),
            const AdminEmployeeCardWidget(
              initials: 'SA',
              name: 'System Administrator',
              roleKey: 'auth.role.admin',
              email: 'admin@checkpoint.app',
              empCode: 'EMP-2024-0001',
            ),
            hSpace(10),
            const AdminEmployeeCardWidget(
              initials: 'SJ',
              name: 'Sarah Johnson',
              roleKey: 'auth.role.supervisor',
              email: 'sarah.johnson@checkpoint.app',
              empCode: 'EMP-2024-0042',
              department: 'Operations',
            ),
            hSpace(10),
            const AdminEmployeeCardWidget(
              initials: 'JM',
              name: 'James Martinez',
              roleKey: 'auth.role.employee',
              email: 'james.martinez@checkpoint.app',
              empCode: 'EMP-2024-0087',
              department: 'Operations',
            ),
            hSpace(10),
            const AdminEmployeeCardWidget(
              initials: 'PN',
              name: 'Priya Nair',
              roleKey: 'auth.role.employee',
              email: 'priya.nair@checkpoint.app',
              empCode: 'EMP-2024-0091',
              department: 'Information Technology',
            ),
            hSpace(10),
            const AdminEmployeeCardWidget(
              initials: 'DC',
              name: 'David Chen',
              roleKey: 'auth.role.employee',
              email: 'david.chen@checkpoint.app',
              empCode: 'EMP-2024-0104',
              department: 'Finance',
            ),
          ],
        ),
      ),
    );
  }
}
