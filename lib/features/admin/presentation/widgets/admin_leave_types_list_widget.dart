import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/leave_requests/leave_type_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/leave_requests/admin_leave_requests_cubit.dart';
import 'admin_leave_type_card_widget.dart';
import 'admin_new_leave_type_sheet_widget.dart';

class AdminLeaveTypesListWidget extends StatelessWidget {
  const AdminLeaveTypesListWidget({required this.leaveTypes, super.key});

  final List<LeaveTypeModel> leaveTypes;

  void _showEditSheet(BuildContext context, LeaveTypeModel item) {
    final cubit = context.read<AdminLeaveRequestsCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: AdminNewLeaveTypeSheetWidget(leaveType: item),
      ),
    );
  }

  void _confirmDelete(BuildContext context, LeaveTypeModel item) {
    if (item.id == null) return;
    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(
          'admin.leaveManagement.deleteTypeConfirm'.tr(context: context),
          style: AppTextStyles.font14SemiBold,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogCtx),
            child: Text('admin.leaveManagement.cancel'.tr(context: context)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogCtx);
              context.read<AdminLeaveRequestsCubit>().deleteLeaveType(item.id!);
            },
            child: Text(
              'common.delete'.tr(context: context),
              style: const TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (leaveTypes.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h),
        child: Center(
          child: Text(
            'admin.leaveManagement.emptyTypes'.tr(context: context),
            style: AppTextStyles.font14Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: leaveTypes.length,
      separatorBuilder: (_, _) => hSpace(10),
      itemBuilder: (context, index) {
        final item = leaveTypes[index];
        return AdminLeaveTypeCardWidget(
          leaveType: item,
          onEdit: () => _showEditSheet(context, item),
          onDelete: () => _confirmDelete(context, item),
        );
      },
    );
  }
}
