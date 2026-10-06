import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/core/widgets/custom_text_form_field.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_worker_card_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_batch_attendance_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_site_filter_chip_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_worker_qr_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class ContractorWorkersScreen extends StatefulWidget {
  const ContractorWorkersScreen({super.key});

  @override
  State<ContractorWorkersScreen> createState() =>
      _ContractorWorkersScreenState();
}

class _ContractorWorkersScreenState extends State<ContractorWorkersScreen> {
  late final TextEditingController _searchController;
  String _selectedSiteFilter = 'All';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workers = context
        .select<ContractorCubit, List<ContractorWorkerModel>>(
          (cubit) =>
              cubit.state.mapOrNull(success: (value) => value.workers) ??
              const [],
        );
    final siteModels = context.select<ContractorCubit, List<SiteBoundaryModel>>(
      (cubit) =>
          cubit.state.mapOrNull(success: (value) => value.sites) ?? const [],
    );
    final contractorId = context.select<ContractorCubit, String?>(
      (cubit) => cubit.state.mapOrNull(
        success: (value) =>
            value.contractors.isNotEmpty ? value.contractors.first.id : null,
      ),
    );
    final sites = siteModels.map((site) => site.siteName).toList();
    final filtered = workers.where((w) {
      final matchesSearch =
          w.displayName.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          w.displayCode.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          );
      final matchesSite =
          _selectedSiteFilter == 'All' || w.siteName == _selectedSiteFilter;
      return matchesSearch && matchesSite;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'contractor.workers.title'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        actions: [
          if (workers.isNotEmpty && contractorId != null)
            IconButton(
              icon: const Icon(
                Icons.checklist_rtl_rounded,
                color: AppColors.brandPrimary,
              ),
              tooltip: 'تسجيل الحضور الجماعي',
              onPressed: () {
                final contractorCubit = context.read<ContractorCubit>();
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => BlocProvider.value(
                    value: contractorCubit,
                    child: ContractorBatchAttendanceSheetWidget(
                      workers: workers,
                      sites: siteModels,
                      contractorId: contractorId,
                    ),
                  ),
                );
              },
            ),
          IconButton(
            icon: const Icon(
              Icons.person_add_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.contractorAddWorker),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: AppColors.cardBackground,
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  hintText: 'contractor.workers.searchHint'.tr(),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                  ),
                ),
                hSpace(10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ContractorSiteFilterChipWidget(
                        label: 'contractor.workers.allSites'.tr(),
                        isSelected: _selectedSiteFilter == 'All',
                        onSelected: (_) =>
                            setState(() => _selectedSiteFilter = 'All'),
                      ),
                      wSpace(8),
                      ...sites.map(
                        (site) => Padding(
                          padding: EdgeInsetsDirectional.only(end: 8.w),
                          child: ContractorSiteFilterChipWidget(
                            label: site,
                            isSelected: _selectedSiteFilter == site,
                            onSelected: (_) =>
                                setState(() => _selectedSiteFilter = site),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final worker = filtered[index];
                return ContractorWorkerCardWidget(
                  worker: worker,
                  onQrTap: () => showModalBottomSheet<void>(
                    context: context,
                    backgroundColor: AppColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20.r),
                      ),
                    ),
                    builder: (_) =>
                        ContractorWorkerQrSheetWidget(worker: worker),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
