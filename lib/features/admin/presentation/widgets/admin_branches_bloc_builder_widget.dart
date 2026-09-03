import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/admin_branches_cubit.dart';
import '../cubit/admin_branches_state.dart';
import 'admin_branch_card_widget.dart';

class AdminBranchesBlocBuilderWidget extends StatelessWidget {
  const AdminBranchesBlocBuilderWidget({super.key});

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
