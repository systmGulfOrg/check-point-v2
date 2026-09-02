import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/supervisor_tasks_filter_widget.dart';
import '../widgets/supervisor_tasks_list_widget.dart';
import '../widgets/supervisor_new_task_button_widget.dart';

class SupervisorTasksScreen extends StatefulWidget {
  const SupervisorTasksScreen({super.key});

  @override
  State<SupervisorTasksScreen> createState() => _SupervisorTasksScreenState();
}

class _SupervisorTasksScreenState extends State<SupervisorTasksScreen> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'supervisor.nav.tasks'.tr(context: context),
              style: AppTextStyles.font20Bold,
            ),
            hSpace(20),
            SupervisorTasksFilterWidget(
              selectedIndex: selectedFilter,
              onFilterSelected: (index) =>
                  setState(() => selectedFilter = index),
            ),
            hSpace(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'supervisor.tasks.count'.tr(context: context, args: ['3']),
                  style: AppTextStyles.font12Regular,
                ),
                const SupervisorNewTaskButtonWidget(),
              ],
            ),
            hSpace(12),
            const SupervisorTasksListWidget(),
          ],
        ),
      ),
    );
  }
}
