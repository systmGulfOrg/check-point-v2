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
  bool isWorkScheduleLoading = true;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<EmployeeAttendanceCubit>();
    _loadWorkSchedule();
    cubit.loadBranches();
    _refreshLocation();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _refreshLocation(),
    );
  }

  Future<void> _loadWorkSchedule() async {
    final profile = await context
        .read<EmployeeAttendanceCubit>()
        .loadEmployeeProfile();
    if (!mounted) return;
    setState(() => isWorkScheduleLoading = false);
    final mode = profile?.todayWorkMode;
    if (!widget.isCheckOut && mode == 'remote') {
      _changeType('Remote');
    } else if (mode == 'onsite' && type == 'Remote') {
      _changeType('Branch');
    }
  }

  Set<String> get allowedTypes {
    if (widget.isCheckOut || isWorkScheduleLoading) {
      return const {'Branch', 'Customer', 'Site', 'Remote'};
    }
    return switch (context.read<EmployeeAttendanceCubit>().employeeProfile?.todayWorkMode) {
      'remote' => const {'Remote'},
      'onsite' => const {'Branch', 'Customer', 'Site'},
      _ => const <String>{},
    };
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
    if (type == 'Remote') return const [];
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
      type == 'Remote' || (userLocation != null &&
      targetPoints.isNotEmpty &&
      context.read<EmployeeAttendanceCubit>().isWithinAttendanceArea(
        point: userLocation!,
        center: targetCenter,
        polygon: targetCenter == null ? targetPoints : const [],
      ));

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
    if (value == 'Customer' || value == 'Site') {
      context.read<EmployeeAttendanceCubit>().loadCustomersByType(value);
    }
  }

  Future<void> _loadTargetAddress() async {
    final points = targetPoints;
    final savedAddress = branch?.location ?? customer?.location;
    if (points.isEmpty) {
      if (mounted) {
        setState(() {
          targetAddress = null;
          isAddressLoading = false;
        });
      }
      return;
    }

    if (savedAddress != null && savedAddress.trim().isNotEmpty) {
      if (mounted) {
        setState(() {
          targetAddress = savedAddress;
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
    if (!widget.isCheckOut && (isWorkScheduleLoading || !allowedTypes.contains(type))) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('attendance.workScheduleUnavailable'.tr(context: context))),
      );
      return;
    }
    if (type != 'Remote' && !isInside) {
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
                          allowedTypes: allowedTypes,
                        ),
                        if (!widget.isCheckOut) ...[
                          hSpace(8),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(12.r),
                            decoration: BoxDecoration(
                              color: AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: isWorkScheduleLoading
                                ? Text('attendance.loadingWorkSchedule'.tr())
                                : Text(
                                    'attendance.workScheduleSummary'.tr(
                                      namedArgs: {
                                        'system': (context.read<EmployeeAttendanceCubit>().employeeProfile?.workSystem ?? 'onsite').tr(),
                                        'mode': (context.read<EmployeeAttendanceCubit>().employeeProfile?.todayWorkMode ?? 'off').tr(),
                                        'day': context.read<EmployeeAttendanceCubit>().employeeProfile?.todayWorkDay ?? '--',
                                        'start': context.read<EmployeeAttendanceCubit>().employeeProfile?.todayWorkStart ?? '--:--',
                                        'end': context.read<EmployeeAttendanceCubit>().employeeProfile?.todayWorkEnd ?? '--:--',
                                      },
                                    ),
                                    style: AppTextStyles.font12Regular,
                                  ),
                          ),
                        ],
                        hSpace(8),
                        if (type != 'Remote')
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
                        if (type == 'Remote') ...[
                          hSpace(18),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(16.r),
                            decoration: BoxDecoration(
                              color: AppColors.softBlueBackground,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: Text(
                              'attendance.remoteDescription'.tr(
                                context: context,
                              ),
                            ),
                          ),
                          hSpace(12),
                          CustomButton(
                            text: widget.isCheckOut
                                ? 'employee.home.checkOutAction'.tr()
                                : 'employee.home.checkInAction'.tr(),
                            isLoading: state is EmployeeAttendanceStateLoading,
                            enabled: true,
                            onTap: _submit,
                          ),
                        ] else if (points.isEmpty) ...[
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
