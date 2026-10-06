import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/contractor/data/models/site_boundary_model.dart';
import 'package:check_point_v2/features/contractor/data/models/contractor_attendance_model.dart';

class SupervisorPolygonGeofenceMapWidget extends StatefulWidget {
  const SupervisorPolygonGeofenceMapWidget({
    super.key,
    required this.site,
    required this.attendance,
    required this.insideCount,
    required this.outsideCount,
  });

  final SiteBoundaryModel? site;
  final List<ContractorAttendanceModel> attendance;
  final int insideCount;
  final int outsideCount;

  @override
  State<SupervisorPolygonGeofenceMapWidget> createState() =>
      _SupervisorPolygonGeofenceMapWidgetState();
}

class _SupervisorPolygonGeofenceMapWidgetState
    extends State<SupervisorPolygonGeofenceMapWidget> {
  GoogleMapController? _mapController;
  bool _isExpanded = false;
  MapType _mapType = MapType.normal;

  LatLng _computeCenter() {
    final site = widget.site;
    if (site == null) {
      return const LatLng(30.0444, 31.2357); // Cairo default
    }

    if (site.centerLat != null && site.centerLng != null) {
      return LatLng(site.centerLat!, site.centerLng!);
    }

    if (site.boundaryCoordinates.isNotEmpty) {
      final lats = site.boundaryCoordinates.map((c) => c.lat).toList();
      final lngs = site.boundaryCoordinates.map((c) => c.lng).toList();
      final avgLat = lats.reduce((a, b) => a + b) / lats.length;
      final avgLng = lngs.reduce((a, b) => a + b) / lngs.length;
      return LatLng(avgLat, avgLng);
    }

    return const LatLng(30.0444, 31.2357);
  }

  Set<Polygon> _buildPolygons() {
    final site = widget.site;
    if (site == null || site.boundaryType.toLowerCase() != 'polygon') {
      return const {};
    }

    if (site.boundaryCoordinates.length < 3) {
      return const {};
    }

    final points = site.boundaryCoordinates
        .map((coord) => LatLng(coord.lat, coord.lng))
        .toList();

    return {
      Polygon(
        polygonId: PolygonId(site.siteId.isNotEmpty ? site.siteId : 'site-polygon'),
        points: points,
        strokeColor: AppColors.brandPrimary,
        strokeWidth: 3,
        fillColor: AppColors.brandPrimary.withValues(alpha: 0.18),
      ),
    };
  }

  Set<Circle> _buildCircles() {
    final site = widget.site;
    if (site == null || site.boundaryType.toLowerCase() == 'polygon') {
      return const {};
    }

    final center = _computeCenter();
    return {
      Circle(
        circleId: CircleId(site.siteId.isNotEmpty ? site.siteId : 'site-circle'),
        center: center,
        radius: site.radiusMeters > 0 ? site.radiusMeters : 250.0,
        strokeColor: AppColors.brandPrimary,
        strokeWidth: 3,
        fillColor: AppColors.brandPrimary.withValues(alpha: 0.18),
      ),
    };
  }

  Set<Marker> _buildMarkers() {
    final markers = <Marker>{};
    final site = widget.site;
    final center = _computeCenter();

    // Site Center / Main Pin
    markers.add(
      Marker(
        markerId: const MarkerId('site-center'),
        position: center,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        infoWindow: InfoWindow(
          title: site?.siteName ?? 'Site Location',
          snippet: site?.projectName ?? 'Active Construction Sector',
        ),
      ),
    );

    // Boundary vertex markers (P1, P2, P3...) if polygon
    if (site != null &&
        site.boundaryType.toLowerCase() == 'polygon' &&
        site.boundaryCoordinates.isNotEmpty) {
      for (var i = 0; i < site.boundaryCoordinates.length; i++) {
        final coord = site.boundaryCoordinates[i];
        markers.add(
          Marker(
            markerId: MarkerId('vertex-$i'),
            position: LatLng(coord.lat, coord.lng),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
            infoWindow: InfoWindow(
              title: 'P${i + 1} Boundary Vertex',
              snippet: '${coord.lat.toStringAsFixed(5)}, ${coord.lng.toStringAsFixed(5)}',
            ),
          ),
        );
      }
    }

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final site = widget.site;
    final isPolygon = site?.boundaryType.toLowerCase() == 'polygon' &&
        (site?.boundaryCoordinates.length ?? 0) >= 3;
    final center = _computeCenter();

    return AnimatedContainer(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeInOutCubic,
      height: _isExpanded ? 460.h : 280.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.darkPageBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.darkCardBorder),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withValues(alpha: 0.25),
            blurRadius: 14.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: center,
                zoom: isPolygon ? 16.5 : 15.5,
              ),
              mapType: _mapType,
              onMapCreated: (controller) {
                _mapController = controller;
              },
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  EagerGestureRecognizer.new,
                ),
              },
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              rotateGesturesEnabled: true,
              tiltGesturesEnabled: true,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              polygons: _buildPolygons(),
              circles: _buildCircles(),
              markers: _buildMarkers(),
            ),

            // Top control bar
            Positioned(
              top: 12.h,
              left: 12.w,
              right: 12.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: AppColors.darkCardBackground.withValues(alpha: 0.90),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: AppColors.darkCardBorder),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isPolygon
                              ? Icons.polyline_rounded
                              : Icons.radio_button_checked_rounded,
                          color: AppColors.brandPrimary,
                          size: 16.r,
                        ),
                        wSpace(6),
                        Text(
                          isPolygon
                              ? 'Polygon Plot (${site!.boundaryCoordinates.length} Vertices)'
                              : 'Circle Geofence (${site?.radiusMeters.toInt() ?? 250}m)',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.darkTextPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Satellite switch button
                      AppInteractiveScaleWidget(
                        onTap: () {
                          setState(() {
                            _mapType = _mapType == MapType.normal
                                ? MapType.satellite
                                : MapType.normal;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                            color: AppColors.darkCardBackground.withValues(alpha: 0.90),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.darkCardBorder),
                          ),
                          child: Icon(
                            _mapType == MapType.normal
                                ? Icons.satellite_alt_rounded
                                : Icons.map_rounded,
                            color: AppColors.darkTextPrimary,
                            size: 16.r,
                          ),
                        ),
                      ),
                      wSpace(8),
                      // Expand / Collapse button
                      AppInteractiveScaleWidget(
                        onTap: () => setState(() => _isExpanded = !_isExpanded),
                        child: Container(
                          padding: EdgeInsets.all(7.r),
                          decoration: BoxDecoration(
                            color: AppColors.darkCardBackground.withValues(alpha: 0.90),
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColors.darkCardBorder),
                          ),
                          child: Icon(
                            _isExpanded ? Icons.fullscreen_exit : Icons.fullscreen,
                            color: AppColors.darkTextPrimary,
                            size: 16.r,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Live status & Center GPS button
            Positioned(
              right: 12.w,
              bottom: 60.h,
              child: AppInteractiveScaleWidget(
                onTap: () {
                  if (_mapController != null) {
                    _mapController!.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(target: center, zoom: isPolygon ? 16.5 : 15.5),
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: AppColors.darkCardBackground.withValues(alpha: 0.92),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.darkCardBorder),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.my_location_rounded,
                    color: AppColors.brandPrimary,
                    size: 18.r,
                  ),
                ),
              ),
            ),

            // Bottom summary pill
            Positioned(
              bottom: 12.h,
              left: 12.w,
              right: 12.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColors.darkCardBackground.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.darkCardBorder),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        wSpace(6),
                        Text(
                          '${widget.insideCount} ${'supervisor.samco.insideBoundary'.tr()}',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: AppColors.darkTextPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 1.w,
                      height: 16.h,
                      color: AppColors.darkCardBorder,
                    ),
                    Row(
                      children: [
                        Container(
                          width: 8.r,
                          height: 8.r,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                        wSpace(6),
                        Text(
                          '${widget.outsideCount} ${'supervisor.samco.outsideGeofenceShort'.tr()}',
                          style: AppTextStyles.font11Medium.copyWith(
                            color: widget.outsideCount > 0
                                ? AppColors.error
                                : AppColors.darkTextSecondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
