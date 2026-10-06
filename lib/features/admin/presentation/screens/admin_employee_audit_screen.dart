import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../cubit/employee_audit/admin_employee_audit_cubit.dart';
import '../cubit/employee_audit/admin_employee_audit_state.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../data/models/audit/audit_log_model.dart';
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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message.tr(context: context))),
                );
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.map(
              initial: (_) => Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                  itemCount: 5,
                  itemBuilder: (context, index) => AdminEmployeeAuditItemWidget(
                    log: AuditLogModel(
                      id: 'sk-$index',
                      action: 'UPDATE',
                      createdAt: DateTime.now(),
                      actorName: 'Admin User',
                    ),
                  ),
                ),
              ),
              loading: (_) => Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                  itemCount: 5,
                  itemBuilder: (context, index) => AdminEmployeeAuditItemWidget(
                    log: AuditLogModel(
                      id: 'sk-$index',
                      action: 'UPDATE',
                      createdAt: DateTime.now(),
                      actorName: 'Admin User',
                    ),
                  ),
                ),
              ),
              error: (state) => Center(
                child: Text(
                  state.message.tr(context: context),
                  style: const TextStyle(color: AppColors.error),
                ),
              ),
              success: (state) {
                final logs = state.logs;
                if (logs.isEmpty) {
                  return Center(
                    child: Text(
                      'admin.requests.empty'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return AdminEmployeeAuditItemWidget(log: log);
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
