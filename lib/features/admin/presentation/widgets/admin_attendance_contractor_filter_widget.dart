import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

class AdminAttendanceContractorFilterWidget extends StatelessWidget {
  const AdminAttendanceContractorFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = context.watch<AdminAttendanceCubit>();
    final contractorState = context.watch<ContractorCubit>().state;
    final contractors = contractorState.mapOrNull(
          success: (v) => v.contractors,
        ) ??
        const <ContractorCompanyModel>[];

    final selectedContractorName = contractors
            .where((c) => c.id == attendanceCubit.selectedContractorId)
            .map((c) => c.name)
            .firstOrNull ??
        'admin.attendance.allContractors'.tr(context: context);

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: () {
        final controller = TextEditingController();
        showModalBottomSheet<void>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.cardBackground,
          builder: (sheetContext) => StatefulBuilder(
            builder: (sheetContext, setSheetState) {
              final query = controller.text.trim().toLowerCase();
              final filtered = contractors.where((contractor) {
                return contractor.name.toLowerCase().contains(query);
              }).toList();

              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    16.w,
                    12.h,
                    16.w,
                    MediaQuery.viewInsetsOf(sheetContext).bottom + 16.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'admin.attendance.contractor'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                      hSpace(10),
                      CustomTextFormField(
                        controller: controller,
                        hintText: 'admin.attendance.searchContractor'.tr(
                          context: context,
                        ),
                        prefixIcon: Icon(Icons.search_rounded, size: 19.r),
                        onChanged: (_) => setSheetState(() {}),
                      ),
                      hSpace(8),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.softBrandBackground,
                                child: Icon(
                                  Icons.engineering_rounded,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                              title: Text(
                                'admin.attendance.allContractors'.tr(
                                  context: context,
                                ),
                              ),
                              onTap: () {
                                attendanceCubit.setContractorFilter(null);
                                Navigator.pop(sheetContext);
                              },
                            ),
                            for (final contractor in filtered)
                              ListTile(
                                leading: Icon(
                                  Icons.engineering_outlined,
                                  color: AppColors.placeholder,
                                ),
                                title: Text(contractor.name),
                                subtitle: Text(
                                  '${contractor.workerCount} عمال',
                                  style: AppTextStyles.font11Regular,
                                ),
                                onTap: () {
                                  attendanceCubit.setContractorFilter(
                                    contractor.id,
                                  );
                                  Navigator.pop(sheetContext);
                                },
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ).whenComplete(controller.dispose);
      },
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: InputDecorator(
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: 'admin.attendance.contractor'.tr(context: context),
            labelStyle: AppTextStyles.font11Regular.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: Icon(Icons.engineering_outlined, size: 18.r),
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.r),
          ),
          child: Text(
            selectedContractorName,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Medium,
          ),
        ),
      ),
    );
  }
}
