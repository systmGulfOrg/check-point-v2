import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:easy_localization/easy_localization.dart';

import '../cubit/remote_work_cubit.dart';
import '../cubit/remote_work_state.dart';
import 'remote_work_my_requests_card_widget.dart';
import 'remote_work_section_title_widget.dart';

class RemoteWorkMyRequestsBlocBuilderWidget extends StatelessWidget {
  const RemoteWorkMyRequestsBlocBuilderWidget({
    required this.employeeId,
    super.key,
  });

  final String? employeeId;

  @override
  Widget build(BuildContext context) {
    if (employeeId == null || employeeId!.isEmpty) {
      return const SizedBox.shrink();
    }

    return BlocBuilder<RemoteWorkCubit, RemoteWorkState>(
      builder: (context, state) => state.maybeWhen(
        success: (_, requests) {
          final myRequests = requests
              .where((request) => request.employeeId == employeeId)
              .toList();
          if (myRequests.isEmpty) return const SizedBox.shrink();
          return Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16.w, 12.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RemoteWorkSectionTitleWidget(
                  title: 'remoteWork.myRequests'.tr(context: context),
                ),
                RemoteWorkMyRequestsCardWidget(
                  requests: myRequests,
                  onDelete: (id) =>
                      context.read<RemoteWorkCubit>().deleteRequest(id: id),
                ),
              ],
            ),
          );
        },
        orElse: () => const SizedBox.shrink(),
      ),
    );
  }
}
