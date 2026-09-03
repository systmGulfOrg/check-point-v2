import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/core.dart';
import '../cubit/admin_account_requests_cubit.dart';
import '../cubit/admin_account_requests_state.dart';
import 'admin_registration_request_card_widget.dart';

class AdminAccountRequestsBlocBuilderWidget extends StatelessWidget {
  const AdminAccountRequestsBlocBuilderWidget({
    required this.onView,
    required this.onApprove,
    super.key,
  });

  final void Function(int id) onView;
  final void Function(int id) onApprove;

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AdminAccountRequestsCubit, AdminAccountRequestsState>(
        builder: (context, state) => switch (state) {
          AdminAccountRequestsStateInitial() => const SizedBox.shrink(),
          AdminAccountRequestsStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
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
                            date: request.createdDate?.toIso8601String() ?? '-',
                            onView: () => onView(request.id ?? 0),
                            onApprove: () => onApprove(request.id ?? 0),
                            onReject: () => context
                                .read<AdminAccountRequestsCubit>()
                                .rejectRequest(id: request.id ?? 0),
                          ),
                        ),
                    ],
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
