import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

class AdminShiftEmployeesWidget extends StatefulWidget {
  const AdminShiftEmployeesWidget({required this.employees, super.key});

  final List<EmployeeModel> employees;

  @override
  State<AdminShiftEmployeesWidget> createState() =>
      AdminShiftEmployeesWidgetState();
}

class AdminShiftEmployeesWidgetState extends State<AdminShiftEmployeesWidget> {
  static const visibleEmployeeCount = 6;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final visibleEmployees = isExpanded
        ? widget.employees
        : widget.employees.take(visibleEmployeeCount).toList();
    final hasMoreEmployees = widget.employees.length > visibleEmployeeCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: [
            for (final employee in visibleEmployees)
              Chip(
                avatar: AppAvatarWidget(
                  imageUrl: employee.imageUrl,
                  name: employee.name ?? employee.userName,
                  radius: 12.r,
                  enablePreview: true,
                ),
                label: Text(
                  employee.name ?? employee.userName ?? '-',
                  style: AppTextStyles.font12Regular,
                ),
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  side: const BorderSide(color: AppColors.border),
                ),
              ),
          ],
        ),
        if (hasMoreEmployees) ...[
          hSpace(6),
          InkWell(
            onTap: () => setState(() => isExpanded = !isExpanded),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    (isExpanded
                            ? 'admin.shifts.policies.seeLess'
                            : 'admin.shifts.policies.seeMore')
                        .tr(context: context),
                    style: AppTextStyles.font13SemiBold.copyWith(
                      color: AppColors.brandPrimary,
                    ),
                  ),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: AppColors.brandPrimary,
                    size: 18.r,
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
