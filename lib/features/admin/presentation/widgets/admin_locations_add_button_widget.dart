import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (_) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<AdminBranchesCubit>()),
            BlocProvider.value(value: context.read<ContractorCubit>()),
          ],
          child: AdminCreateLocationSheetWidget(category: category),
        ),
      ),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: AppColors.softBrandBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: 16.r,
              color: AppColors.brandPrimary,
            ),
            wSpace(4),
            Text(
              'admin.locations.add'.tr(context: context).replaceAll('+ ', '').replaceAll('+', '').trim(),
              style: AppTextStyles.font12SemiBold.copyWith(
                color: AppColors.brandPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
