import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';

enum AdminAttendanceEmployeeStatus { present, late, absent, onLeave }

extension AdminAttendanceEmployeeStatusX on AdminAttendanceEmployeeStatus {
  String get titleKey => switch (this) {
    AdminAttendanceEmployeeStatus.present => 'admin.attendance.presentTitle',
    AdminAttendanceEmployeeStatus.late => 'admin.attendance.lateTitle',
    AdminAttendanceEmployeeStatus.absent => 'admin.attendance.absentTitle',
    AdminAttendanceEmployeeStatus.onLeave => 'admin.attendance.onLeaveTitle',
  };

  String get subtitleKey => switch (this) {
    AdminAttendanceEmployeeStatus.present => 'admin.attendance.presentSubtitle',
    AdminAttendanceEmployeeStatus.late => 'admin.attendance.lateSubtitle',
    AdminAttendanceEmployeeStatus.absent => 'admin.attendance.absentSubtitle',
    AdminAttendanceEmployeeStatus.onLeave => 'admin.attendance.onLeaveSubtitle',
  };

  String get labelKey => switch (this) {
    AdminAttendanceEmployeeStatus.present => 'admin.attendance.checkedIn',
    AdminAttendanceEmployeeStatus.late => 'admin.attendance.lateStatus',
    AdminAttendanceEmployeeStatus.absent => 'admin.attendance.notCheckedIn',
    AdminAttendanceEmployeeStatus.onLeave => 'admin.attendance.onLeaveStatus',
  };

  String get emptyTitleKey => switch (this) {
    AdminAttendanceEmployeeStatus.present =>
      'admin.attendance.noPresentEmployees',
    AdminAttendanceEmployeeStatus.late => 'admin.attendance.noLateEmployees',
    AdminAttendanceEmployeeStatus.absent => 'admin.attendance.allPresent',
    AdminAttendanceEmployeeStatus.onLeave =>
      'admin.attendance.noOnLeaveEmployees',
  };

  String get emptySubtitleKey => switch (this) {
    AdminAttendanceEmployeeStatus.present =>
      'admin.attendance.noPresentEmployeesDesc',
    AdminAttendanceEmployeeStatus.late =>
      'admin.attendance.noLateEmployeesDesc',
    AdminAttendanceEmployeeStatus.absent => 'admin.attendance.allPresentDesc',
    AdminAttendanceEmployeeStatus.onLeave =>
      'admin.attendance.noOnLeaveEmployeesDesc',
  };

  Color get color => switch (this) {
    AdminAttendanceEmployeeStatus.present => AppColors.success,
    AdminAttendanceEmployeeStatus.late => AppColors.warning,
    AdminAttendanceEmployeeStatus.absent => AppColors.error,
    AdminAttendanceEmployeeStatus.onLeave => AppColors.brandPrimary,
  };

  Color get backgroundColor => switch (this) {
    AdminAttendanceEmployeeStatus.present => AppColors.softGreenBackground,
    AdminAttendanceEmployeeStatus.late => AppColors.softYellowBackground,
    AdminAttendanceEmployeeStatus.absent => AppColors.softRedBackground,
    AdminAttendanceEmployeeStatus.onLeave => AppColors.softBrandBackground,
  };

  IconData get icon => switch (this) {
    AdminAttendanceEmployeeStatus.present => Icons.check_circle_outline_rounded,
    AdminAttendanceEmployeeStatus.late => Icons.schedule_rounded,
    AdminAttendanceEmployeeStatus.absent => Icons.cancel_outlined,
    AdminAttendanceEmployeeStatus.onLeave => Icons.beach_access_outlined,
  };
}

class AdminAbsentEmployeesSheetWidget extends StatefulWidget {
  const AdminAbsentEmployeesSheetWidget({
    required this.employees,
    required this.status,
    super.key,
  });

  final List<EmployeeModel> employees;
  final AdminAttendanceEmployeeStatus status;

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
    final filteredEmployees = widget.employees.where((employee) {
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
              const AppSheetHandleWidget(),
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
                              widget.status.titleKey.tr(context: context),
                              style: AppTextStyles.font18Bold,
                            ),
                            wSpace(8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: widget.status.backgroundColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                '${widget.employees.length}',
                                style: AppTextStyles.font12Bold.copyWith(
                                  color: widget.status.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        hSpace(4),
                        Text(
                          widget.status.subtitleKey.tr(context: context),
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
                hintText: 'admin.attendance.searchEmployeesHint'.tr(
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
                                widget.employees.isEmpty
                                    ? widget.status.icon
                                    : Icons.person_search_rounded,
                                size: 48.r,
                                color: widget.employees.isEmpty
                                    ? widget.status.color
                                    : AppColors.placeholder,
                              ),
                              hSpace(12),
                              Text(
                                widget.employees.isEmpty
                                    ? widget.status.emptyTitleKey.tr(
                                        context: context,
                                      )
                                    : 'admin.attendance.empty'.tr(
                                        context: context,
                                      ),
                                style: AppTextStyles.font16Bold.copyWith(
                                  color: widget.employees.isEmpty
                                      ? AppColors.textPrimary
                                      : AppColors.textSecondary,
                                ),
                              ),
                              if (widget.employees.isEmpty) ...[
                                hSpace(6),
                                Text(
                                  widget.status.emptySubtitleKey.tr(
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
                                AppAvatarWidget(
                                  imageUrl: employee.imageUrl,
                                  name: employee.name ?? employee.userName,
                                  initials: initial,
                                  subtitle: employee.departmentName,
                                  radius: 20.r,
                                  backgroundColor:
                                      widget.status.backgroundColor,
                                  textColor: widget.status.color,
                                  enablePreview: true,
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
                                    color: widget.status.backgroundColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        widget.status.icon,
                                        size: 13.r,
                                        color: widget.status.color,
                                      ),
                                      wSpace(4),
                                      Text(
                                        widget.status.labelKey.tr(
                                          context: context,
                                        ),
                                        style: AppTextStyles.font11Medium
                                            .copyWith(
                                              color: widget.status.color,
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
