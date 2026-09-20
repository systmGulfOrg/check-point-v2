import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:check_point_v2/core/core.dart';
import 'remote_work_bloc_builder_widget.dart';

class RemoteWorkTabsWidget extends StatelessWidget {
  const RemoteWorkTabsWidget({
    required this.isAdmin,
    required this.canReview,
    required this.showRemote,
    required this.showHybrid,
    super.key,
  });

  final bool isAdmin;
  final bool canReview;
  final bool showRemote;
  final bool showHybrid;

  @override
  Widget build(BuildContext context) {
    final tabs = <Tab>[];
    final views = <Widget>[];
    if (showRemote) {
      tabs.add(Tab(text: 'remoteWork.remoteTab'.tr(context: context)));
      views.add(
        RemoteWorkBlocBuilderWidget(
          isAdmin: isAdmin,
          canReview: canReview,
          policyType: 'remote',
        ),
      );
    }
    if (showHybrid) {
      tabs.add(Tab(text: 'remoteWork.hybridTab'.tr(context: context)));
      views.add(
        RemoteWorkBlocBuilderWidget(
          isAdmin: isAdmin,
          canReview: canReview,
          policyType: 'hybrid',
        ),
      );
    }

    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          if (tabs.length > 1)
            TabBar(
              labelColor: AppColors.brandPrimary,
              unselectedLabelColor: AppColors.textSecondary,
              indicatorColor: AppColors.brandPrimary,
              tabs: tabs,
            ),
          Expanded(
            child: tabs.length == 1 ? views.first : TabBarView(children: views),
          ),
        ],
      ),
    );
  }
}
