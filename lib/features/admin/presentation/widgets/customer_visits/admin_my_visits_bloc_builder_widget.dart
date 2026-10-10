import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_state.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/locations/admin_customers_state.dart';
import 'admin_create_customer_visit_sheet_widget.dart';
import 'admin_customer_visit_card_widget.dart';

class AdminMyVisitsBlocBuilderWidget extends StatefulWidget {
  const AdminMyVisitsBlocBuilderWidget({super.key});

  @override
  State<AdminMyVisitsBlocBuilderWidget> createState() =>
      _AdminMyVisitsBlocBuilderWidgetState();
}

class _AdminMyVisitsBlocBuilderWidgetState
    extends State<AdminMyVisitsBlocBuilderWidget> {
  String? _currentUserRole;
  String? _currentUserName;
  String? _currentUserId;
  String? _currentEmployeeId;

  @override
  void initState() {
    super.initState();
    _loadUserSession();
    context.read<AdminCustomerVisitsCubit>().loadAllVisits();
  }

  Future<void> _loadUserSession() async {
    final storage = sl<AuthSessionStorage>();
    final role = await storage.readUserRole();
    final name = await storage.readUserName();
    final userId = await storage.readUserId();
    final employeeId = await storage.readEmployeeId();
    if (mounted) {
      setState(() {
        _currentUserRole = role;
        _currentUserName = name;
        _currentUserId = userId;
        _currentEmployeeId = employeeId;
      });
    }
  }

  List<CustomerModel> _filterCustomers(List<CustomerModel> customers) {
    final role = _currentUserRole?.toLowerCase() ?? '';
    if (role.contains('admin')) {
      return customers;
    }

    final userName = _currentUserName?.trim().toLowerCase() ?? '';

    return customers.where((c) {
      final workesAs = c.workesAs?.trim().toLowerCase();
      if (workesAs == null ||
          workesAs.isEmpty ||
          workesAs == '-' ||
          workesAs == 'الكل' ||
          workesAs == 'all') {
        return true;
      }
      if (userName.isNotEmpty && workesAs.contains(userName)) {
        return true;
      }
      final tokens = workesAs
          .split(RegExp(r'[,،/|&\s]+'))
          .map((t) => t.trim())
          .where((t) => t.isNotEmpty);
      for (final token in tokens) {
        if (token.isNotEmpty &&
            (userName.contains(token) || token.contains(userName))) {
          return true;
        }
      }
      return false;
    }).toList();
  }

  bool _isVisitForCurrentUser(
    CustomerVisitModel visit,
    List<CustomerModel> accessibleCustomers,
  ) {
    final role = _currentUserRole?.toLowerCase() ?? '';
    if (role.contains('admin')) {
      return true;
    }

    final userName = _currentUserName?.trim().toLowerCase() ?? '';
    final userId = _currentUserId?.trim().toLowerCase() ?? '';
    final empId = _currentEmployeeId?.trim().toLowerCase() ?? '';

    // 1. Check if the current user created the visit
    if (visit.createdBy != null && visit.createdBy!.isNotEmpty) {
      final createdByLower = visit.createdBy!.trim().toLowerCase();
      if ((userId.isNotEmpty && createdByLower == userId) ||
          (empId.isNotEmpty && createdByLower == empId) ||
          (userName.isNotEmpty && createdByLower == userName)) {
        return true;
      }
    }
    if (visit.createdByName != null && visit.createdByName!.isNotEmpty) {
      final createdByNameLower = visit.createdByName!.trim().toLowerCase();
      if (userName.isNotEmpty &&
          (createdByNameLower == userName ||
              createdByNameLower.contains(userName) ||
              userName.contains(createdByNameLower))) {
        return true;
      }
    }

    // 2. Check if the current user is an attendee
    for (final attendee in visit.attendees) {
      final cleanAttendee = attendee.trim().toLowerCase();
      if (cleanAttendee.isEmpty) continue;

      if (cleanAttendee.startsWith('أنا') || cleanAttendee.startsWith('me')) {
        final match = RegExp(r'[\(（]([^\)）]+)[\)）]').firstMatch(cleanAttendee);
        if (match != null) {
          final inner = match.group(1)?.trim().toLowerCase() ?? '';
          if (userName.isNotEmpty &&
              (inner == userName ||
                  inner.contains(userName) ||
                  userName.contains(inner))) {
            return true;
          }
          if (userId.isNotEmpty && inner == userId) return true;
          if (empId.isNotEmpty && inner == empId) return true;
        }
        continue;
      }

      if (userName.isNotEmpty &&
          (cleanAttendee.contains(userName) ||
              userName.contains(cleanAttendee))) {
        return true;
      }
      if (userId.isNotEmpty && cleanAttendee.contains(userId)) {
        return true;
      }
      if (empId.isNotEmpty && cleanAttendee.contains(empId)) {
        return true;
      }

      final tokens = userName
          .split(RegExp(r'\s+'))
          .where((t) => t.length > 2);
      for (final token in tokens) {
        if (cleanAttendee.contains(token)) {
          return true;
        }
      }
    }

    // 3. Check if the visit belongs to an accessible (assigned) customer
    if (visit.customerId != null && visit.customerId!.isNotEmpty) {
      final matchesCustomer = accessibleCustomers.any(
        (c) => c.id == visit.customerId,
      );
      if (matchesCustomer) return true;
    }

    if (visit.customerName != null && visit.customerName!.isNotEmpty) {
      final visitCustName = visit.customerName!.trim().toLowerCase();
      final matchesCustomerName = accessibleCustomers.any(
        (c) => c.name?.trim().toLowerCase() == visitCustName,
      );
      if (matchesCustomerName) return true;
    }

    return false;
  }

  void _openCreateVisitSheet(BuildContext context, List<CustomerModel> customers) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminCustomerVisitsCubit>(),
        child: AdminCreateCustomerVisitSheetWidget(
          availableCustomers: customers,
          onSave: (visit) =>
              context.read<AdminCustomerVisitsCubit>().addVisitPlan(visit),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final customersState = context.watch<AdminCustomersCubit>().state;
    final allCustomers = switch (customersState) {
      AdminCustomersSuccess(:final customers) => customers,
      _ => const <CustomerModel>[],
    };
    final accessibleCustomers = _filterCustomers(allCustomers);

    return BlocBuilder<AdminCustomerVisitsCubit, AdminCustomerVisitsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (message) => Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                message.tr(context: context),
                style: AppTextStyles.font14Regular.copyWith(
                  color: AppColors.error,
                ),
              ),
            ),
          ),
          actionSuccess: (_) => const SizedBox.shrink(),
          success: (visits) {
            final myVisits = visits
                .where((v) => _isVisitForCurrentUser(v, accessibleCustomers))
                .toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'admin.visits.title'.tr(context: context),
                      style: AppTextStyles.font12Regular,
                    ),
                    TextButton.icon(
                      onPressed: () => _openCreateVisitSheet(
                        context,
                        accessibleCustomers,
                      ),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: Text(
                        'admin.visits.planVisit'.tr(context: context),
                        style: AppTextStyles.font12Bold.copyWith(
                          color: AppColors.brandPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(8),
                if (myVisits.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 40.h,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.event_available_outlined,
                            size: 48.r,
                            color: AppColors.placeholder,
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'admin.visits.emptyAll'.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          CustomButton(
                            text: 'admin.visits.planVisit'.tr(context: context),
                            icon: Icons.add_rounded,
                            onTap: () => _openCreateVisitSheet(
                              context,
                              accessibleCustomers,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myVisits.length,
                    separatorBuilder: (_, _) => SizedBox(height: 10.h),
                    itemBuilder: (context, index) {
                      final visit = myVisits[index];
                      return AnimatedListItemWidget(
                        index: index,
                        child: AdminCustomerVisitCardWidget(
                          visit: visit,
                          onRecordOutcome:
                              (
                                outcome,
                                status,
                                notes,
                                documentName,
                                documentUrl,
                              ) => context
                                  .read<AdminCustomerVisitsCubit>()
                                  .updateVisitOutcome(
                                    visitId: visit.id ?? '',
                                    customerId: visit.customerId ?? '',
                                    outcome: outcome,
                                    status: status,
                                    notes: notes,
                                    documentName: documentName,
                                    documentUrl: documentUrl,
                                  ),
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
