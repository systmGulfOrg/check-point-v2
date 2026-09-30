import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';

class AdminSitesBlocBuilderWidget extends StatelessWidget {
  const AdminSitesBlocBuilderWidget({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<ContractorCubit, ContractorState>(
    builder: (context, state) => state.when(
      initial: () => const Center(child: CircularProgressIndicator()),
      loading: () => const Center(child: CircularProgressIndicator()),
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
                child: Text('admin.locations.empty'.tr(context: context)),
              );
            }
            return Column(
              children: [
                for (final site in sites) ...[
                  ListTile(
                    tileColor: AppColors.cardBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14.r),
                      side: const BorderSide(color: AppColors.border),
                    ),
                    leading: Icon(
                      site.boundaryType == 'polygon'
                          ? Icons.polyline
                          : Icons.radio_button_checked,
                      color: AppColors.brandPrimary,
                    ),
                    title: Text(site.siteName, style: AppTextStyles.font14Bold),
                    subtitle: Text(
                      '${site.projectName ?? '-'} • ${site.workerCount} ${'supervisor.samco.totalWorkers'.tr(context: context)}',
                    ),
                    trailing: Text(site.status.tr(context: context)),
                  ),
                  hSpace(10),
                ],
              ],
            );
          },
    ),
  );
}
