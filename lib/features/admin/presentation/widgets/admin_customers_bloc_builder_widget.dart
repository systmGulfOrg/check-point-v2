import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_state.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/customer_visits/admin_customer_details_sheet_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'admin_create_location_sheet_widget.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';
import 'admin_locations_skeleton_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminCustomersBlocBuilderWidget extends StatefulWidget {
  const AdminCustomersBlocBuilderWidget({this.type = 'customer', super.key});

  final String type;

  @override
  State<AdminCustomersBlocBuilderWidget> createState() =>
      _AdminCustomersBlocBuilderWidgetState();
}

class _AdminCustomersBlocBuilderWidgetState
    extends State<AdminCustomersBlocBuilderWidget> {
  String? _currentUserRole;
  String? _currentUserName;

  @override
  void initState() {
    super.initState();
    _loadUserSession();
  }

  Future<void> _loadUserSession() async {
    final storage = sl<AuthSessionStorage>();
    final role = await storage.readUserRole();
    final name = await storage.readUserName();
    if (mounted) {
      setState(() {
        _currentUserRole = role;
        _currentUserName = name;
      });
    }
  }

  List<CustomerModel> _filterCustomers(List<CustomerModel> customers) {
    final role = _currentUserRole?.toLowerCase() ?? '';
    // Admins and SuperAdmins see all customers
    if (role.contains('admin')) {
      return customers;
    }

    final userName = _currentUserName?.trim().toLowerCase() ?? '';

    return customers.where((c) {
      final workesAs = c.workesAs?.trim().toLowerCase();
      // If workesAs is empty, unrestricted, or not set, visible to all
      if (workesAs == null ||
          workesAs.isEmpty ||
          workesAs == '-' ||
          workesAs == 'الكل' ||
          workesAs == 'all') {
        return true;
      }
      if (userName.isNotEmpty && workesAs.contains(userName)) {
        return true;
      }
      // Also match by partial tokens (e.g. if workesAs is "أحمد، محمد" and user is "أحمد" or "Ahmed")
      final tokens = workesAs
          .split(RegExp(r'[,،/|&\s]+'))
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty);
      for (final token in tokens) {
        if (token.isNotEmpty &&
            (userName.contains(token) || token.contains(userName))) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  void _showDeleteDialog(BuildContext context, String customerId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AdminDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.employees.deleteEmployeeMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminCustomersCubit>().delete(customerId);
        },
      ),
    );
  }

  void _showEditSheet(
    BuildContext context,
    String id,
    String currentName,
    String currentLocation,
    String? currentWorkesAs,
    List<LatLng> initialPoints,
  ) {
    const category = AdminLocationCategory.customers;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminCustomersCubit>(),
        child: AdminCreateLocationSheetWidget(
          category: category,
          editCustomerId: id,
          initialName: currentName,
          initialAddress: currentLocation,
          initialDescription: currentWorkesAs,
          initialPoints: initialPoints,
        ),
      ),
    );
  }

  void _openCustomerDetailsSheet(
    BuildContext context,
    CustomerModel customer,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => BlocProvider<AdminCustomerVisitsCubit>(
        create: (_) => sl<AdminCustomerVisitsCubit>(),
        child: AdminCustomerDetailsSheetWidget(
          customer: customer,
          onEdit: () {
            if (customer.id != null) {
              final points = (customer.coordinates ?? [])
                  .map((c) => LatLng(c.latitude, c.longitude))
                  .toList();
              _showEditSheet(
                context,
                customer.id!,
                customer.name ?? '',
                customer.location ?? '',
                customer.workesAs,
                points,
              );
            }
          },
          onDelete: () {
            if (customer.id != null) {
              _showDeleteDialog(context, customer.id!);
            }
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminCustomersCubit, AdminCustomersState>(
        builder: (context, state) => switch (state) {
          AdminCustomersInitial() => const AdminLocationsSkeletonWidget(),
          AdminCustomersLoading() => const AdminLocationsSkeletonWidget(),
          AdminCustomersError(:final messageKey) => Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              messageKey.tr(context: context),
              style: AppTextStyles.font14Regular,
            ),
          ),
          AdminCustomersSuccess(:final customers) => () {
            final visibleCustomers = _filterCustomers(customers);
            return visibleCustomers.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'admin.locations.empty'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  )
                : Column(
                    children: [
                      for (final customer in visibleCustomers) ...[
                        AdminLocationCardWidget(
                          location: AdminLocationData(
                            nameKey: customer.name ?? '-',
                            descriptionKey: customer.workesAs ?? '-',
                            addressKey: customer.location ?? '-',
                            statusKey: 'admin.locations.status.active',
                            icon: widget.type == 'site'
                                ? Icons.map_outlined
                                : Icons.people_outline_rounded,
                            iconColor: AppColors.info,
                            iconBackgroundColor: AppColors.softBlueBackground,
                          ),
                          onTap: () => _openCustomerDetailsSheet(context, customer),
                          onEdit: () {
                            if (customer.id != null) {
                              final points = (customer.coordinates ?? [])
                                  .map((c) => LatLng(c.latitude, c.longitude))
                                  .toList();
                              _showEditSheet(
                                context,
                                customer.id!,
                                customer.name ?? '',
                                customer.location ?? '',
                                customer.workesAs,
                                points,
                              );
                            }
                          },
                          onDelete: () {
                            if (customer.id != null) {
                              _showDeleteDialog(context, customer.id!);
                            }
                          },
                        ),
                        hSpace(10),
                      ],
                    ],
                  );
          }(),
          _ => const SizedBox.shrink(),
        },
      );
}
