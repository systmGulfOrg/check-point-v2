import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/attendance/admin_attendance_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

class AdminAttendanceSiteFilterWidget extends StatelessWidget {
  const AdminAttendanceSiteFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final attendanceCubit = context.watch<AdminAttendanceCubit>();
    final branches = switch (context.watch<AdminBranchesCubit>().state) {
      AdminBranchesSuccess(:final branches) => branches,
      _ => const <BranchModel>[],
    };
    final contractorState = context.watch<ContractorCubit>().state;
    final samcoSites = contractorState.mapOrNull(
          success: (v) => v.sites,
        ) ??
        const <SiteBoundaryModel>[];

    // Combine or fallback
    final siteList = <_FilterSiteItem>[];
    if (samcoSites.isNotEmpty) {
      for (final s in samcoSites) {
        siteList.add(_FilterSiteItem(id: s.siteId, name: s.siteName));
      }
    } else {
      for (final b in branches) {
        if (b.id != null) {
          siteList.add(
            _FilterSiteItem(id: b.id.toString(), name: b.name ?? '-'),
          );
        }
      }
    }

    final selectedSiteName = siteList
            .where((s) => s.id == attendanceCubit.selectedSiteId)
            .map((s) => s.name)
            .firstOrNull ??
        'admin.attendance.allSites'.tr(context: context);

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
              final filtered = siteList.where((site) {
                return site.name.toLowerCase().contains(query);
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
                        'admin.attendance.site'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                      hSpace(10),
                      CustomTextFormField(
                        controller: controller,
                        hintText: 'admin.attendance.searchSite'.tr(
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
                                  Icons.location_city_rounded,
                                  color: AppColors.brandPrimary,
                                ),
                              ),
                              title: Text(
                                'admin.attendance.allSites'.tr(
                                  context: context,
                                ),
                              ),
                              onTap: () {
                                attendanceCubit.setSiteFilter(null);
                                Navigator.pop(sheetContext);
                              },
                            ),
                            for (final site in filtered)
                              ListTile(
                                leading: Icon(
                                  Icons.location_on_outlined,
                                  color: AppColors.placeholder,
                                ),
                                title: Text(site.name),
                                onTap: () {
                                  attendanceCubit.setSiteFilter(site.id);
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
            labelText: 'admin.attendance.site'.tr(context: context),
            labelStyle: AppTextStyles.font11Regular.copyWith(
              color: AppColors.textSecondary,
            ),
            prefixIcon: Icon(Icons.location_on_outlined, size: 18.r),
            suffixIcon: Icon(Icons.keyboard_arrow_down_rounded, size: 20.r),
          ),
          child: Text(
            selectedSiteName,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14Medium,
          ),
        ),
      ),
    );
  }
}

class _FilterSiteItem {
  const _FilterSiteItem({required this.id, required this.name});
  final String id;
  final String name;
}
