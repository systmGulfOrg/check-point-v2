import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/presentation/screens/admin_site_members_screen.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_locations_skeleton_widget.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/admin_site_card_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminSitesBlocBuilderWidget extends StatelessWidget {
  const AdminSitesBlocBuilderWidget({super.key});

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
                  ),
                  hSpace(10),
                ],
              ],
            );
          },
    ),
  );
}
