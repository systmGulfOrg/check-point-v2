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
import 'employee_attendance_location_map_widget.dart';
import 'employee_attendance_location_status_widget.dart';
import 'employee_attendance_location_type_selector_widget.dart';
import 'employee_attendance_target_dropdown_widget.dart';

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

  Future<void> _submit() async {
    if (!isInside) {
      final messageKey = userLocation == null
          ? 'errors.locationUnavailable'
          : targetPoints.isEmpty
          ? 'attendance.noLocationData'
          : 'errors.outsideAttendanceArea';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(messageKey.tr(context: context)),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }
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
    return BlocListener<EmployeeAttendanceCubit, EmployeeAttendanceState>(
      listener: (context, state) {
        switch (state) {
          case EmployeeAttendanceStateError(:final messageKey):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(messageKey.tr(context: context)),
                backgroundColor: AppColors.error,
              ),
            );
          default:
            break;
        }
      },
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
          child: SingleChildScrollView(
            child:
                BlocBuilder<EmployeeAttendanceCubit, EmployeeAttendanceState>(
                  builder: (context, state) {
                    final branches = switch (state) {
                      EmployeeAttendanceStateBranchesLoaded(:final branches) =>
                        branches,
                      _ => const <BranchModel>[],
                    };
                    final customers = switch (state) {
                      EmployeeAttendanceStateTargetsLoaded(:final targets) =>
                        targets,
                      _ => const <CustomerModel>[],
                    };
                    switch (state) {
                      case EmployeeAttendanceStateBranchesLoaded(
                        :final branches,
                      ):
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
                        EmployeeAttendanceLocationTypeSelectorWidget(
                          selectedType: type,
                          onTypeChanged: _changeType,
                        ),
                        hSpace(8),
                        EmployeeAttendanceTargetDropdownWidget(
                          type: type,
                          branches: branchOptions,
                          customers: customerOptions,
                          selectedBranch: branch,
                          selectedCustomer: customer,
                          onBranchChanged: (selected) {
                            setState(() => branch = selected);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _focusTarget();
                              _loadTargetAddress();
                            });
                          },
                          onCustomerChanged: (selected) {
                            setState(() => customer = selected);
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              _focusTarget();
                              _loadTargetAddress();
                            });
                          },
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
                          EmployeeAttendanceLocationMapWidget(
                            isExpanded: isMapExpanded,
                            mapCenter: mapCenter,
                            userLocation: userLocation,
                            targetPoints: points,
                            targetCenter: targetCenter,
                            targetType: type,
                            targetName: branch?.name ?? customer?.name,
                            onMapCreated: (controller) =>
                                mapController = controller,
                            onToggleExpanded: () =>
                                setState(() => isMapExpanded = !isMapExpanded),
                          ),
                          hSpace(10),
                          AttendanceTargetDetailsWidget(
                            name: branch?.name ?? customer?.name ?? type,
                            address:
                                targetAddress ??
                                branch?.location ??
                                customer?.location,
                            isAddressLoading: isAddressLoading,
                            onCopyAddress: _copyTargetAddress,
                          ),
                          hSpace(10),
                          EmployeeAttendanceLocationStatusWidget(
                            userLocation: userLocation,
                            isInside: isInside,
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
                            enabled: true,
                            onTap: _submit,
                          ),
                        ],
                      ],
                    );
                  },
                ),
          ),
        ),
      ),
    );
  }
}
