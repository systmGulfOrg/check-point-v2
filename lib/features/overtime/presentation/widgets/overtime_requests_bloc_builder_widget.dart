import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import '../cubit/overtime_cubit.dart';
import '../cubit/overtime_state.dart';
import 'overtime_request_card_widget.dart';

class OvertimeRequestsBlocBuilderWidget extends StatelessWidget {
  const OvertimeRequestsBlocBuilderWidget({
    required this.currentEmployeeId,
    required this.canReview,
    super.key,
  });

  final String? currentEmployeeId;
  final bool canReview;
  @override
  Widget build(BuildContext context) =>
      BlocBuilder<OvertimeCubit, OvertimeState>(
        builder: (context, state) => switch (state) {
          OvertimeStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          OvertimeStateError(:final messageKey) => Center(
            child: Text(messageKey.tr(context: context)),
          ),
          OvertimeStateSuccess(:final requests) =>
            requests.isEmpty
                ? Center(child: Text('overtime.empty'.tr(context: context)))
                : ListView.separated(
                    padding: EdgeInsets.only(top: 12.h),
                    itemCount: requests.length,
                    separatorBuilder: (_, index) => hSpace(10),
                    itemBuilder: (_, index) => AnimatedListItemWidget(
                      index: index + 2,
                      child: OvertimeRequestCardWidget(
                        request: requests[index],
                        canReview: canReview,
                        isOwnRequest:
                            currentEmployeeId == requests[index].employeeId,
                      ),
                    ),
                  ),
          _ => const SizedBox.shrink(),
        },
      );
}
