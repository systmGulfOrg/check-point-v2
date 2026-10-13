import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/admin_points_employee_model.dart';
import 'admin_points_employee_card_widget.dart';

class AdminPointsSkeletonWidget extends StatelessWidget {
  const AdminPointsSkeletonWidget({super.key});

  static final List<AdminPointsEmployeeModel> employees = List.generate(
    6,
    (index) => AdminPointsEmployeeModel(
      id: 'skeleton-$index',
      name: 'Employee name',
      employeeCode: 'EMP-000',
      position: 'Position',
      department: const AdminPointsDepartmentModel(name: 'Department'),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Column(
        children: employees
            .map(
              (employee) => Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: AdminPointsEmployeeCardWidget(
                  employee: employee,
                  onTap: () {},
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
