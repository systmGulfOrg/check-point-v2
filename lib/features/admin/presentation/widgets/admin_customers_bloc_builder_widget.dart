import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../data/models/customer_request_model.dart';
import '../cubit/admin_customers_cubit.dart';
import '../cubit/admin_customers_state.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_location_card_widget.dart';
import 'admin_location_data.dart';

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

  void _showEditDialog(
    BuildContext context,
    String id,
    String currentName,
    String currentLocation,
  ) {
    final nameController = TextEditingController(text: currentName);
    final locationController = TextEditingController(text: currentLocation);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(type == 'site' ? 'Edit Site' : 'Edit Customer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                context.read<AdminCustomersCubit>().edit(
                      id,
                      CustomerRequestModel(
                        name: nameController.text.trim(),
                        location: locationController.text.trim(),
                        customerType: type,
                      ),
                    );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminCustomersCubit, AdminCustomersState>(
        builder: (context, state) => switch (state) {
          AdminCustomersInitial() => const SizedBox.shrink(),
          AdminCustomersLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          AdminCustomersError(:final messageKey) => Padding(
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
                : Column(
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
                              _showEditDialog(
                                context,
                                customer.id!,
                                customer.name ?? '',
                                customer.location ?? '',
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
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
