import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'attendance_target_details_widget.dart';

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
  List<BranchModel> availableBranches = const [];
  List<CustomerModel> availableCustomers = const [];
  String? targetAddress;
  bool isAddressLoading = false;
  int addressRequestId = 0;

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
    mapController = null;
    super.dispose();
  }

  Future<void> _refreshLocation() async {
    final location = await context
        .read<EmployeeAttendanceCubit>()
        .refreshCurrentLocation();
    if (mounted) {
      setState(() => userLocation = location);
      if (location != null && mounted) {
        final controller = mapController;
        if (controller != null) {
          try {
            await controller.animateCamera(CameraUpdate.newLatLng(location));
          } catch (_) {
            // The map can be disposed while a location request is in flight.
          }
        }
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
    if (target != null && mounted) {
      final controller = mapController;
      if (controller != null) {
        try {
          controller.animateCamera(CameraUpdate.newLatLngZoom(target, 16));
        } catch (_) {
          // The map controller is no longer valid after sheet disposal.
        }
      }
    }
  }

  void _changeType(String value) {
    setState(() {
      type = value;
      branch = null;
      customer = null;
      targetAddress = null;
      if (value != 'Branch') {
        availableCustomers = const [];
      }
    });
    if (value != 'Branch') {
      context.read<EmployeeAttendanceCubit>().loadCustomersByType(value);
    }
  }

  Future<void> _loadTargetAddress() async {
    final points = targetPoints;
    if (points.isEmpty) {
      if (mounted) {
        setState(() {
          targetAddress = null;
          isAddressLoading = false;
        });
      }
      return;
    }

    final requestId = ++addressRequestId;
    setState(() => isAddressLoading = true);
    final address = await context
        .read<EmployeeAttendanceCubit>()
        .attendanceVerificationService
        .locationService
        .getAddressFromCoordinates(
          points.first.latitude,
          points.first.longitude,
        );
    if (!mounted || requestId != addressRequestId) return;
    setState(() {
      targetAddress = address ?? (branch?.location ?? customer?.location);
      isAddressLoading = false;
    });
  }

  void _copyTargetAddress() {
    final address = targetAddress ?? branch?.location ?? customer?.location;
    if (address == null) return;
    Clipboard.setData(ClipboardData(text: address));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('attendance.addressCopied'.tr())));
  }

  void _copyTargetCoordinates() {
    final points = targetPoints;
    if (points.isEmpty) return;
    Clipboard.setData(
      ClipboardData(
        text:
            '${points.first.latitude}, '
            '${points.first.longitude}',
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('attendance.coordinatesCopied'.tr())),
    );
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
              switch (state) {
                case EmployeeAttendanceStateBranchesLoaded(:final branches):
                  availableBranches = branches;
                case EmployeeAttendanceStateTargetsLoaded(:final targets):
                  availableCustomers = targets;
                default:
                  break;
              }
              final branchOptions = availableBranches.isNotEmpty
                  ? availableBranches
                  : branches;
              final customerOptions = availableCustomers.isNotEmpty
                  ? availableCustomers
                  : customers;
              if (type == 'Branch' &&
                  branch == null &&
                  branchOptions.isNotEmpty) {
                branch = branchOptions.first;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _focusTarget();
                  _loadTargetAddress();
                });
              }
              if (type != 'Branch' &&
                  customer == null &&
                  customerOptions.isNotEmpty) {
                customer = customerOptions.first;
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _focusTarget();
                  _loadTargetAddress();
                });
              }
              final points = targetPoints;
              final mapCenter =
                  targetCenter ??
                  userLocation ??
                  const LatLng(30.0444, 31.2357);
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
                  Container(
                    padding: EdgeInsets.all(4.r),
                    decoration: BoxDecoration(
                      color: AppColors.pageBackground,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: [
                        for (final option in [
                          ('Branch', 'attendance.branch'),
                          ('Customer', 'attendance.customer'),
                          ('Site', 'attendance.site'),
                        ])
                          Expanded(
                            child: Semantics(
                              button: true,
                              selected: type == option.$1,
                              label: option.$2.tr(),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(16.r),
                                onTap: () => _changeType(option.$1),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  decoration: BoxDecoration(
                                    color: type == option.$1
                                        ? AppColors.selectedBackground
                                        : AppColors.transparent,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: type == option.$1
                                        ? const [
                                            BoxShadow(
                                              color: AppColors.shadow,
                                              blurRadius: 4,
                                              offset: Offset(0, 1),
                                            ),
                                          ]
                                        : null,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (type == option.$1) ...[
                                        Icon(
                                          Icons.check_rounded,
                                          size: 16.r,
                                          color: AppColors.brandPrimaryDark,
                                        ),
                                        wSpace(4),
                                      ],
                                      Text(
                                        option.$2.tr(),
                                        style: AppTextStyles.font12SemiBold
                                            .copyWith(
                                              color: type == option.$1
                                                  ? AppColors.textPrimary
                                                  : AppColors.textSecondary,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
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
                        ? branchOptions
                              .where((item) => item.id != null)
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item.id.toString(),
                                  child: Text(item.name ?? 'Branch'),
                                ),
                              )
                              .toList()
                        : customerOptions
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
                        branch = branchOptions.firstWhere(
                          (item) => item.id.toString() == value,
                        );
                      } else {
                        customer = customerOptions.firstWhere(
                          (item) => item.id == value,
                        );
                      }
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _focusTarget();
                        _loadTargetAddress();
                      });
                    }),
                  ),
                  if (points.isEmpty) ...[
                    hSpace(20),
                    Center(
                      child: state is EmployeeAttendanceStateLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'attendance.noLocationData'.tr(),
                              style: AppTextStyles.font14SemiBold,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ] else ...[
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
                              polylines:
                                  userLocation != null && points.isNotEmpty
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
                    AttendanceTargetDetailsWidget(
                      name: branch?.name ?? customer?.name ?? type,
                      address:
                          targetAddress ??
                          branch?.location ??
                          customer?.location,
                      coordinates:
                          '${points.first.latitude.toStringAsFixed(6)}, '
                          '${points.first.longitude.toStringAsFixed(6)}',
                      isAddressLoading: isAddressLoading,
                      onCopyAddress: _copyTargetAddress,
                      onCopyCoordinates: _copyTargetCoordinates,
                    ),
                    hSpace(10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.r),
                      decoration: BoxDecoration(
                        color: userLocation == null
                            ? AppColors.pageBackground
                            : isInside
                            ? AppColors.softGreenBackground
                            : AppColors.softRedBackground,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: userLocation == null
                              ? AppColors.border
                              : isInside
                              ? AppColors.success.withValues(alpha: .35)
                              : AppColors.error.withValues(alpha: .35),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            userLocation == null
                                ? Icons.gps_fixed_rounded
                                : isInside
                                ? Icons.check_circle_rounded
                                : Icons.location_off_rounded,
                            color: userLocation == null
                                ? AppColors.textSecondary
                                : isInside
                                ? AppColors.success
                                : AppColors.error,
                            size: 22.r,
                          ),
                          wSpace(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userLocation == null
                                      ? 'attendance.locationLoading'.tr()
                                      : isInside
                                      ? 'attendance.insideArea'.tr()
                                      : 'attendance.outsideArea'.tr(),
                                  style: AppTextStyles.font14SemiBold.copyWith(
                                    color: userLocation == null
                                        ? AppColors.textPrimary
                                        : isInside
                                        ? AppColors.success
                                        : AppColors.error,
                                  ),
                                ),
                                hSpace(4),
                                Text(
                                  isInside
                                      ? 'attendance.readyNote'.tr()
                                      : 'attendance.moveToLocationNote'.tr(),
                                  style: AppTextStyles.font12Regular.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    hSpace(8),
                    Text(
                      'attendance.securityNote'.tr(),
                      style: AppTextStyles.font12Regular.copyWith(
                        color: AppColors.textSecondary,
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
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
