import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import '../cubit/admin_points_cubit.dart';
import '../cubit/admin_points_state.dart';
import 'admin_points_employee_card_widget.dart';

class AdminPointsBlocBuilderWidget extends StatelessWidget {
  const AdminPointsBlocBuilderWidget({required this.onEmployeeTap, super.key});

  final ValueChanged<String> onEmployeeTap;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminPointsCubit, AdminPointsState>(
      builder: (context, state) => switch (state) {
        AdminPointsInitial() || AdminPointsLoading() => const Center(
          child: CircularProgressIndicator(),
        ),
        AdminPointsError(:final messageKey) => Center(
          child: Padding(
            padding: EdgeInsets.all(24.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.insights_outlined,
                  size: 48.r,
                  color: AppColors.error,
                ),
                hSpace(10),
                Text(
                  messageKey.tr(context: context),
                  textAlign: TextAlign.center,
                  style: AppTextStyles.font14Regular,
                ),
                hSpace(12),
                TextButton(
                  onPressed: context.read<AdminPointsCubit>().loadEmployees,
                  child: Text('admin.attendance.tryAgain'.tr(context: context)),
                ),
              ],
            ),
          ),
        ),
        AdminPointsLoaded(:final page) =>
          page.items.isEmpty
              ? Center(
                  child: Text(
                    'admin.points.empty'.tr(context: context),
                    style: AppTextStyles.font14Regular,
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: page.items.length,
                  separatorBuilder: (_, index) => hSpace(10),
                  itemBuilder: (context, index) {
                    final employee = page.items[index];
                    return AdminPointsEmployeeCardWidget(
                      employee: employee,
                      onTap: () => onEmployeeTap(employee.id),
                    );
                  },
                ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
