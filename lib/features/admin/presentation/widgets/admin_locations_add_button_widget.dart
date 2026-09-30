import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'admin_create_location_sheet_widget.dart';
import 'admin_create_site_sheet_widget.dart';
import 'admin_locations_tab_widget.dart';

class AdminLocationsAddButtonWidget extends StatelessWidget {
  const AdminLocationsAddButtonWidget({required this.category, super.key});

  final AdminLocationCategory category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: AppColors.cardBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => category == AdminLocationCategory.sites
            ? BlocProvider.value(
                value: context.read<ContractorCubit>(),
                child: const AdminCreateSiteSheetWidget(),
              )
            : BlocProvider.value(
                value: context.read<AdminBranchesCubit>(),
                child: AdminCreateLocationSheetWidget(category: category),
              ),
      ),
      child: Text(
        'admin.locations.add'.tr(context: context),
        style: AppTextStyles.font13SemiBold.copyWith(
          color: AppColors.brandPrimary,
        ),
      ),
    );
  }
}
