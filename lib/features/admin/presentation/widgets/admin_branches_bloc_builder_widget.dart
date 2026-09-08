import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_state.dart';
import 'admin_branch_card_widget.dart';
import 'admin_delete_confirmation_dialog_widget.dart';
import 'admin_locations_skeleton_widget.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'admin_create_location_sheet_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminBranchesBlocBuilderWidget extends StatelessWidget {
  const AdminBranchesBlocBuilderWidget({super.key});

  void _showDeleteDialog(BuildContext context, int branchId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AdminDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.employees.deleteEmployeeMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminBranchesCubit>().delete(branchId);
        },
      ),
    );
  }

  void _showEditSheet(
    BuildContext context,
    int id,
    String currentName,
    String currentLocation,
    String currentDesc,
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
        value: context.read<AdminBranchesCubit>(),
        child: AdminCreateLocationSheetWidget(
          category: AdminLocationCategory.branches,
          editBranchId: id,
          initialName: currentName,
          initialAddress: currentLocation,
          initialDescription: currentDesc,
          initialPoints: initialPoints,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminBranchesCubit, AdminBranchesState>(
        builder: (context, state) => switch (state) {
          AdminBranchesInitial() => const SizedBox.shrink(),
          AdminBranchesLoading() => const AdminLocationsSkeletonWidget(),
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
                              final points = (branch.coordinates ?? [])
                                  .map((c) => LatLng(c.latitude, c.longitude))
                                  .toList();
                              _showEditSheet(
                                context,
                                branch.id!,
                                branch.name ?? '',
                                branch.location ?? '',
                                branch.description ?? '',
                                points,
                              );
                            }
                          },
                          onDelete: () {
                            if (branch.id != null) {
                              _showDeleteDialog(context, branch.id!);
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
