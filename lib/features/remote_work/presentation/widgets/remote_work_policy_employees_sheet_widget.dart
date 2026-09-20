import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import '../../data/models/remote_work_policy_model.dart';
import '../../data/repos/remote_work_repo.dart';

class RemoteWorkPolicyEmployeesSheetWidget extends StatefulWidget {
  const RemoteWorkPolicyEmployeesSheetWidget({
    required this.policy,
    super.key,
  });

  final RemoteWorkPolicyModel policy;

  @override
  State<RemoteWorkPolicyEmployeesSheetWidget> createState() =>
      _RemoteWorkPolicyEmployeesSheetWidgetState();
}

class _RemoteWorkPolicyEmployeesSheetWidgetState
    extends State<RemoteWorkPolicyEmployeesSheetWidget> {
  late final Future<ApiResult<List<EmployeeModel>>> _employeesFuture;

  @override
  void initState() {
    super.initState();
    _employeesFuture = sl<RemoteWorkRepo>().getPolicyEmployees(widget.policy.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.policy.name,
                      style: AppTextStyles.font16Bold,
                    ),
                    hSpace(2),
                    Text(
                      'remoteWork.policyEmployees'.tr(context: context),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const Divider(height: 24),
          Expanded(
            child: FutureBuilder<ApiResult<List<EmployeeModel>>>(
              future: _employeesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Skeletonizer(
                    enabled: true,
                    child: ListView.separated(
                      itemCount: 4,
                      separatorBuilder: (_, _) => const Divider(height: 12),
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: AppColors.softBlueBackground,
                            child: const Text('EM'),
                          ),
                          title: const Text('Loading Employee Name'),
                          subtitle: const Text('EMP-001 • Department'),
                        );
                      },
                    ),
                  );
                }
                final result = snapshot.data;
                if (result == null || result is Failure) {
                  return Center(
                    child: Text(
                      'remoteWork.loadEmployeesError'.tr(context: context),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  );
                }

                final employees = (result as Success<List<EmployeeModel>>).data;
                if (employees.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline_rounded,
                          size: 48.r,
                          color: AppColors.placeholder,
                        ),
                        hSpace(12),
                        Text(
                          'remoteWork.noEmployeesInPolicy'.tr(context: context),
                          style: AppTextStyles.font14Medium.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  itemCount: employees.length,
                  separatorBuilder: (_, _) => const Divider(height: 12),
                  itemBuilder: (context, index) {
                    final emp = employees[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.softBrandBackground,
                        backgroundImage: emp.imageUrl != null && emp.imageUrl!.isNotEmpty
                            ? NetworkImage(emp.imageUrl!)
                            : null,
                        child: emp.imageUrl == null || emp.imageUrl!.isEmpty
                            ? Text(
                                emp.name?.isNotEmpty == true
                                    ? emp.name![0].toUpperCase()
                                    : '?',
                                style: AppTextStyles.font14Bold.copyWith(
                                  color: AppColors.brandPrimary,
                                ),
                              )
                            : null,
                      ),
                      title: Text(
                        emp.name ?? '',
                        style: AppTextStyles.font14SemiBold,
                      ),
                      subtitle: Text(
                        '${emp.employeeCode ?? ''} • ${emp.position ?? emp.departmentName ?? ''}',
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
