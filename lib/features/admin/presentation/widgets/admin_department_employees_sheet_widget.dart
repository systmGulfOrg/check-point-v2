import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../cubit/admin_department_employees_cubit.dart';
import '../cubit/admin_department_employees_state.dart';
import 'admin_department_employee_card_widget.dart';
import 'admin_employees_skeleton_widget.dart';

class AdminDepartmentEmployeesSheetWidget extends StatelessWidget {
  const AdminDepartmentEmployeesSheetWidget({
    required this.departmentName,
    required this.departmentId,
    super.key,
  });

  final String departmentName;
  final int departmentId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
          hSpace(14),
          Row(
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.corporate_fare_outlined,
                  color: AppColors.brandPrimary,
                  size: 20.r,
                ),
              ),
              vSpace(10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      departmentName,
                      style: AppTextStyles.font16Bold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'admin.departments.employeesTitle'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                color: AppColors.textSecondary,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(height: 20),
          Expanded(
            child:
                BlocBuilder<
                  AdminDepartmentEmployeesCubit,
                  AdminDepartmentEmployeesState
                >(
                  builder: (context, state) => switch (state) {
                    AdminDepartmentEmployeesInitial() ||
                    AdminDepartmentEmployeesLoading() =>
                      const AdminEmployeesSkeletonWidget(),
                    AdminDepartmentEmployeesError(:final messageKey) => Center(
                      child: Padding(
                        padding: EdgeInsets.all(24.r),
                        child: Text(
                          messageKey.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.error,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    AdminDepartmentEmployeesSuccess(:final employees) =>
                      employees.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.group_off_outlined,
                                    size: 48.r,
                                    color: AppColors.placeholder,
                                  ),
                                  hSpace(12),
                                  Text(
                                    'admin.departments.noEmployees'.tr(
                                      context: context,
                                    ),
                                    style: AppTextStyles.font14Medium.copyWith(
                                      color: AppColors.textSecondary,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : ListView.separated(
                              itemCount: employees.length,
                              separatorBuilder: (_, _) => hSpace(10),
                              itemBuilder: (context, index) =>
                                  AdminDepartmentEmployeeCardWidget(
                                    employee: employees[index],
                                  ),
                            ),
                    _ => const SizedBox.shrink(),
                  },
                ),
          ),
        ],
      ),
    );
  }
}
