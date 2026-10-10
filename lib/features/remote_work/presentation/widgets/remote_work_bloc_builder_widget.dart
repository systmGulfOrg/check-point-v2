import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../data/models/remote_work_policy_model.dart';
import '../cubit/remote_work_cubit.dart';
import '../cubit/remote_work_state.dart';
import 'remote_work_content_widget.dart';

class RemoteWorkBlocBuilderWidget extends StatelessWidget {
  const RemoteWorkBlocBuilderWidget({
    required this.isAdmin,
    required this.canReview,
    required this.policyType,
    super.key,
  });

  final bool isAdmin;
  final bool canReview;
  final String policyType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RemoteWorkCubit, RemoteWorkState>(
      builder: (context, state) => state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => Skeletonizer(
          enabled: true,
          child: RemoteWorkContentWidget(
            isAdmin: isAdmin,
            canReview: canReview,
            policyType: policyType,
            policies: const [
              RemoteWorkPolicyModel(
                id: '1',
                name: 'Loading Policy Name 1',
                allowedDays: ['Sunday', 'Monday', 'Tuesday'],
                onsiteDays: ['Wednesday', 'Thursday'],
                workingHoursStart: '09:00',
                workingHoursEnd: '17:00',
                allowedDelayTime: 15,
                employeeCount: 3,
              ),
              RemoteWorkPolicyModel(
                id: '2',
                name: 'Loading Policy Name 2',
                allowedDays: ['Sunday', 'Monday', 'Tuesday'],
                onsiteDays: ['Wednesday', 'Thursday'],
                workingHoursStart: '09:00',
                workingHoursEnd: '17:00',
                allowedDelayTime: 15,
                employeeCount: 5,
              ),
            ],
            requests: const [],
          ),
        ),
        error: (messageKey) => Center(child: Text(messageKey.tr())),
        success: (policies, requests) => RemoteWorkContentWidget(
          isAdmin: isAdmin,
          canReview: canReview,
          policyType: policyType,
          policies: policies,
          requests: requests,
        ),
      ),
    );
  }
}
