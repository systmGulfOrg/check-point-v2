import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:check_point_v2/core/core.dart';
import '../widgets/remote_work_access_gate_widget.dart';

class RemoteWorkScreen extends StatelessWidget {
  const RemoteWorkScreen({required this.sessionStorage, super.key});
  final AuthSessionStorage sessionStorage;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: sessionStorage.readUserRole(),
      builder: (context, snapshot) {
        final isAdmin = snapshot.data == 'Admin' || snapshot.data == 'HR';
        final canReview = isAdmin || snapshot.data == 'Supervisor';
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
            body: RemoteWorkAccessGateWidget(
              isAdmin: isAdmin,
              canReview: canReview,
            ),
          ),
        );
      },
    );
  }
}
