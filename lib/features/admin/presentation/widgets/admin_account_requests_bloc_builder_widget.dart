import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/account_requests/account_requests_response_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/account_requests/admin_account_requests_state.dart';
import 'admin_account_requests_skeleton_widget.dart';
import 'admin_registration_request_card_widget.dart';

class AdminAccountRequestsBlocBuilderWidget extends StatelessWidget {
  const AdminAccountRequestsBlocBuilderWidget({
    required this.onView,
    super.key,
  });

  final void Function(AccountRequestModel request) onView;

  void _showDeleteDialog(BuildContext context, int requestId) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AppDeleteConfirmationDialogWidget(
        title: 'admin.locations.delete'.tr(context: context),
        message: 'admin.requests.deleteMessage'.tr(context: context),
        onConfirm: () {
          Navigator.pop(dialogContext);
          context.read<AdminAccountRequestsCubit>().deleteRequest(
            id: requestId,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminAccountRequestsCubit, AdminAccountRequestsState>(
        builder: (context, state) => switch (state) {
          AdminAccountRequestsStateInitial() => const SizedBox.shrink(),
          AdminAccountRequestsStateLoading() =>
            const AdminAccountRequestsSkeletonWidget(),
          AdminAccountRequestsStateError(:final messageKey) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 28),
            child: Text(
              messageKey.tr(context: context),
              textAlign: TextAlign.center,
              style: AppTextStyles.font14Regular,
            ),
          ),
          AdminAccountRequestsStateSuccess(:final requests) =>
            requests.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    child: Text(
                      'admin.requests.emptyAll'.tr(context: context),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.font14Regular,
                    ),
                  )
                : Column(
                    children: [
                      for (final request in requests)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: AdminRegistrationRequestCardWidget(
                            name: request.name ?? '-',
                            deviceId: request.mobileId ?? '-',
                            date: request.createdDate != null
                                ? AppDateFormatter.formatDayMonthYear(
                                    request.createdDate!,
                                  )
                                : '-',
                            onView: () => onView(request),
                            onDelete: () {
                              if (request.id != null) {
                                _showDeleteDialog(context, request.id!);
                              }
                            },
                          ),
                        ),
                    ],
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
