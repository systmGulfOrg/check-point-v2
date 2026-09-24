import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/shifts_policies/shift_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/shifts_policies/admin_shifts_policies_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_new_shift_button_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_shift_card_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_shift_data.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_shifts_skeleton_widget.dart';

class AdminShiftsPoliciesScreen extends StatelessWidget {
  const AdminShiftsPoliciesScreen({super.key});

  void _showEditShiftDialog(
    BuildContext context,
    int shiftId,
    String currentName,
  ) {
    final nameController = TextEditingController(text: currentName);
    showDialog<void>(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 56.r,
                height: 56.r,
                decoration: BoxDecoration(
                  color: AppColors.brandPrimary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.brandPrimary,
                  size: 28.r,
                ),
              ),
              hSpace(16),
              Text(
                'admin.shifts.edit.title'.tr(context: context),
                textAlign: TextAlign.center,
                style: AppTextStyles.font18Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(16),
              CustomTextFormField(
                controller: nameController,
                hintText: 'admin.shifts.edit.nameLabel'.tr(context: context),
              ),
              hSpace(20),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'admin.shifts.edit.cancel'.tr(context: context),
                      onTap: () => Navigator.pop(dialogContext),
                      backgroundColor: AppColors.pageBackground,
                      textColor: AppColors.textPrimary,
                      height: 44,
                    ),
                  ),
                  wSpace(12),
                  Expanded(
                    child: CustomButton(
                      text: 'admin.shifts.edit.save'.tr(context: context),
                      onTap: () {
                        if (nameController.text.trim().isNotEmpty) {
                          context.read<AdminShiftsPoliciesCubit>().editShift(
                            shiftId,
                            AddShiftRequestBody(name: nameController.text.trim()),
                          );
                          Navigator.pop(dialogContext);
                        }
                      },
                      backgroundColor: AppColors.brandPrimary,
                      textColor: AppColors.white,
                      height: 44,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ).whenComplete(nameController.dispose);
  }

  void _showDeleteShiftDialog(BuildContext context, int shiftId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.shifts.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminShiftsPoliciesCubit>().deleteShift(shiftId);
        },
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
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: context.read<AdminShiftsPoliciesCubit>().load,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<AdminShiftsPoliciesCubit, AdminShiftsPoliciesState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const AdminShiftsSkeletonWidget(),
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
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              child: Center(
                                child: Text(
                                  'admin.requests.emptyAll'.tr(
                                    context: context,
                                  ),
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
                                  nameKey:
                                      shift.name ?? 'admin.shifts.fallbackName',
                                  descriptionKey:
                                      shift.description ??
                                      'admin.shifts.description.active',
                                  policiesCount: shift.branchesCount ?? 0,
                                );
                                return AnimatedListItemWidget(
                                  index: index,
                                  child: AdminShiftCardWidget(
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
                                        _showDeleteShiftDialog(
                                          context,
                                          shift.id!,
                                        );
                                      }
                                    },
                                  ),
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
      ),
    );
  }
}
