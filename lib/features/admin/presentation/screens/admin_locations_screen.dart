import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_branches_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_customers_bloc_builder_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_add_button_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_filter_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_tab_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/customer_visits/admin_my_visits_bloc_builder_widget.dart';

class AdminLocationsScreen extends StatefulWidget {
  const AdminLocationsScreen({super.key});

  @override
  State<AdminLocationsScreen> createState() => _AdminLocationsScreenState();
}

class _AdminLocationsScreenState extends State<AdminLocationsScreen> {
  int selectedIndex = 0;
  String? _currentUserRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    final storage = sl<AuthSessionStorage>();
    final role = await storage.readUserRole();
    if (mounted) {
      setState(() {
        _currentUserRole = role;
      });
    }
  }

  bool get _isAdmin =>
      (_currentUserRole?.toLowerCase() ?? '').contains('admin');

  List<String> get _tabLabels {
    if (_isAdmin) {
      return const [
        'admin.locations.tabs.branches',
        'admin.locations.tabs.customers',
        'admin.visits.title',
      ];
    } else {
      return const ['admin.locations.tabs.customers', 'admin.visits.myVisits'];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAdmin = _isAdmin;
    final labels = _tabLabels;
    final safeIndex = selectedIndex.clamp(0, labels.length - 1);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          isAdmin
              ? 'admin.locations.title'.tr(context: context)
              : 'employee.home.customerVisits'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.brandPrimary,
          onRefresh: () async {
            if (isAdmin) {
              if (safeIndex == 0) {
                await context.read<AdminBranchesCubit>().load();
              } else if (safeIndex == 1) {
                await context.read<AdminCustomersCubit>().load(
                  type: 'Customer',
                );
              } else {
                await context.read<AdminCustomerVisitsCubit>().loadAllVisits();
              }
            } else {
              if (safeIndex == 0) {
                await context.read<AdminCustomersCubit>().load(
                  type: 'Customer',
                );
              } else {
                await context.read<AdminCustomerVisitsCubit>().loadAllVisits();
              }
            }
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AdminLocationsFilterWidget(
                  selectedIndex: safeIndex,
                  labels: labels,
                  onSelected: (index) {
                    setState(() => selectedIndex = index);
                    if (isAdmin) {
                      if (index == 1) {
                        context.read<AdminCustomersCubit>().load(
                          type: 'Customer',
                        );
                      } else if (index == 2) {
                        context
                            .read<AdminCustomerVisitsCubit>()
                            .loadAllVisits();
                      }
                    } else {
                      if (index == 0) {
                        context.read<AdminCustomersCubit>().load(
                          type: 'Customer',
                        );
                      } else if (index == 1) {
                        context
                            .read<AdminCustomerVisitsCubit>()
                            .loadAllVisits();
                      }
                    }
                  },
                ),
                hSpace(14),
                if (isAdmin) ...[
                  if (safeIndex < 2) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'admin.locations.title'.tr(context: context),
                          style: AppTextStyles.font12Regular,
                        ),
                        AdminLocationsAddButtonWidget(
                          category: safeIndex == 0
                              ? AdminLocationCategory.branches
                              : AdminLocationCategory.customers,
                        ),
                      ],
                    ),
                    hSpace(10),
                  ],
                  if (safeIndex == 0)
                    const AdminBranchesBlocBuilderWidget()
                  else if (safeIndex == 1)
                    const AdminCustomersBlocBuilderWidget(type: 'customer')
                  else
                    const AdminMyVisitsBlocBuilderWidget(),
                ] else ...[
                  if (safeIndex == 0) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'admin.locations.title'.tr(context: context),
                          style: AppTextStyles.font12Regular,
                        ),
                        const AdminLocationsAddButtonWidget(
                          category: AdminLocationCategory.customers,
                        ),
                      ],
                    ),
                    hSpace(10),
                    const AdminCustomersBlocBuilderWidget(type: 'customer'),
                  ] else ...[
                    const AdminMyVisitsBlocBuilderWidget(),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
