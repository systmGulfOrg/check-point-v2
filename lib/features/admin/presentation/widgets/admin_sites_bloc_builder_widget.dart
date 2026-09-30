import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_branches_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_site_members_screen.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_create_location_sheet_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_skeleton_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_tab_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_site_card_widget.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminSitesBlocBuilderWidget extends StatelessWidget {
  const AdminSitesBlocBuilderWidget({super.key});

  void _showEditSheet(
    BuildContext context,
    SiteBoundaryModel site,
  ) {
    final initialPoints = <LatLng>[];
    if (site.centerLat != null && site.centerLng != null) {
      initialPoints.add(LatLng(site.centerLat!, site.centerLng!));
    }
    for (final c in site.boundaryCoordinates) {
      initialPoints.add(LatLng(c.lat, c.lng));
    }

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: context.read<AdminBranchesCubit>()),
          BlocProvider.value(value: context.read<ContractorCubit>()),
        ],
        child: AdminCreateLocationSheetWidget(
          category: AdminLocationCategory.sites,
          editCustomerId: site.siteId,
          initialName: site.siteName,
          initialAddress: site.projectName ?? '',
          initialDescription: site.projectName ?? '',
          initialPoints: initialPoints,
        ),
      ),
    );
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<ContractorCubit, ContractorState>(
    builder: (context, state) => state.when(
      initial: () => const AdminLocationsSkeletonWidget(),
      loading: () => const AdminLocationsSkeletonWidget(),
      error: (message) => Padding(
        padding: EdgeInsets.all(24.r),
        child: Text(message.tr(context: context)),
      ),
      success:
          (
            contractors,
            workers,
            attendanceLogs,
            corrections,
            sites,
            assignments,
            selectedSiteBoundary,
            customization,
            pendingOfflineCount,
            message,
          ) {
            if (sites.isEmpty) {
              return Padding(
                padding: EdgeInsets.all(24.r),
                child: Center(
                  child: Text(
                    'admin.locations.empty'.tr(context: context),
                    style: AppTextStyles.font14Regular.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }
            return Column(
              children: [
                for (final site in sites) ...[
                  AdminSiteCardWidget(
                    site: site,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AppRoutes.adminSiteMembers,
                        arguments: AdminSiteMembersArgs(site: site),
                      );
                    },
                    onEdit: () => _showEditSheet(context, site),
                  ),
                  hSpace(10),
                ],
              ],
            );
          },
    ),
  );
}
