import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_response_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/customer_visit_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/customer_visits/admin_customer_visits_state.dart';
import 'admin_customer_visit_card_widget.dart';

class AdminCustomerDetailsVisitsTabWidget extends StatelessWidget {
  const AdminCustomerDetailsVisitsTabWidget({
    super.key,
    required this.customer,
    required this.scrollController,
    required this.isVisitForCurrentUser,
  });

  final CustomerModel customer;
  final ScrollController scrollController;
  final bool Function(CustomerVisitModel visit) isVisitForCurrentUser;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminCustomerVisitsCubit, AdminCustomerVisitsState>(
      builder: (context, state) {
        return state.when(
          initial: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (message) => Center(
            child: Text(
              message.tr(context: context),
              style: AppTextStyles.font14Regular.copyWith(
                color: AppColors.error,
              ),
            ),
          ),
          actionSuccess: (_) => const SizedBox.shrink(),
          success: (visits) {
            final visibleVisits = visits.where(isVisitForCurrentUser).toList();
            if (visibleVisits.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(24.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.event_busy_rounded,
                        size: 48.r,
                        color: AppColors.placeholder,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'admin.visits.empty'.tr(context: context),
                        style: AppTextStyles.font14Regular.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }
            return ListView.separated(
              controller: scrollController,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              itemCount: visibleVisits.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, index) {
                final visit = visibleVisits[index];
                return AnimatedListItemWidget(
                  index: index,
                  child: AdminCustomerVisitCardWidget(
                    visit: visit,
                    onRecordOutcome:
                        (outcome, status, notes, documentName, documentUrl) =>
                            context
                                .read<AdminCustomerVisitsCubit>()
                                .updateVisitOutcome(
                                  visitId: visit.id ?? '',
                                  customerId: customer.id ?? '',
                                  outcome: outcome,
                                  status: status,
                                  notes: notes,
                                  documentName: documentName,
                                  documentUrl: documentUrl,
                                ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
