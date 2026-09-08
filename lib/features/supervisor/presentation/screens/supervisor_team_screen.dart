import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/supervisor/presentation/widgets/supervisor_team_bloc_builder_widget.dart';

class SupervisorTeamScreen extends StatefulWidget {
  const SupervisorTeamScreen({super.key});

  @override
  State<SupervisorTeamScreen> createState() => _SupervisorTeamScreenState();
}

class _SupervisorTeamScreenState extends State<SupervisorTeamScreen> {
  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16.w, 16.h, 16.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'supervisor.team.title'.tr(context: context),
                style: AppTextStyles.font20Bold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              hSpace(12),
              CustomTextFormField(
                controller: _searchController,
                hintText: 'supervisor.team.searchHint'.tr(context: context),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: AppColors.textSecondary,
                ),
                onChanged: (val) => setState(() => _searchQuery = val.trim()),
              ),
              hSpace(14),
              Expanded(
                child: SupervisorTeamBlocBuilderWidget(
                  searchQuery: _searchQuery,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
