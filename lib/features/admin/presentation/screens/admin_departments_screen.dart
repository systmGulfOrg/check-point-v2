import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_departments_cubit.dart';
import '../widgets/admin_create_department_sheet_widget.dart';
import '../widgets/admin_departments_bloc_builder_widget.dart';

class AdminDepartmentsScreen extends StatefulWidget {
  const AdminDepartmentsScreen({super.key});

  @override
  State<AdminDepartmentsScreen> createState() => _AdminDepartmentsScreenState();
}

class _AdminDepartmentsScreenState extends State<AdminDepartmentsScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminDepartmentsCubit>(),
        child: const AdminCreateDepartmentSheetWidget(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.departments.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: _searchController,
                hintText: 'admin.departments.searchHint'.tr(context: context),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.textSecondary,
                ),
                onChanged: (val) =>
                    context.read<AdminDepartmentsCubit>().search(val),
              ),
              hSpace(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin.departments.title'.tr(context: context),
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  InkWell(
                    onTap: _showAddSheet,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.softBrandBackground,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 16.r,
                            color: AppColors.brandPrimary,
                          ),
                          vSpace(4),
                          Text(
                            'admin.departments.add'.tr(context: context),
                            style: AppTextStyles.font12SemiBold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(12),
              const AdminDepartmentsBlocBuilderWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
