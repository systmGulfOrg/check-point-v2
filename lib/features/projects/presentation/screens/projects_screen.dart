import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';
import '../widgets/project_card_widget.dart';
import '../widgets/project_edit_sheet_widget.dart';
import 'project_board_screen.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  String _searchQuery = '';
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    context.read<ProjectsCubit>().loadProjects();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProjectModel> _filterProjects(List<ProjectModel> projects) {
    if (_searchQuery.trim().isEmpty) return projects;
    final query = _searchQuery.trim().toLowerCase();
    return projects.where((p) {
      final nameMatch = p.name.toLowerCase().contains(query);
      final codeMatch = p.code?.toLowerCase().contains(query) ?? false;
      final deptMatch =
          p.departmentName?.toLowerCase().contains(query) ?? false;
      final mgrMatch = p.managerName?.toLowerCase().contains(query) ?? false;
      return nameMatch || codeMatch || deptMatch || mgrMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final canManage = context.select<AuthProfileCubit, bool>(
      (cubit) => switch (cubit.state) {
        AuthProfileSuccess(:final role) =>
          role.toLowerCase() == 'admin' ||
              role.toLowerCase() == 'hr' ||
              role.toLowerCase() == 'supervisor',
        _ => false,
      },
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(
          'projects.title'.tr(context: context),
          style: AppTextStyles.font18Bold,
        ),
      ),
      body: BlocConsumer<ProjectsCubit, ProjectsState>(
        listener: (context, state) {
          if (state case ProjectsStateError(:final messageKey)) {
            CustomSnackBar.show(
              context,
              message: messageKey.tr(context: context),
            );
          }
        },
        builder: (context, state) => switch (state) {
          ProjectsStateLoading() => Skeletonizer(
            enabled: true,
            child: ListView.builder(
              padding: EdgeInsets.all(16.r),
              itemCount: 3,
              itemBuilder: (context, index) => ProjectCardWidget(
                project: const ProjectModel(
                  id: 'skeleton_id',
                  name: 'Loading Project Name Placeholder',
                  code: 'PROJ-001',
                  description:
                      'Loading project description details placeholder for skeleton animation',
                  statuses: [
                    ProjectStatusModel(id: '1', name: 'To Do'),
                    ProjectStatusModel(id: '2', name: 'In Progress'),
                    ProjectStatusModel(id: '3', name: 'Done'),
                  ],
                ),
                onTap: () {},
              ),
            ),
          ),
          ProjectsStateSuccess(:final projects) => RefreshIndicator(
            color: AppColors.brandPrimary,
            onRefresh: context.read<ProjectsCubit>().loadProjects,
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 12.h),
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'projects.searchProjectsHint'.tr(
                            context: context,
                          ),
                          controller: _searchController,
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                          suffixIcon: _searchQuery.isNotEmpty
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.close_rounded,
                                    size: 18,
                                    color: AppColors.textSecondary,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                    setState(() => _searchQuery = '');
                                  },
                                )
                              : null,
                          onChanged: (val) =>
                              setState(() => _searchQuery = val),
                        ),

                        if (canManage) ...[
                          hSpace(10),
                          Row(
                            children: [
                              Text(
                                '${projects.length} ${'projects.title'.tr(context: context)}',
                                style: AppTextStyles.font13SemiBold.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const Spacer(),
                              ElevatedButton.icon(
                                onPressed: () => _createOrEditProject(context),
                                icon: const Icon(
                                  Icons.add_rounded,
                                  size: 18,
                                  color: AppColors.white,
                                ),
                                label: Text(
                                  'projects.newProject'.tr(context: context),
                                  style: AppTextStyles.font13Bold.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.brandPrimary,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 14.w,
                                    vertical: 8.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                if (_filterProjects(projects).isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.folder_open_rounded,
                            size: 56.r,
                            color: AppColors.placeholder,
                          ),
                          hSpace(12),
                          Text(
                            'projects.empty'.tr(context: context),
                            style: AppTextStyles.font14Regular.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final filtered = _filterProjects(projects);
                        final project = filtered[index];
                        return ProjectCardWidget(
                          project: project,
                          onTap: () => _openBoard(project),
                          onEdit: canManage
                              ? () => _createOrEditProject(
                                  context,
                                  project: project,
                                )
                              : null,
                          onDelete: canManage
                              ? () => _confirmDeleteProject(context, project)
                              : null,
                        );
                      }, childCount: _filterProjects(projects).length),
                    ),
                  ),
              ],
            ),
          ),
          ProjectsStateError(:final messageKey) => AppErrorStateWidget(
            messageKey: messageKey,
            onRetry: () => context.read<ProjectsCubit>().loadProjects(),
          ),
          ProjectsStateInitial() => const SizedBox.shrink(),
          _ => const SizedBox.shrink(),
        },
      ),
    );
  }

  void _openBoard(ProjectModel project) {
    context.read<ProjectsCubit>().openProject(project);
    final canManage = switch (context.read<AuthProfileCubit>().state) {
      AuthProfileSuccess(:final role) =>
        role.toLowerCase() == 'admin' ||
            role.toLowerCase() == 'hr' ||
            role.toLowerCase() == 'supervisor',
      _ => false,
    };
    Navigator.pushNamed(
      context,
      AppRoutes.projectBoard,
      arguments: ProjectBoardScreenArgs(project: project, canManage: canManage),
    );
  }

  Future<void> _confirmDeleteProject(
    BuildContext context,
    ProjectModel project,
  ) async {
    final cubit = context.read<ProjectsCubit>();
    showDialog(
      context: context,
      builder: (dialogCtx) => CustomDialogWidget(
        title: 'projects.deleteProject'.tr(context: context),
        message:
            '${'projects.confirmDeleteProject'.tr(context: context)}\n"${project.name}"',
        icon: Icons.delete_outline_rounded,
        iconColor: AppColors.error,
        iconBackgroundColor: AppColors.softBrandBackground,
        onConfirm: () {
          Navigator.pop(dialogCtx);
          cubit.deleteProject(project.id);
        },
        confirmLabel: 'common.delete'.tr(context: context),
        confirmButtonColor: AppColors.error,
        cancelLabel: 'common.cancel'.tr(context: context),
      ),
    );
  }

  Future<void> _createOrEditProject(
    BuildContext context, {
    ProjectModel? project,
  }) async {
    final isEditing = project != null;
    final cubit = context.read<ProjectsCubit>();

    List<DepartmentModel> departments = [];
    List<EmployeeModel> employees = [];

    try {
      final deptRes = await sl<AdminLocationsRepo>().getDepartments();
      deptRes.when(success: (list) => departments = list, failure: (_) {});
    } catch (_) {}

    try {
      final empRes = await sl<AdminEmployeeRepo>().getEmployees(
        page: 0,
        pageSize: 25,
      );
      empRes.when(success: (list) => employees = list, failure: (_) {});
    } catch (_) {}

    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ProjectEditSheetWidget(
        project: project,
        departments: departments,
        employees: employees,
        onSave: (body) {
          if (isEditing) {
            cubit.updateProject(project.id, body);
          } else {
            cubit.createProject(body);
          }
        },
      ),
    );
  }
}
