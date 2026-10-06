import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

class AdminAbsentEmployeesSheetWidget extends StatefulWidget {
  const AdminAbsentEmployeesSheetWidget({
    required this.absentEmployees,
    super.key,
  });

  final List<EmployeeModel> absentEmployees;

  @override
  State<AdminAbsentEmployeesSheetWidget> createState() =>
      _AdminAbsentEmployeesSheetWidgetState();
}

class _AdminAbsentEmployeesSheetWidgetState
    extends State<AdminAbsentEmployeesSheetWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredEmployees = widget.absentEmployees.where((employee) {
      if (_searchQuery.isEmpty) return true;
      final name = (employee.name ?? employee.userName ?? '').toLowerCase();
      final dept = (employee.departmentName ?? '').toLowerCase();
      final position = (employee.position ?? employee.role ?? '').toLowerCase();
      return name.contains(_searchQuery) ||
          dept.contains(_searchQuery) ||
          position.contains(_searchQuery);
    }).toList();

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            16.w,
            12.h,
            16.w,
            16.h + MediaQuery.of(context).viewInsets.bottom,
          ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'admin.attendance.absentTitle'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font18Bold,
                            ),
                            wSpace(8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.softRedBackground,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${widget.absentEmployees.length}',
                                style: AppTextStyles.font12Bold.copyWith(
                                  color: AppColors.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hSpace(4),
                        Text(
                          'admin.attendance.absentSubtitle'.tr(
                            context: context,
                          ),
                          style: AppTextStyles.font12Regular.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, size: 22.r),
                  ),
                ],
              ),
              hSpace(14),
              CustomTextFormField(
                controller: _searchController,
                hintText: 'admin.attendance.searchAbsentHint'.tr(
                  context: context,
                ),
                prefixIcon: Icon(Icons.search_rounded, size: 20.r),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.trim().toLowerCase();
                  });
                },
              ),
              hSpace(14),
              const Divider(color: AppColors.border, height: 1),
              hSpace(10),
              Flexible(
                child: filteredEmployees.isEmpty
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                widget.absentEmployees.isEmpty
                                    ? Icons.celebration_rounded
                                    : Icons.person_search_rounded,
                                size: 48.r,
                                color: widget.absentEmployees.isEmpty
                                    ? AppColors.success
                                    : AppColors.placeholder,
                              ),
                              hSpace(12),
                              Text(
                                widget.absentEmployees.isEmpty
                                    ? 'admin.attendance.allPresent'.tr(
                                        context: context,
                                      )
                                    : 'admin.attendance.empty'.tr(
                                        context: context,
                                      ),
                                style: AppTextStyles.font16Bold.copyWith(
                                  color: widget.absentEmployees.isEmpty
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                              if (widget.absentEmployees.isEmpty) ...[
                                hSpace(6),
                                Text(
                                  'admin.attendance.allPresentDesc'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font13Regular.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        itemCount: filteredEmployees.length,
                        separatorBuilder: (_, _) => hSpace(10),
                        itemBuilder: (context, index) {
                          final employee = filteredEmployees[index];
                          final displayName =
                              employee.name ?? employee.userName ?? 'Employee';
                          final initial = displayName.trim().isNotEmpty
                              ? displayName.trim()[0].toUpperCase()
                              : 'E';

                          return Container(
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground.withValues(
                                alpha: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20.r,
                                  backgroundColor: AppColors.softRedBackground,
                                  child: Text(
                                    initial,
                                    style: AppTextStyles.font14Bold.copyWith(
                                      color: AppColors.error,
                                    ),
                                  ),
                                ),
                                wSpace(12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        displayName,
                                        style: AppTextStyles.font14Bold,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      hSpace(3),
                                      Row(
                                        children: [
                                          if (employee.departmentName !=
                                              null) ...[
                                            Flexible(
                                              child: Text(
                                                employee.departmentName!,
                                                style: AppTextStyles
                                                    .font12Regular
                                                    .copyWith(
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                          if (employee.departmentName != null &&
                                              (employee.position != null ||
                                                  employee.role != null)) ...[
                                            Text(
                                              ' • ',
                                              style: AppTextStyles.font12Regular
                                                  .copyWith(
                                                    color:
                                                        AppColors.textSecondary,
                                                  ),
                                            ),
                                          ],
                                          if (employee.position != null ||
                                              employee.role != null) ...[
                                            Flexible(
                                              child: Text(
                                                employee.position ??
                                                    employee.role ??
                                                    '',
                                                style: AppTextStyles
                                                    .font12Regular
                                                    .copyWith(
                                                      color: AppColors
                                                          .textSecondary,
                                                    ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                wSpace(8),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 8.w,
                                    vertical: 4.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.softRedBackground,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.cancel_outlined,
                                        size: 13.r,
                                        color: AppColors.error,
                                      ),
                                      wSpace(4),
                                      Text(
                                        'admin.attendance.notCheckedIn'.tr(
                                          context: context,
                                        ),
                                        style: AppTextStyles.font11Medium
                                            .copyWith(
                                              color: AppColors.error,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
