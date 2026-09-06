import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../../data/models/branch_request_model.dart';
import '../cubit/admin_branches_cubit.dart';
import '../cubit/admin_branches_state.dart';
import 'admin_branch_card_widget.dart';

class AdminBranchesBlocBuilderWidget extends StatelessWidget {
  const AdminBranchesBlocBuilderWidget({super.key});

  void _showEditDialog(
    BuildContext context,
    int id,
    String currentName,
    String currentLocation,
    String currentDesc,
  ) {
    final nameController = TextEditingController(text: currentName);
    final locationController = TextEditingController(text: currentLocation);
    final descController = TextEditingController(text: currentDesc);
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Branch'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Branch Name'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
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
                context.read<AdminBranchesCubit>().edit(
                      id: id,
                      request: BranchRequestModel(
                        name: nameController.text.trim(),
                        location: locationController.text.trim(),
                        description: descController.text.trim(),
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
      BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
        builder: (context, state) => switch (state) {
          AdminBranchesInitial() => const SizedBox.shrink(),
          AdminBranchesLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          AdminBranchesError(:final messageKey) => Text(
            messageKey.tr(context: context),
          ),
          AdminBranchesSuccess(:final branches) =>
            branches.isEmpty
                ? Text('admin.locations.empty'.tr(context: context))
                : Column(
                    children: [
                      for (final branch in branches) ...[
                        AdminBranchCardWidget(
                          branch: branch,
                          onEdit: () {
                            if (branch.id != null) {
                              _showEditDialog(
                                context,
                                branch.id!,
                                branch.name ?? '',
                                branch.location ?? '',
                                branch.description ?? '',
                              );
                            }
                          },
                          onDelete: () => context
                              .read<AdminBranchesCubit>()
                              .delete(branch.id ?? 0),
                        ),
                        hSpace(10),
                      ],
                    ],
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
