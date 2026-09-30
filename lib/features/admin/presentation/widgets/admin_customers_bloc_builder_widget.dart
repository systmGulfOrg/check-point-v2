import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'admin_create_location_sheet_widget.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';
import 'admin_locations_skeleton_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminCustomersBlocBuilderWidget extends StatelessWidget {
  const AdminCustomersBlocBuilderWidget({this.type = 'customer', super.key});

  final String type;

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
          category: AdminLocationCategory.sites,
          editCustomerId: id,
          initialName: currentName,
          initialAddress: currentLocation,
          initialDescription: currentWorkesAs,
          initialPoints: initialPoints,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminCustomersCubit, AdminCustomersState>(
        builder: (context, state) => switch (state) {
          // The route starts loading immediately, but the first frame can
          // still be rendered while the cubit is in its initial state. Keep
          // the layout in a loading state instead of showing a false empty
          // message before the API response arrives.
          AdminCustomersInitial() => const AdminLocationsSkeletonWidget(),
          AdminCustomersLoading() => const AdminLocationsSkeletonWidget(),
          AdminCustomersError(:final messageKey) =>
            context.read<AdminCustomersCubit>().customers.isNotEmpty
                ? _buildList(
                    context,
                    context.read<AdminCustomersCubit>().customers,
                  )
                : Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      messageKey.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  ),
          AdminCustomersSuccess(:final customers) =>
            customers.isEmpty
                ? Padding(
                    padding: const EdgeInsets.all(24),
                    child: Text(
                      'admin.locations.empty'.tr(context: context),
                      style: AppTextStyles.font14Regular,
                    ),
                  )
                : _buildList(context, customers),
          _ => const SizedBox.shrink(),
        },
      );

  Widget _buildList(BuildContext context, List<CustomerModel> customers) {
    return Column(
      children: [
        for (final customer in customers) ...[
          AdminLocationCardWidget(
            location: AdminLocationData(
              nameKey: customer.name ?? '-',
              descriptionKey: customer.workesAs ?? '-',
              addressKey: customer.location ?? '-',
              statusKey: 'admin.locations.status.active',
              icon: type == 'site'
                  ? Icons.map_outlined
                  : Icons.people_outline_rounded,
              iconColor: AppColors.info,
              iconBackgroundColor: AppColors.softBlueBackground,
            ),
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
  }
}
