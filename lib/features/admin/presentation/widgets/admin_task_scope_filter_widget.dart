import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';

class AdminTaskScopeFilterWidget extends StatelessWidget {
  const AdminTaskScopeFilterWidget({
    required this.employees,
    required this.departments,
    required this.selectedEmployeeId,
    required this.selectedDepartmentId,
    required this.onEmployeeChanged,
    required this.onDepartmentChanged,
    super.key,
  });

  final List<EmployeeModel> employees;
  final List<DepartmentModel> departments;
  final String? selectedEmployeeId;
  final int? selectedDepartmentId;
  final ValueChanged<String?> onEmployeeChanged;
  final ValueChanged<int?> onDepartmentChanged;

  @override
  Widget build(BuildContext context) {
    final hasDept = selectedDepartmentId != null &&
        departments.any((d) => d.id == selectedDepartmentId);
    final hasEmp = selectedEmployeeId != null &&
        employees.any((e) => e.id == selectedEmployeeId);

    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        children: [
          DropdownButtonFormField<int?>(
            key: ValueKey('filter_dept_${hasDept ? selectedDepartmentId : 'all'}'),
            initialValue: hasDept ? selectedDepartmentId : null,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'admin.tasks.filter.department'.tr(context: context),
              border: InputBorder.none,
            ),
            items: [
              DropdownMenuItem<int?>(
                value: null,
                child: Text(
                  'admin.tasks.filter.allDepartments'.tr(context: context),
                ),
              ),
              for (final department in departments)
                if (department.id != null)
                  DropdownMenuItem<int?>(
                    value: department.id,
                    child: Text(department.departmentName ?? '-'),
                  ),
            ],
            onChanged: onDepartmentChanged,
          ),
          Divider(height: 1.h, color: AppColors.border),
          DropdownButtonFormField<String?>(
            key: ValueKey('filter_emp_${hasEmp ? selectedEmployeeId : 'all'}'),
            initialValue: hasEmp ? selectedEmployeeId : null,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: 'admin.tasks.filter.employee'.tr(context: context),
              border: InputBorder.none,
            ),
            items: [
              DropdownMenuItem<String?>(
                value: null,
                child: Text(
                  'admin.tasks.filter.allEmployees'.tr(context: context),
                ),
              ),
              for (final employee in employees)
                if (employee.id != null)
                  DropdownMenuItem<String?>(
                    value: employee.id,
                    child: Text(employee.name ?? employee.userName ?? '-'),
                  ),
            ],
            onChanged: onEmployeeChanged,
          ),
        ],
      ),
    );
  }
}
