import 'package:check_point_v2/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../cubit/employee_audit/admin_employee_audit_cubit.dart';
import '../cubit/employee_audit/admin_employee_audit_state.dart';
import '../widgets/admin_employee_audit_item_widget.dart';

class AdminEmployeeAuditScreen extends StatelessWidget {
  const AdminEmployeeAuditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.employees.activityLog'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminEmployeeAuditCubit, AdminEmployeeAuditState>(
          listener: (context, state) {
            state.maybeMap(
              error: (state) {
                CustomSnackBar.showError(context, message: state.message);
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              success: (logs) => ListView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return AdminEmployeeAuditItemWidget(log: log);
                },
              ),
              orElse: () => const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
  }
}
