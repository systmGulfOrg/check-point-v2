import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'admin_create_customer_visit_sheet_widget.dart';
import 'admin_customer_details_overview_tab_widget.dart';
import 'admin_customer_details_visits_tab_widget.dart';

class AdminCustomerDetailsSheetWidget extends StatefulWidget {
  const AdminCustomerDetailsSheetWidget({
    required this.customer,
    this.onEdit,
    this.onDelete,
    super.key,
  });

  final CustomerModel customer;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  State<AdminCustomerDetailsSheetWidget> createState() =>
      _AdminCustomerDetailsSheetWidgetState();
}

class _AdminCustomerDetailsSheetWidgetState
    extends State<AdminCustomerDetailsSheetWidget> {
  int selectedTab = 0;
  String? _currentUserRole;
  String? _currentUserName;
  String? _currentUserId;
  String? _currentEmployeeId;

  @override
  void initState() {
    super.initState();
    _loadUserSession();
    context.read<AdminCustomerVisitsCubit>().loadCustomerVisits(
      widget.customer.id ?? '',
    );
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

  bool _isVisitForCurrentUser(CustomerVisitModel visit) {
    final role = _currentUserRole?.toLowerCase() ?? '';
    if (role.contains('admin')) {
      return true;
    }

    final userName = _currentUserName?.trim().toLowerCase() ?? '';
    final userId = _currentUserId?.trim().toLowerCase() ?? '';
    final empId = _currentEmployeeId?.trim().toLowerCase() ?? '';

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

      final tokens = userName.split(RegExp(r'\s+')).where((t) => t.length > 2);
      for (final token in tokens) {
        if (cleanAttendee.contains(token)) {
          return true;
        }
      }
    }
    return false;
  }

  void _openCreateVisitSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminCustomerVisitsCubit>(),
        child: AdminCreateCustomerVisitSheetWidget(
          initialCustomer: widget.customer,
          onSave: (visit) =>
              context.read<AdminCustomerVisitsCubit>().addVisitPlan(visit),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 24.r,
                      backgroundColor: AppColors.softBlueBackground,
                      child: Icon(
                        Icons.business_rounded,
                        color: AppColors.info,
                        size: 26.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.customer.name ?? '',
                                  style: AppTextStyles.font16Bold,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.softGreenBackground,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  'نشط • عميل معتمد',
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.success,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          if (widget.customer.workesAs != null &&
                              widget.customer.workesAs!.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Text(
                              widget.customer.workesAs!,
                              style: AppTextStyles.font12Medium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                          if (widget.customer.location != null &&
                              widget.customer.location!.isNotEmpty) ...[
                            SizedBox(height: 2.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 13.r,
                                  color: AppColors.placeholder,
                                ),
                                SizedBox(width: 4.w),
                                Expanded(
                                  child: Text(
                                    widget.customer.location!,
                                    style: AppTextStyles.font11Regular.copyWith(
                                      color: AppColors.placeholder,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    color: AppColors.selectedBackground,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => selectedTab = 0),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: selectedTab == 0
                                  ? AppColors.white
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: selectedTab == 0
                                  ? const [
                                      BoxShadow(
                                        color: AppColors.shadow,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.history_rounded,
                                  size: 16.r,
                                  color: selectedTab == 0
                                      ? AppColors.brandPrimary
                                      : AppColors.textSecondary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'admin.visits.tabHistory'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: selectedTab == 0
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setState(() => selectedTab = 1),
                          borderRadius: BorderRadius.circular(8.r),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 8.h),
                            decoration: BoxDecoration(
                              color: selectedTab == 1
                                  ? AppColors.white
                                  : AppColors.transparent,
                              borderRadius: BorderRadius.circular(8.r),
                              boxShadow: selectedTab == 1
                                  ? const [
                                      BoxShadow(
                                        color: AppColors.shadow,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline_rounded,
                                  size: 16.r,
                                  color: selectedTab == 1
                                      ? AppColors.brandPrimary
                                      : AppColors.textSecondary,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'admin.visits.tabOverview'.tr(
                                    context: context,
                                  ),
                                  style: AppTextStyles.font12Bold.copyWith(
                                    color: selectedTab == 1
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              Expanded(
                child: selectedTab == 0
                    ? AdminCustomerDetailsVisitsTabWidget(
                        customer: widget.customer,
                        scrollController: scrollController,
                        isVisitForCurrentUser: _isVisitForCurrentUser,
                      )
                    : AdminCustomerDetailsOverviewTabWidget(
                        customer: widget.customer,
                        scrollController: scrollController,
                      ),
              ),

              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 16.h),
                child: CustomButton(
                  text: 'admin.visits.addPlan'.tr(context: context),
                  icon: Icons.add_rounded,
                  onTap: _openCreateVisitSheet,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
