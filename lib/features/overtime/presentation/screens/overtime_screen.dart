import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import '../cubit/overtime_cubit.dart';
import '../widgets/overtime_request_form_widget.dart';
import '../widgets/overtime_requests_bloc_builder_widget.dart';

class OvertimeScreen extends StatelessWidget {
  const OvertimeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
      future: Future.wait<String?>([
        sl<AuthSessionStorage>().readUserRole(),
        sl<AuthSessionStorage>().readEmployeeId(),
      ]),
      builder: (context, snapshot) {
        final role = snapshot.data?[0];
        final employeeId = snapshot.data?[1];
        return Scaffold(
          appBar: AppBar(title: Text('overtime.title'.tr(context: context))),
          body: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                AnimatedListItemWidget(
                  index: 0,
                  child: OvertimeRequestFormWidget(
                    cubit: context.read<OvertimeCubit>(),
                  ),
                ),
                hSpace(18),
                AnimatedListItemWidget(
                  index: 1,
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'overtime.requests'.tr(context: context),
                      style: AppTextStyles.font16Bold,
                    ),
                  ),
                ),
                Expanded(
                  child: OvertimeRequestsBlocBuilderWidget(
                    currentEmployeeId: employeeId,
                    canReview: role == 'Supervisor',
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
