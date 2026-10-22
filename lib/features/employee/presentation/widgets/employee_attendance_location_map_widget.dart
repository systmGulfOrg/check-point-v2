import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';

class EmployeeAttendanceLocationMapWidget extends StatelessWidget {
  const EmployeeAttendanceLocationMapWidget({
    required this.isExpanded,
    required this.mapCenter,
    required this.userLocation,
    required this.targetPoints,
    required this.targetCenter,
    required this.targetType,
    required this.targetName,
    required this.onMapCreated,
    required this.onToggleExpanded,
    super.key,
  });

  final bool isExpanded;
  final LatLng mapCenter;
  final LatLng? userLocation;
  final List<LatLng> targetPoints;
  final LatLng? targetCenter;
  final String targetType;
  final String? targetName;
  final ValueChanged<GoogleMapController> onMapCreated;
  final VoidCallback onToggleExpanded;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      height: isExpanded ? 500.h : 260.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: mapCenter,
                zoom: 15,
              ),
              onMapCreated: onMapCreated,
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
              myLocationButtonEnabled: true,
              markers: {
                if (userLocation != null)
                  Marker(
                    markerId: const MarkerId('user'),
                    position: userLocation!,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueAzure,
                    ),
                    infoWindow: InfoWindow(title: 'attendance.myLocation'.tr()),
                  ),
                if (targetPoints.isNotEmpty)
                  Marker(
                    markerId: const MarkerId('target'),
                    position: targetPoints.first,
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                      BitmapDescriptor.hueOrange,
                    ),
                    infoWindow: InfoWindow(
                      title: targetType,
                      snippet: targetName,
                    ),
                  ),
              },
              polylines: userLocation != null && targetPoints.isNotEmpty
                  ? {
                      Polyline(
                        polylineId: const PolylineId('user-to-target'),
                        points: [userLocation!, targetPoints.first],
                        color: AppColors.info,
                        width: 4,
                      ),
                    }
                  : const {},
              polygons: targetPoints.length > 2
                  ? {
                      Polygon(
                        polygonId: const PolygonId('target'),
                        points: targetPoints,
                        fillColor: AppColors.brandPrimary.withValues(
                          alpha: .18,
                        ),
                        strokeColor: AppColors.brandPrimary,
                        strokeWidth: 3,
                      ),
                    }
                  : const {},
              circles: targetCenter == null
                  ? const {}
                  : {
                      Circle(
                        circleId: const CircleId('target'),
                        center: targetCenter!,
                        radius: 150,
                        fillColor: AppColors.brandPrimary.withValues(
                          alpha: .18,
                        ),
                        strokeColor: AppColors.brandPrimary,
                        strokeWidth: 3,
                      ),
                    },
            ),
            PositionedDirectional(
              top: 10.h,
              end: 10.w,
              child: Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10.r),
                child: IconButton(
                  tooltip: isExpanded
                      ? 'attendance.collapseMap'.tr()
                      : 'attendance.expandMap'.tr(),
                  icon: Icon(
                    isExpanded ? Icons.fullscreen_exit : Icons.fullscreen,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: onToggleExpanded,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
