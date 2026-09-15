import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/app_text_styles.dart';
import '../cubit/employee_audit/admin_employee_audit_cubit.dart';
import '../cubit/employee_audit/admin_employee_audit_state.dart';

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
        title: Text('admin.employees.activityLog'.tr(context: context), style: AppTextStyles.font18Bold),
      ),
      body: SafeArea(
        child: BlocConsumer<AdminEmployeeAuditCubit, AdminEmployeeAuditState>(
          listener: (context, state) {
            state.maybeMap(
              error: (state) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              },
              orElse: () {},
            );
          },
          builder: (context, state) {
            return state.map(
              initial: (_) => const Center(child: CircularProgressIndicator(color: AppColors.brandPrimary)),
              loading: (_) => const Center(child: CircularProgressIndicator(color: AppColors.brandPrimary)),
              error: (state) => Center(child: Text(state.message, style: const TextStyle(color: AppColors.error))),
              success: (state) {
                final logs = state.logs;
                if (logs.isEmpty) {
                  return Center(
                    child: Text('admin.requests.empty'.tr(context: context), style: AppTextStyles.font14Regular),
                  );
                }
                return ListView.builder(
                  padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: AppColors.border),
                        boxShadow: const [
                          BoxShadow(color: AppColors.shadow, blurRadius: 4, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(log.action, style: AppTextStyles.font16Bold),
                          SizedBox(height: 8.h),
                          Text('${"admin.employees.by".tr(context: context)} ${log.actorName ?? "admin.employees.unknown".tr(context: context)}', style: AppTextStyles.font14Regular),
                          SizedBox(height: 4.h),
                          Text(
                            DateFormat('yyyy-MM-dd HH:mm').format(log.createdAt.toLocal()),
                            style: AppTextStyles.font12Regular.copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    );
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
