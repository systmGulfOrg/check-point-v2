import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/routes/routes.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_worker_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_site_filter_chip_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/widgets/contractor_worker_qr_sheet_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';

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
    final sites = context.select<ContractorCubit, List<String>>(
      (cubit) =>
          cubit.state.mapOrNull(
            success: (value) =>
                value.sites.map((site) => site.siteName).toList(),
          ) ??
          const [],
    );
    final filtered = workers.where((w) {
      final matchesSearch =
          w.fullName.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          w.workerCode.toLowerCase().contains(
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
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'contractor.workers.searchHint'.tr(),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppColors.textSecondary,
                    ),
                    filled: true,
                    fillColor: AppColors.pageBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 10.h,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
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
                      SizedBox(width: 8.w),
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
