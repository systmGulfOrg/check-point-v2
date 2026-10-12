import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_worker_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../widgets/admin_add_contractor_sheet_widget.dart';
import '../widgets/admin_contractor_card_widget.dart';
import '../widgets/admin_contractor_details_sheet_widget.dart';

class AdminContractorsScreen extends StatefulWidget {
  const AdminContractorsScreen({super.key});

  @override
  State<AdminContractorsScreen> createState() => _AdminContractorsScreenState();
}

class _AdminContractorsScreenState extends State<AdminContractorsScreen> {
  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<ContractorCubit>().loadDashboardData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openAddSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ContractorCubit>(),
        child: const AdminAddContractorSheetWidget(),
      ),
    );
  }

  void _openContractorDetails({
    required ContractorCompanyModel contractor,
    required List<ContractorWorkerModel> workers,
    required List<ContractorAttendanceModel> attendanceLogs,
  }) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<ContractorCubit>(),
        child: AdminContractorDetailsSheetWidget(
          contractor: contractor,
          workers: workers,
          attendanceLogs: attendanceLogs,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          'admin.contractors.title'.tr(context: context),
          style: AppTextStyles.font18Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () => context.read<ContractorCubit>().loadDashboardData(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField(
                  hintText: 'admin.contractors.search'.tr(context: context),
                  controller: _searchController,
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.textSecondary,
                  ),
                  onChanged: (val) =>
                      setState(() => _searchQuery = val.trim().toLowerCase()),
                ),
                hSpace(14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'admin.contractors.title'.tr(context: context),
                      style: AppTextStyles.font14SemiBold.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    InkWell(
                      onTap: _openAddSheet,
                      borderRadius: BorderRadius.circular(8.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.add,
                              size: 16.r,
                              color: AppColors.brandPrimary,
                            ),
                            wSpace(4),
                            Text(
                              'admin.contractors.addContractor'.tr(
                                context: context,
                              ),
                              style: AppTextStyles.font12SemiBold.copyWith(
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                BlocBuilder<ContractorCubit, ContractorState>(
                  builder: (context, state) {
                    final isLoading = state.maybeMap(
                      loading: (_) => true,
                      initial: (_) => true,
                      orElse: () => false,
                    );

                    if (isLoading) {
                      return Skeletonizer(
                        enabled: true,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          separatorBuilder: (_, _) => hSpace(12),
                          itemBuilder: (_, index) =>
                              const AdminContractorCardWidget(
                            contractor: ContractorCompanyModel(
                              id: 'skeleton-id',
                              name: 'Loading Company Name...',
                              code: 'CTR-LOADING',
                              contactPhone: '01000000000',
                              contactEmail: 'info@contractor.com',
                              status: 'active',
                              workerCount: 0,
                            ),
                          ),
                        ),
                      );
                    }

                    final contractors = state.mapOrNull(
                          success: (s) => s.contractors,
                        ) ??
                        const [];
                    final allWorkers = state.mapOrNull(
                          success: (s) => s.workers,
                        ) ??
                        const [];
                    final allAttendance = state.mapOrNull(
                          success: (s) => s.attendanceLogs,
                        ) ??
                        const [];

                    final filtered = contractors.where((c) {
                      if (_searchQuery.isEmpty) return true;
                      final matchName = c.name.toLowerCase().contains(
                            _searchQuery,
                          );
                      final matchCode = c.code.toLowerCase().contains(
                            _searchQuery,
                          );
                      return matchName || matchCode;
                    }).toList();

                    if (filtered.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        child: Center(
                          child: Text(
                            'no_data'.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      );
                    }

                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      separatorBuilder: (context, index) => hSpace(12),
                      itemBuilder: (context, index) {
                        final item = filtered[index];
                        final contractorWorkers = allWorkers
                            .where((w) => w.contractorId == item.id)
                            .toList();
                        final contractorAttendance = allAttendance
                            .where((a) => a.contractorId == item.id)
                            .toList();

                        return AdminContractorCardWidget(
                          contractor: item,
                          onTap: () => _openContractorDetails(
                            contractor: item,
                            workers: contractorWorkers,
                            attendanceLogs: contractorAttendance,
                          ),
                        );
                      },
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
