import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/admin_branches_cubit.dart';
import '../cubit/admin_customers_cubit.dart';
import 'admin_create_location_sheet_widget.dart';
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
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<AdminBranchesCubit>()),
            BlocProvider.value(value: context.read<AdminCustomersCubit>()),
          ],
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
