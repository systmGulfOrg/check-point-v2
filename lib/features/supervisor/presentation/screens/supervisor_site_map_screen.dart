import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_polygon_geofence_map_widget.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_violation_tile_widget.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_cubit.dart';
import 'package:check_point_v2/features/contractor/presentation/cubit/contractor_state.dart';
import 'package:check_point_v2/core/app/app_spaces.dart';

class SupervisorSiteMapScreen extends StatefulWidget {
  const SupervisorSiteMapScreen({super.key});

  @override
  State<SupervisorSiteMapScreen> createState() =>
      _SupervisorSiteMapScreenState();
}

class _SupervisorSiteMapScreenState extends State<SupervisorSiteMapScreen> {
  bool _isPolygonMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: Text(
          'supervisor.samco.liveMap'.tr(),
          style: AppTextStyles.font16Bold.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: AppColors.cardBackground,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              _isPolygonMode
                  ? Icons.polyline_rounded
                  : Icons.radio_button_checked_rounded,
              color: AppColors.brandPrimary,
            ),
            tooltip: _isPolygonMode ? 'Polygon Mode' : 'Circle Mode',
            onPressed: () => setState(() => _isPolygonMode = !_isPolygonMode),
          ),
        ],
      ),
      body: BlocBuilder<ContractorCubit, ContractorState>(
        builder: (context, state) {
          final data = state.mapOrNull(success: (value) => value);
          final site = data?.sites.isNotEmpty == true
              ? data!.sites.first
              : null;
          final logs = data?.attendanceLogs ?? const [];
          final outside = logs.where((item) => !item.isInsideGeofence).toList();
          final mode = site?.boundaryType.toLowerCase() == 'polygon';
          return SingleChildScrollView(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SupervisorPolygonGeofenceMapWidget(
                  isPolygonMode: site == null ? _isPolygonMode : mode,
                  siteName:
                      site?.siteName ?? 'supervisor.samco.noAssignedSites'.tr(),
                  insideCount: logs.length - outside.length,
                  outsideCount: outside.length,
                ),
                hSpace(18),
                Text(
                  'supervisor.samco.geofenceViolations'.tr(),
                  style: AppTextStyles.font14Bold,
                ),
                hSpace(10),
                ...outside.map(
                  (item) => SupervisorViolationTileWidget(
                    name: item.workerName,
                    trade: item.jobTitle,
                    contractor: item.contractorId ?? '-',
                    distance: 'supervisor.samco.outsideBoundary'.tr(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
