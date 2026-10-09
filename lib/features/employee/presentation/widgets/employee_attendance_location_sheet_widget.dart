import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/locations/branch_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_customer_visits_repo.dart';
import 'package:check_point_v2/features/admin/presentation/widgets/customer_visits/admin_record_visit_outcome_dialog_widget.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_cubit.dart';
import 'package:check_point_v2/features/employee/presentation/cubit/attendance/employee_attendance_state.dart';
import 'attendance_target_details_widget.dart';
import 'employee_attendance_location_map_widget.dart';
import 'employee_attendance_location_status_widget.dart';
import 'employee_attendance_location_type_selector_widget.dart';
import 'employee_attendance_target_dropdown_widget.dart';
import 'employee_attended_visit_card_widget.dart';

class EmployeeAttendanceLocationSheetWidget extends StatefulWidget {
  const EmployeeAttendanceLocationSheetWidget({
    required this.isCheckOut,
    this.initialCustomer,
    this.initialVisit,
    this.initialType,
    super.key,
  });

  final bool isCheckOut;
  final CustomerModel? initialCustomer;
  final CustomerVisitModel? initialVisit;
  final String? initialType;

  @override
  State<EmployeeAttendanceLocationSheetWidget> createState() =>
      _EmployeeAttendanceLocationSheetWidgetState();
}

