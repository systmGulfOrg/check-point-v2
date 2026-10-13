import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/core.dart';
import '../widgets/remote_work_access_gate_widget.dart';
import '../widgets/remote_work_bloc_listener_widget.dart';

class RemoteWorkScreen extends StatelessWidget {
  const RemoteWorkScreen({required this.sessionStorage, super.key});
  final AuthSessionStorage sessionStorage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
      future: Future.wait<String?>([
        sessionStorage.readUserRole(),
        sessionStorage.readEmployeeId(),
      ]),
      builder: (context, snapshot) {
        final role = snapshot.data?[0];
        final employeeId = snapshot.data?[1];
        final isAdmin = role == 'Admin';
        final canReview = isAdmin || role == 'Supervisor';
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.white,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
              title: Text(
                'remoteWork.title'.tr(context: context),
                style: AppTextStyles.font18Bold,
              ),
            ),
            body: RemoteWorkBlocListenerWidget(
              child: RemoteWorkAccessGateWidget(
                isAdmin: isAdmin,
                canReview: canReview,
                canRequest: !isAdmin,
                currentEmployeeId: employeeId,
              ),
            ),
          ),
        );
      },
    );
  }
}
