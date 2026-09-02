import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../widgets/admin_create_task_sheet_widget.dart';
import '../widgets/admin_tasks_filter_widget.dart';
import '../widgets/admin_tasks_list_widget.dart';

class AdminTasksScreen extends StatefulWidget {
  const AdminTasksScreen({super.key});

  @override
  State<AdminTasksScreen> createState() => _AdminTasksScreenState();
}

class _AdminTasksScreenState extends State<AdminTasksScreen> {
  int selectedFilter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.tasks.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AdminTasksFilterWidget(
                selectedIndex: selectedFilter,
                onSelected: (index) => setState(() => selectedFilter = index),
              ),
              hSpace(14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'admin.tasks.count'.tr(context: context, args: ['4']),
                    style: AppTextStyles.font12Regular,
                  ),
                  InkWell(
                    onTap: () => showModalBottomSheet<void>(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: AppColors.cardBackground,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (_) => const AdminCreateTaskSheetWidget(),
                    ),
                    child: Text(
                      'admin.tasks.newTask'.tr(context: context),
                      style: AppTextStyles.font13SemiBold.copyWith(
                        color: AppColors.brandPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              hSpace(10),
              const AdminTasksListWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