class _EmployeeAttendanceLocationSheetWidgetState
    extends State<EmployeeAttendanceLocationSheetWidget> {
  String type = 'Branch';
  BranchModel? branch;
  CustomerModel? customer;
  CustomerVisitModel? todayScheduledVisit;
  List<CustomerVisitModel> todayVisits = const [];
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
    final hasClockIn = cubit.hasClockIn(cubit.todayAttendance);
    final hasClockOut = cubit.hasClockOut(cubit.todayAttendance);
    final mode = cubit.employeeProfile?.todayWorkMode ?? 'onsite';

    if (widget.initialVisit != null) {
      type = widget.initialType ?? 'Customer';
      todayScheduledVisit = widget.initialVisit;
      cubit.loadCustomersByType('Customer');
    } else if (widget.initialCustomer != null) {
      type = widget.initialType ?? 'Customer';
      customer = widget.initialCustomer;
      cubit.loadCustomersByType('Customer');
    } else if (!widget.isCheckOut && (hasClockIn || hasClockOut)) {
      type = 'Customer';
      cubit.loadCustomersByType('Customer');
    } else if (mode == 'remote') {
      type = 'Remote';
    } else {
      type = 'Branch';
      cubit.loadBranches();
    }

    _initScheduleAndVisits();
    _refreshLocation();
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _refreshLocation(),
    );
  }

  int _compareVisitTimes(String? a, String? b) {
    if (a == null || a.isEmpty) return 1;
    if (b == null || b.isEmpty) return -1;
    final minutesA = _parseTimeToMinutes(a);
    final minutesB = _parseTimeToMinutes(b);
    return minutesA.compareTo(minutesB);
  }

  int _parseTimeToMinutes(String timeStr) {
    try {
      final clean = timeStr.trim();
      final isPm = clean.contains('م') || clean.toLowerCase().contains('pm');
      final isAm = clean.contains('ص') || clean.toLowerCase().contains('am');

      final numbers = clean.replaceAll(RegExp(r'[^0-9:]'), '');
      final parts = numbers.split(':');
      if (parts.isEmpty) return 0;

      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = parts.length > 1 ? (int.tryParse(parts[1]) ?? 0) : 0;

      if (isPm && hours < 12) {
        hours += 12;
      } else if (isAm && hours == 12) {
        hours = 0;
      }
      return hours * 60 + minutes;
    } catch (_) {
      return 0;
    }
  }

  Future<void> _initScheduleAndVisits() async {
    final profile = await context
        .read<EmployeeAttendanceCubit>()
        .loadEmployeeProfile();
    if (!mounted) return;

    List<CustomerVisitModel> visits = [];
    try {
      final result = await sl<AdminCustomerVisitsRepo>().getAllVisits();
      if (result case Success(:final data)) {
        final todayStr = AppDateFormatter.formatYearMonthDay(DateTime.now());
        final currentEmpId = profile?.id;
        final currentEmpName = profile?.name?.trim().toLowerCase();

        visits = data.where((v) {
          if (v.status == 'cancelled') return false;
          final isToday = v.visitDate == todayStr ||
              v.visitDate?.startsWith(todayStr) == true;
          if (!isToday) return false;

          final isAttendeeId = currentEmpId != null &&
              v.attendees.contains(currentEmpId);
          final isAttendeeName = currentEmpName != null &&
              v.attendees.any((a) => a.toLowerCase().contains(currentEmpName));
          final isCreator = v.createdBy == currentEmpId;
          return isAttendeeId || isAttendeeName || isCreator;
        }).toList();

        visits.sort((a, b) => _compareVisitTimes(a.visitTime, b.visitTime));
      }
    } catch (_) {}

    if (!mounted) return;

    final activeVisit = visits
            .where((v) => v.status != 'visited' && v.status != 'completed')
            .firstOrNull ??
        visits.firstOrNull;

    setState(() {
      isWorkScheduleLoading = false;
      todayVisits = visits;
      todayScheduledVisit = activeVisit;
    });

    final mode = profile?.todayWorkMode ?? 'onsite';
    final hasClockIn = context
        .read<EmployeeAttendanceCubit>()
        .hasClockIn(context.read<EmployeeAttendanceCubit>().todayAttendance);
    final hasClockOut = context
        .read<EmployeeAttendanceCubit>()
        .hasClockOut(context.read<EmployeeAttendanceCubit>().todayAttendance);

    if (!widget.isCheckOut && (hasClockIn || hasClockOut)) {
      _changeType('Customer');
    } else if (activeVisit != null) {
      _changeType('Customer');
    } else if (mode == 'remote') {
      _changeType('Remote');
    } else {
      _changeType('Branch');
    }
  }

  Set<String> get allowedTypes {
    final cubit = context.read<EmployeeAttendanceCubit>();
    final mode = cubit.employeeProfile?.todayWorkMode ?? 'onsite';
    final hasClockIn = cubit.hasClockIn(cubit.todayAttendance);
    final hasClockOut = cubit.hasClockOut(cubit.todayAttendance);

    final types = <String>{};

    if (widget.isCheckOut) {
      if (mode == 'remote') {
        types.add('Remote');
      } else {
        types.add('Branch');
      }
      types.add('Customer');
      return types;
    }

    if (!hasClockIn && !hasClockOut) {
      if (mode == 'remote') {
        types.add('Remote');
      } else {
        types.add('Branch');
      }
    }

    types.add('Customer');

    return types;
  }

  void _showDisabledTypeMessage(String value) {
    final cubit = context.read<EmployeeAttendanceCubit>();
    final hasClockIn = cubit.hasClockIn(cubit.todayAttendance);
    final hasClockOut = cubit.hasClockOut(cubit.todayAttendance);

    if (!widget.isCheckOut && (hasClockIn || hasClockOut) && (value == 'Branch' || value == 'Remote')) {
      CustomSnackBar.showError(
        context,
        message: 'attendance.alreadyCheckedInOffice'.tr(context: context),
      );
      return;
    }

    if (value == 'Customer' && todayScheduledVisit == null && availableCustomers.isEmpty) {
      CustomSnackBar.showError(
        context,
        message: 'attendance.noCustomerVisitToday'.tr(context: context),
      );
      return;
    }

    final mode = cubit.employeeProfile?.todayWorkMode;
    final messageKey = switch (mode) {
      'remote' => 'attendance.remoteWorkDayLocationMessage',
      'onsite' => 'attendance.onsiteWorkDayLocationMessage',
      _ => 'attendance.unscheduledWorkDayLocationMessage',
    };
    CustomSnackBar.showError(
      context,
      message: messageKey.tr(context: context),
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
      type == 'Remote' ||
      (userLocation != null &&
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
      if (value == 'Branch') {
        availableCustomers = const [];
      } else if (value == 'Customer') {
        availableBranches = const [];
      }
    });
    if (value == 'Customer') {
      context.read<EmployeeAttendanceCubit>().loadCustomersByType('Customer');
    } else if (value == 'Branch') {
      context.read<EmployeeAttendanceCubit>().loadBranches();
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
    if (!widget.isCheckOut && !allowedTypes.contains(type)) {
      _showDisabledTypeMessage(type);
      return;
    }
    if (type != 'Remote' && !isInside) {
      final messageKey = userLocation == null
          ? 'errors.locationUnavailable'
          : targetPoints.isEmpty
          ? 'attendance.noLocationData'
          : 'errors.outsideAttendanceArea';
      CustomSnackBar.showError(
        context,
        message: messageKey.tr(context: context),
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
      if (type == 'Customer' && todayScheduledVisit != null) {
        final visitId = todayScheduledVisit?.id;
        if (visitId != null && visitId.isNotEmpty) {
          unawaited(
            sl<AdminCustomerVisitsRepo>().updateVisitOutcome(
              visitId: visitId,
              outcome: todayScheduledVisit?.outcome ?? '',
              status: 'visited',
              notes: todayScheduledVisit?.notes,
              documentName: todayScheduledVisit?.documentName,
              documentUrl: todayScheduledVisit?.documentUrl,
            ),
          );
        }
      }
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
            CustomSnackBar.showError(
              context,
              message: messageKey.tr(context: context),
            );
          default:
            break;
        }
      },
      child: SafeArea(
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
                  EmployeeAttendanceStateTargetsLoaded(:final targets) =>
                    targets,
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
                final sortedCustomerOptions = List<CustomerModel>.from(customerOptions);
                sortedCustomerOptions.sort((a, b) {
                  final visitA = todayVisits
                      .where((v) => v.customerId == a.id)
                      .firstOrNull;
                  final visitB = todayVisits
                      .where((v) => v.customerId == b.id)
                      .firstOrNull;
                  if (visitA != null && visitB != null) {
                    return _compareVisitTimes(
                      visitA.visitTime,
                      visitB.visitTime,
                    );
                  }
                  if (visitA != null) return -1;
                  if (visitB != null) return 1;
                  return (a.name ?? '').compareTo(b.name ?? '');
                });

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
                    sortedCustomerOptions.isNotEmpty) {
                  if (todayScheduledVisit != null) {
                    final matching = sortedCustomerOptions
                        .where((c) => c.id == todayScheduledVisit!.customerId)
                        .firstOrNull;
                    customer = matching ?? sortedCustomerOptions.first;
                  } else {
                    customer = sortedCustomerOptions.first;
                  }
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
                    if (todayVisits.isNotEmpty) ...[
                      hSpace(8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.softBrandBackground,
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.brandPrimary.withValues(
                              alpha: 0.4,
                            ),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(6.r),
                                  decoration: const BoxDecoration(
                                    color: AppColors.brandPrimary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.route_rounded,
                                    color: AppColors.white,
                                    size: 15.r,
                                  ),
                                ),
                                wSpace(8),
                                Expanded(
                                  child: Text(
                                    todayVisits.length == 1
                                        ? 'زيارة عميل مجدولة اليوم'
                                        : 'جدول زيارات اليوم (${todayVisits.length} زيارات مرتبة بالوقت)',
                                    style: AppTextStyles.font12Bold.copyWith(
                                      color: AppColors.brandPrimaryDark,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            hSpace(8),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  for (int i = 0; i < todayVisits.length; i++) ...[
                                    if (i > 0)
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 4.w,
                                        ),
                                        child: Icon(
                                          Icons.arrow_back_rounded,
                                          size: 14.r,
                                          color: AppColors.placeholder,
                                        ),
                                      ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          todayScheduledVisit = todayVisits[i];
                                          final matchingCust =
                                              sortedCustomerOptions
                                                  .where(
                                                    (c) =>
                                                        c.id ==
                                                        todayVisits[i].customerId,
                                                  )
                                                  .firstOrNull;
                                          if (matchingCust != null) {
                                            customer = matchingCust;
                                          }
                                        });
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          _focusTarget();
                                          _loadTargetAddress();
                                        });
                                      },
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                          vertical: 6.h,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              todayScheduledVisit?.id ==
                                                      todayVisits[i].id
                                                  ? AppColors.brandPrimary
                                                  : AppColors.cardBackground,
                                          borderRadius: BorderRadius.circular(
                                            8.r,
                                          ),
                                          border: Border.all(
                                            color:
                                                todayScheduledVisit?.id ==
                                                        todayVisits[i].id
                                                    ? AppColors.brandPrimary
                                                    : AppColors.border,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              todayVisits[i].visitTime !=
                                                          null &&
                                                      todayVisits[i]
                                                          .visitTime!
                                                          .isNotEmpty
                                                  ? '🕒 ${todayVisits[i].visitTime} '
                                                  : '',
                                              style: AppTextStyles.font11Bold
                                                  .copyWith(
                                                    color:
                                                        todayScheduledVisit
                                                                    ?.id ==
                                                                todayVisits[i]
                                                                    .id
                                                            ? AppColors.white
                                                            : AppColors
                                                                .brandPrimary,
                                                  ),
                                            ),
                                            Text(
                                              todayVisits[i].customerName ??
                                                  'عميل',
                                              style: AppTextStyles.font11Medium
                                                  .copyWith(
                                                    color:
                                                        todayScheduledVisit
                                                                    ?.id ==
                                                                todayVisits[i]
                                                                    .id
                                                            ? AppColors.white
                                                            : AppColors
                                                                .textPrimary,
                                                  ),
                                            ),
                                            if (todayVisits[i].status ==
                                                'completed') ...[
                                              wSpace(4),
                                              Icon(
                                                Icons.check_circle_rounded,
                                                size: 12.r,
                                                color:
                                                    todayScheduledVisit?.id ==
                                                            todayVisits[i].id
                                                        ? AppColors.white
                                                        : AppColors.success,
                                              ),
                                            ] else if (todayVisits[i].status ==
                                                'visited') ...[
                                              wSpace(4),
                                              Icon(
                                                Icons.pending_actions_rounded,
                                                size: 12.r,
                                                color:
                                                    todayScheduledVisit?.id ==
                                                            todayVisits[i].id
                                                        ? AppColors.white
                                                        : AppColors.warning,
                                              ),
                                            ],
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      onDisabledTypeTap: _showDisabledTypeMessage,
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
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (context
                                          .read<EmployeeAttendanceCubit>()
                                          .employeeProfile
                                          ?.todayWorkMode ==
                                      'remote')
                                    Text(
                                      'attendance.todayWorkFromHome'.tr(
                                        context: context,
                                      ),
                                      style: AppTextStyles.font14SemiBold
                                          .copyWith(color: AppColors.info),
                                    ),
                                  if (context
                                          .read<EmployeeAttendanceCubit>()
                                          .employeeProfile
                                          ?.todayWorkMode ==
                                      'onsite')
                                    Text(
                                      'attendance.todayWorkFromOffice'.tr(
                                        context: context,
                                      ),
                                      style: AppTextStyles.font14SemiBold
                                          .copyWith(
                                            color: AppColors.brandPrimaryDark,
                                          ),
                                    ),
                                  if (context
                                              .read<EmployeeAttendanceCubit>()
                                              .employeeProfile
                                              ?.todayWorkMode ==
                                          'remote' ||
                                      context
                                              .read<EmployeeAttendanceCubit>()
                                              .employeeProfile
                                              ?.todayWorkMode ==
                                          'onsite')
                                    hSpace(4),
                                  Text(
                                    'attendance.workScheduleSummary'.tr(
                                      namedArgs: {
                                        'system':
                                            (context
                                                        .read<
                                                          EmployeeAttendanceCubit
                                                        >()
                                                        .employeeProfile
                                                        ?.workSystem ??
                                                    'onsite')
                                                .tr(),
                                        'mode':
                                            (context
                                                        .read<
                                                          EmployeeAttendanceCubit
                                                        >()
                                                        .employeeProfile
                                                        ?.todayWorkMode ??
                                                    'off')
                                                .tr(),
                                        'day':
                                            context
                                                .read<EmployeeAttendanceCubit>()
                                                .employeeProfile
                                                ?.todayWorkDay ??
                                            '--',
                                        'start':
                                            AppDateFormatter.formatTimeString(
                                              context
                                                  .read<EmployeeAttendanceCubit>()
                                                  .employeeProfile
                                                  ?.todayWorkStart ??
                                              context
                                                  .read<EmployeeAttendanceCubit>()
                                                  .employeeProfile
                                                  ?.workPolicy
                                                  ?.workingHoursStart,
                                            ),
                                        'end':
                                            AppDateFormatter.formatTimeString(
                                              context
                                                  .read<EmployeeAttendanceCubit>()
                                                  .employeeProfile
                                                  ?.todayWorkEnd ??
                                              context
                                                  .read<EmployeeAttendanceCubit>()
                                                  .employeeProfile
                                                  ?.workPolicy
                                                  ?.workingHoursEnd,
                                            ),
                                      },
                                    ),
                                    style: AppTextStyles.font12Regular,
                                  ),
                                ],
                              ),
                      ),
                    ],
                    hSpace(8),
                    if (type != 'Remote')
                      EmployeeAttendanceTargetDropdownWidget(
                        type: type,
                        branches: branchOptions,
                        customers: sortedCustomerOptions,
                        todayVisits: todayVisits,
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
                          setState(() {
                            customer = selected;
                            final matchingVisits = todayVisits
                                .where((v) => v.customerId == selected.id)
                                .toList();
                            final active = matchingVisits
                                    .where((v) =>
                                        v.status != 'visited' &&
                                        v.status != 'completed')
                                    .firstOrNull ??
                                matchingVisits.firstOrNull;
                            todayScheduledVisit = active;
                          });
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
                          'attendance.remoteDescription'.tr(context: context),
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
                    ] else if (type == 'Customer' &&
                        (todayScheduledVisit ??
                                (customer != null
                                    ? todayVisits
                                        .where((v) =>
                                            v.customerId == customer!.id)
                                        .firstOrNull
                                    : null)) !=
                            null &&
                        ((todayScheduledVisit ??
                                    todayVisits
                                        .where((v) =>
                                            v.customerId == customer!.id)
                                        .first)
                                .status ==
                            'visited' ||
                            (todayScheduledVisit ??
                                    todayVisits
                                        .where((v) =>
                                            v.customerId == customer!.id)
                                        .first)
                                .status ==
                            'completed')) ...[
                      hSpace(14),
                      Builder(
                        builder: (context) {
                          final matchingVisit = todayScheduledVisit ??
                              todayVisits
                                  .where((v) => v.customerId == customer!.id)
                                  .first;
                          final nextPendingVisit = todayVisits
                              .where((v) =>
                                  v.id != matchingVisit.id &&
                                  v.status != 'visited' &&
                                  v.status != 'completed')
                              .firstOrNull;

                          return EmployeeAttendedVisitCardWidget(
                            visit: matchingVisit,
                            nextVisit: nextPendingVisit,
                            onNextVisitTap: nextPendingVisit == null
                                ? null
                                : () {
                                    setState(() {
                                      todayScheduledVisit = nextPendingVisit;
                                      final matchingCust =
                                          sortedCustomerOptions
                                              .where((c) =>
                                                  c.id ==
                                                  nextPendingVisit.customerId)
                                              .firstOrNull;
                                      if (matchingCust != null) {
                                        customer = matchingCust;
                                      }
                                    });
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      _focusTarget();
                                      _loadTargetAddress();
                                    });
                                  },
                            onRecordOutcomeTap: () {
                              showDialog(
                                context: context,
                                builder: (ctx) =>
                                    AdminRecordVisitOutcomeDialogWidget(
                                  visit: matchingVisit,
                                  onSubmit: (
                                    outcome,
                                    status,
                                    notes,
                                    docName,
                                    docUrl,
                                  ) async {
                                    final visitId = matchingVisit.id;
                                    if (visitId == null || visitId.isEmpty) return;
                                    final res = await sl<AdminCustomerVisitsRepo>()
                                        .updateVisitOutcome(
                                      visitId: visitId,
                                      outcome: outcome,
                                      status: status,
                                      notes: notes,
                                      documentName: docName,
                                      documentUrl: docUrl,
                                    );
                                    if (!mounted) return;
                                    if (res case Success()) {
                                      setState(() {
                                        final updated = matchingVisit.copyWith(
                                          outcome: outcome,
                                          status: status,
                                          notes: notes,
                                          outcomeDocumentName: docName,
                                          outcomeDocumentUrl: docUrl,
                                          documentName:
                                              matchingVisit.documentName ??
                                                  docName,
                                          documentUrl:
                                              matchingVisit.documentUrl ??
                                                  docUrl,
                                        );
                                        todayVisits = todayVisits
                                            .map((v) =>
                                                v.id == updated.id
                                                    ? updated
                                                    : v)
                                            .toList();
                                        todayScheduledVisit = updated;
                                      });
                                      if (context.mounted) {
                                        CustomSnackBar.showSuccess(
                                          context,
                                          message: 'admin.visits.outcomeSuccess'
                                              .tr(context: context),
                                        );
                                      }
                                    } else if (res
                                        case Failure(:final failure)) {
                                      if (context.mounted) {
                                        CustomSnackBar.showError(
                                          context,
                                          message: failure.messageKey.tr(context: context),
                                        );
                                      }
                                    }
                                  },
                                ),
                              );
                            },
                          );
                        },
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
                        enabled: userLocation != null && isInside,
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
