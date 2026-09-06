import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../../core/core.dart';
import '../../data/models/shift_model.dart';
import '../cubit/admin_shifts_policies_cubit.dart';
import '../cubit/admin_shifts_policies_state.dart';
import '../widgets/admin_new_shift_button_widget.dart';
import '../widgets/admin_shift_card_widget.dart';
import '../widgets/admin_shift_data.dart';

class AdminShiftsPoliciesScreen extends StatelessWidget {
  const AdminShiftsPoliciesScreen({super.key});

  void _showEditShiftDialog(
    BuildContext context,
    int shiftId,
    String currentName,
  ) {
    final nameController = TextEditingController(text: currentName);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Shift'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(labelText: 'Shift Name'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                context.read<AdminShiftsPoliciesCubit>().editShift(
                      shiftId,
                      AddShiftRequestBody(
                        name: nameController.text.trim(),
                      ),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'admin.shifts.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlocBuilder<AdminShiftsPoliciesCubit, AdminShiftsPoliciesState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    error: (messageKey) => Padding(
                      padding: EdgeInsets.all(24.r),
                      child: Center(
                        child: Text(
                          messageKey.tr(context: context),
                          style: AppTextStyles.font14Regular.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    actionSuccess: (_) => const SizedBox.shrink(),
                    success: (shifts, policies) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'admin.shifts.count'.tr(
                                context: context,
                                args: ['${shifts.length}'],
                              ),
                              style: AppTextStyles.font12Regular,
                            ),
                            const AdminNewShiftButtonWidget(),
                          ],
                        ),
                        hSpace(12),
                        if (shifts.isEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: Text(
                                'admin.requests.emptyAll'.tr(context: context),
                                style: AppTextStyles.font14Regular,
                              ),
                            ),
                          )
                        else
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: shifts.length,
                            separatorBuilder: (_, _) => hSpace(10),
                            itemBuilder: (context, index) {
                              final shift = shifts[index];
                              final shiftData = AdminShiftData(
                                nameKey: shift.name ?? 'Shift',
                                descriptionKey: 'Active Shift',
                                policiesCount: shift.branchesCount ?? 0,
                              );
                              return AdminShiftCardWidget(
                                shift: shiftData,
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  AppRoutes.adminShiftDetails,
                                  arguments: '${shift.id ?? index}',
                                ),
                                onEdit: () {
                                  if (shift.id != null) {
                                    _showEditShiftDialog(
                                      context,
                                      shift.id!,
                                      shift.name ?? '',
                                    );
                                  }
                                },
                                onDelete: () {
                                  if (shift.id != null) {
                                    context
                                        .read<AdminShiftsPoliciesCubit>()
                                        .deleteShift(shift.id!);
                                  }
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
