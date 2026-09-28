import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_company_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import '../widgets/admin_add_contractor_sheet_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'admin.contractors.title'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddSheet,
        backgroundColor: AppColors.brandPrimary,
        icon: const Icon(Icons.add_rounded, color: AppColors.white),
        label: Text(
          'admin.contractors.addContractor'.tr(),
          style: AppTextStyles.font14Medium.copyWith(color: AppColors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.white,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: CustomTextFormField(
              hintText: 'admin.contractors.search'.tr(),
              controller: _searchController,
              prefixIcon: const Icon(
                Icons.search_rounded,
                color: AppColors.textSecondary,
              ),
              onChanged: (val) => setState(() => _searchQuery = val.trim().toLowerCase()),
            ),
          ),
          Expanded(
            child: BlocBuilder<ContractorCubit, ContractorState>(
              builder: (context, state) {
                final contractors = state.mapOrNull(
                      success: (s) => s.contractors,
                    ) ??
                    const [];

                final filtered = contractors.where((c) {
                  if (_searchQuery.isEmpty) return true;
                  final matchName = c.name.toLowerCase().contains(_searchQuery);
                  final matchCode = c.code.toLowerCase().contains(_searchQuery);
                  return matchName || matchCode;
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      'no_data'.tr(),
                      style: AppTextStyles.font14Regular.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  );
                }

                return ListView.separated(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 80.h),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => hSpace(12),
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return _ContractorCard(contractor: item);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContractorCard extends StatelessWidget {
  const _ContractorCard({required this.contractor});

  final ContractorCompanyModel contractor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.border),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  contractor.name,
                  style: AppTextStyles.font16Bold.copyWith(
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: contractor.status == 'active'
                      ? AppColors.softGreenBackground
                      : AppColors.softYellowBackground,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  contractor.status == 'active'
                      ? 'admin.contractors.active'.tr()
                      : 'admin.contractors.inactive'.tr(),
                  style: AppTextStyles.font12Bold.copyWith(
                    color: contractor.status == 'active'
                        ? AppColors.success
                        : AppColors.warningOrange,
                  ),
                ),
              ),
            ],
          ),
          hSpace(8),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.softBrandBackground,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  contractor.code,
                  style: AppTextStyles.font12Bold.copyWith(
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
              vSpace(12),
              if (contractor.taxNumber != null)
                Text(
                  '${'admin.contractors.taxNumber'.tr()}: ${contractor.taxNumber}',
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
          hSpace(12),
          const Divider(height: 1, color: AppColors.border),
          hSpace(12),
          Row(
            children: [
              Icon(
                Icons.person_outline_rounded,
                size: 16.r,
                color: AppColors.textSecondary,
              ),
              vSpace(6),
              Text(
                contractor.contactName ?? '',
                style: AppTextStyles.font13Medium.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              if (contractor.contactPhone != null) ...[
                Icon(
                  Icons.phone_outlined,
                  size: 16.r,
                  color: AppColors.textSecondary,
                ),
                vSpace(4),
                Text(
                  contractor.contactPhone!,
                  style: AppTextStyles.font12Regular.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
