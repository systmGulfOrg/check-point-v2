import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';

class SupervisorWorkerRollCallHeaderWidget extends StatelessWidget {
  const SupervisorWorkerRollCallHeaderWidget({
    required this.sites,
    required this.selectedSiteId,
    required this.selectedDate,
    required this.onSiteChanged,
    required this.onDateChanged,
    required this.onSearchChanged,
    required this.isAllSelected,
    required this.onSelectAllChanged,
    super.key,
  });

  final List<BranchModel> sites;
  final String? selectedSiteId;
  final DateTime selectedDate;
  final ValueChanged<String?> onSiteChanged;
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<String> onSearchChanged;
  final bool isAllSelected;
  final ValueChanged<bool> onSelectAllChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: sites.any((s) => s.id?.toString() == selectedSiteId)
                        ? selectedSiteId
                        : null,
                    hint: Text(
                      'contractorWorker.rollCall.selectSite'.tr(
                        context: context,
                      ),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    items: sites
                        .map(
                          (site) => DropdownMenuItem(
                            value: site.id?.toString(),
                            child: Text(
                              site.name ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.font14Medium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: onSiteChanged,
                  ),
                ),
              ),
            ),
            vSpace(8),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                if (picked != null) onDateChanged(picked);
              },
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Icon(
                  Icons.calendar_today_rounded,
                  color: AppColors.brandPrimary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        hSpace(8),
        TextField(
          onChanged: onSearchChanged,
          decoration: InputDecoration(
            hintText: 'search.hint'.tr(context: context),
            prefixIcon: const Icon(Icons.search, size: 20),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 8.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border),
            ),
          ),
        ),
        hSpace(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'contractorWorker.rollCall.selectWorkers'.tr(context: context),
              style: AppTextStyles.font14SemiBold.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
            TextButton.icon(
              onPressed: () => onSelectAllChanged(!isAllSelected),
              icon: Icon(
                isAllSelected ? Icons.deselect_rounded : Icons.select_all_rounded,
                size: 18,
                color: AppColors.brandPrimary,
              ),
              label: Text(
                isAllSelected
                    ? 'contractorWorker.rollCall.deselectAll'.tr(
                        context: context,
                      )
                    : 'contractorWorker.rollCall.selectAll'.tr(
                        context: context,
                      ),
                style: AppTextStyles.font12Medium.copyWith(
                  color: AppColors.brandPrimary,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
