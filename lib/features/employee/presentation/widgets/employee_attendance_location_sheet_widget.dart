import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';

class EmployeeAttendanceLocationSheetWidget extends StatefulWidget {
  const EmployeeAttendanceLocationSheetWidget({
    required this.isCheckOut,
    super.key,
  });

  final bool isCheckOut;

  @override
  State<EmployeeAttendanceLocationSheetWidget> createState() =>
      _EmployeeAttendanceLocationSheetWidgetState();
}

class _EmployeeAttendanceLocationSheetWidgetState
    extends State<EmployeeAttendanceLocationSheetWidget> {
  String type = 'Branch';
  BranchModel? branch;
  CustomerModel? customer;
  LatLng? userLocation;
  GoogleMapController? mapController;
  bool isMapExpanded = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EmployeeAttendanceCubit>();
    cubit.loadBranches();
    _refreshLocation();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _refreshLocation(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _refreshLocation() async {
    final location = await context
        .read<EmployeeAttendanceCubit>()
        .refreshCurrentLocation();
    if (mounted) {
      setState(() => userLocation = location);
      if (location != null) {
        await mapController?.animateCamera(CameraUpdate.newLatLng(location));
      }
    }
  }

  List<LatLng> get targetPoints {
    if (type == 'Branch') {
      return (branch?.coordinates ?? [])
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
    }
    return (customer?.coordinates ?? [])
        .map((point) => LatLng(point.latitude, point.longitude))
        .toList();
  }

  LatLng? get targetCenter =>
      targetPoints.length == 1 ? targetPoints.first : null;

  bool get isInside =>
      userLocation != null &&
      targetPoints.isNotEmpty &&
      context.read<EmployeeAttendanceCubit>().isWithinAttendanceArea(
        point: userLocation!,
        center: targetCenter,
        polygon: targetCenter == null ? targetPoints : const [],
      );

  void _focusTarget() {
    final target =
        targetCenter ?? (targetPoints.isEmpty ? null : targetPoints.first);
    if (target != null) {
      mapController?.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
    }
  }

  void _changeType(String value) {
    setState(() {
      type = value;
      branch = null;
      customer = null;
    });
    if (value != 'Branch') {
      context.read<EmployeeAttendanceCubit>().loadCustomersByType(value);
    }
  }

  Future<void> _submit() async {
    if (!isInside) return;
    final cubit = context.read<EmployeeAttendanceCubit>();
    if (widget.isCheckOut) {
      await cubit.checkOut(
        targetCenter: targetCenter,
        targetPolygon: targetCenter == null ? targetPoints : const [],
      );
    } else {
      await cubit.checkIn(
        area: type,
        customerId: customer?.id,
        locationLabel: branch?.location ?? customer?.location,
        targetCenter: targetCenter,
        targetPolygon: targetCenter == null ? targetPoints : const [],
      );
    }
    if (!mounted) return;
    final state = cubit.state;
    if (state is EmployeeAttendanceStateCheckInSuccess ||
        state is EmployeeAttendanceStateCheckOutSuccess) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
        child: SingleChildScrollView(
          child: BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
            builder: (context, state) {
              final branches = switch (state) {
                EmployeeAttendanceStateBranchesLoaded(:final branches) =>
                  branches,
                _ => const <BranchModel>[],
              };
              final customers = switch (state) {
                EmployeeAttendanceStateTargetsLoaded(:final targets) => targets,
                _ => const <CustomerModel>[],
              };
              if (type == 'Branch' && branch == null && branches.isNotEmpty) {
                branch = branches.first;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _focusTarget(),
                );
              }
              if (type != 'Branch' &&
                  customer == null &&
                  customers.isNotEmpty) {
                customer = customers.first;
                WidgetsBinding.instance.addPostFrameCallback(
                  (_) => _focusTarget(),
                );
              }
              final points = targetPoints;
              final mapCenter =
                  targetCenter ??
                  userLocation ??
                  const LatLng(30.0444, 31.2357);
              final isLoadingTargets = state is EmployeeAttendanceStateLoading;
              if (points.isEmpty) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isCheckOut
                          ? 'employee.home.checkOutAction'.tr()
                          : 'employee.home.checkInAction'.tr(),
                      style: AppTextStyles.font20Bold,
                    ),
                    hSpace(20),
                    Center(
                      child: isLoadingTargets
                          ? const CircularProgressIndicator()
                          : Text(
                              'attendance.noLocationData'.tr(),
                              style: AppTextStyles.font14SemiBold,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ],
                );
              }
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.isCheckOut
                        ? 'employee.home.checkOutAction'.tr()
                        : 'employee.home.checkInAction'.tr(),
                    style: AppTextStyles.font20Bold,
                  ),
                  hSpace(12),
                  Text(
                    'attendance.locationType'.tr(),
                    style: AppTextStyles.font14SemiBold,
                  ),
                  hSpace(6),
                  SegmentedButton<String>(
                    segments: [
                      ButtonSegment(
                        value: 'Branch',
                        label: Text('attendance.branch'.tr()),
                      ),
                      ButtonSegment(
                        value: 'Customer',
                        label: Text('attendance.customer'.tr()),
                      ),
                      ButtonSegment(
                        value: 'Site',
                        label: Text('attendance.site'.tr()),
                      ),
                    ],
                    selected: {type},
                    onSelectionChanged: (values) => _changeType(values.first),
                  ),
                  hSpace(8),
                  DropdownButtonFormField<String>(
                    initialValue: type == 'Branch'
                        ? branch?.id?.toString()
                        : customer?.id,
                    decoration: InputDecoration(
                      labelText: 'attendance.location'.tr(),
                    ),
                    items: type == 'Branch'
                        ? branches
                              .where((item) => item.id != null)
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.id.toString(),
                                  child: Text(item.name ?? 'Branch'),
                                ),
                              )
                              .toList()
                        : customers
                              .where((item) => item.id != null)
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.id,
                                  child: Text(item.name ?? type),
                                ),
                              )
                              .toList(),
                    onChanged: (value) => setState(() {
                      if (type == 'Branch') {
                        branch = branches.firstWhere(
                          (item) => item.id.toString() == value,
                        );
                      } else {
                        customer = customers.firstWhere(
                          (item) => item.id == value,
                        );
                      }
                      WidgetsBinding.instance.addPostFrameCallback(
                        (_) => _focusTarget(),
                      );
                    }),
                  ),
                  hSpace(12),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    height: isMapExpanded ? 500.h : 260.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Stack(
                        children: [
                          GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: mapCenter,
                              zoom: 15,
                            ),
                            onMapCreated: (controller) =>
                                mapController = controller,
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
                                  infoWindow: InfoWindow(
                                    title: 'attendance.myLocation'.tr(),
                                  ),
                                ),
                              if (points.isNotEmpty)
                                Marker(
                                  markerId: const MarkerId('target'),
                                  position: points.first,
                                  icon: BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueOrange,
                                  ),
                                  infoWindow: InfoWindow(
                                    title: type,
                                    snippet: branch?.name ?? customer?.name,
                                  ),
                                ),
                            },
                            polylines: userLocation != null && points.isNotEmpty
                                ? {
                                    Polyline(
                                      polylineId: const PolylineId(
                                        'user-to-target',
                                      ),
                                      points: [userLocation!, points.first],
                                      color: AppColors.info,
                                      width: 4,
                                    ),
                                  }
                                : const {},
                            polygons: points.length > 2
                                ? {
                                    Polygon(
                                      polygonId: const PolygonId('target'),
                                      points: points,
                                      fillColor: AppColors.brandPrimary
                                          .withValues(alpha: .18),
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
                                      fillColor: AppColors.brandPrimary
                                          .withValues(alpha: .18),
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
                                tooltip: isMapExpanded
                                    ? 'attendance.collapseMap'.tr()
                                    : 'attendance.expandMap'.tr(),
                                icon: Icon(
                                  isMapExpanded
                                      ? Icons.fullscreen_exit
                                      : Icons.fullscreen,
                                  color: AppColors.textPrimary,
                                ),
                                onPressed: () => setState(
                                  () => isMapExpanded = !isMapExpanded,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  hSpace(10),
                  Text(
                    isInside
                        ? 'attendance.insideArea'.tr()
                        : 'attendance.outsideArea'.tr(),
                    style: AppTextStyles.font14SemiBold.copyWith(
                      color: isInside ? AppColors.success : AppColors.error,
                    ),
                  ),
                  hSpace(10),
                  CustomButton(
                    text: widget.isCheckOut
                        ? 'employee.home.checkOutAction'.tr()
                        : 'employee.home.checkInAction'.tr(),
                    isLoading: state is EmployeeAttendanceStateLoading,
                    enabled: isInside,
                    onTap: isInside ? _submit : () {},
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
