import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/plans/employee_plans_cubit.dart';

class EmployeeCreateProjectSheetWidget extends StatefulWidget {
  const EmployeeCreateProjectSheetWidget({super.key});

  @override
  State<EmployeeCreateProjectSheetWidget> createState() =>
      _EmployeeCreateProjectSheetWidgetState();
}

class _EmployeeCreateProjectSheetWidgetState
    extends State<EmployeeCreateProjectSheetWidget> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    final title = titleController.text.trim();
    if (title.isEmpty) return;
    setState(() => isSubmitting = true);
    final today = DateTime.now();
    final success = await context.read<EmployeePlansCubit>().createPlan(
      title: title,
      description: descriptionController.text.trim(),
      startDate: today.toIso8601String(),
      endDate: today.add(const Duration(days: 30)).toIso8601String(),
    );
    if (!mounted) return;
    setState(() => isSubmitting = false);
    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'employee.plans.createTitle'.tr(),
              style: AppTextStyles.font18Bold,
            ),
            hSpace(14),
            CustomTextFormField(
              controller: titleController,
              hintText: 'employee.plans.createName'.tr(),
            ),
            hSpace(12),
            CustomTextFormField(
              controller: descriptionController,
              hintText: 'employee.plans.createDescription'.tr(),
              maxLines: 3,
            ),
            hSpace(18),
            CustomButton(
              text: 'employee.plans.create'.tr(),
              isLoading: isSubmitting,
              onTap: submit,
            ),
          ],
        ),
      ),
    );
  }
}
