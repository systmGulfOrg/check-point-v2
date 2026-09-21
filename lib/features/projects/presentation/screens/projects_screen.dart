import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:skeletonizer/skeletonizer.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/widgets/custom_dialog_widget.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_employee_repo.dart';
import 'package:check_point_v2/features/admin/data/repos/admin_locations_repo.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';
import '../widgets/assignee_multi_select_widget.dart';
import '../widgets/project_card_widget.dart';
import '../widgets/project_task_detail_sheet_widget.dart';
import '../widgets/project_task_card_widget.dart';

class ProjectDragData {
  const ProjectDragData({this.taskId, this.sourceStatusId, this.statusId});

  final String? taskId;
  final String? sourceStatusId;
  final String? statusId;
}

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({super.key});

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProjectsCubit>().loadProjects();
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(messageKey.tr(context: context))),
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
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                children: [
                  if (canManage)
                    Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: TextButton.icon(
                          onPressed: () => _createOrEditProject(context),
                          icon: const Icon(Icons.add, color: AppColors.brandPrimary),
                          label: Text(
                            '+ ${'projects.newProject'.tr(context: context)}',
                            style: AppTextStyles.font14Bold.copyWith(
                              color: AppColors.brandPrimary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if (projects.isEmpty)
                    SizedBox(
                      height: 220.h,
                      child: Center(
                        child: Text(
                          'projects.empty'.tr(context: context),
                          style: AppTextStyles.font14Regular,
                        ),
                      ),
                    )
                  else
                    ...projects.map(
                      (project) => ProjectCardWidget(
                        project: project,
                        onTap: () => _openBoard(project),
                        onEdit: canManage
                            ? () => _createOrEditProject(context, project: project)
                            : null,
                        onDelete: canManage
                            ? () => _confirmDeleteProject(context, project)
                            : null,
                      ),
                    ),
                ],
              ),
            ),
          ProjectsStateError() => Center(
              child: Text('errors.server'.tr(context: context)),
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
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<ProjectsCubit>(),
          child: ProjectBoardScreen(project: project, canManage: canManage),
        ),
      ),
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
        title: 'common.delete'.tr(context: context),
        message:
            '${'admin.locations.deleteConfirm'.tr(context: context)} ${project.name}؟',
        icon: Icons.delete_outline,
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
    final name = TextEditingController(text: project?.name ?? '');
    final description = TextEditingController(text: project?.description ?? '');
    final code = TextEditingController(text: project?.code ?? '');
    final formKey = GlobalKey<FormState>();

    List<DepartmentModel> departments = [];
    List<EmployeeModel> employees = [];

    try {
      final deptRes = await sl<AdminLocationsRepo>().getDepartments();
      deptRes.when(success: (list) => departments = list, failure: (_) {});
    } catch (_) {}

    try {
      final empRes =
          await sl<AdminEmployeeRepo>().getEmployees(page: 0, pageSize: 100);
      empRes.when(success: (list) => employees = list, failure: (_) {});
    } catch (_) {}

    String? selectedDepartmentId = project?.departmentId;
    String? selectedManagerId = project?.managerId;

    if (!context.mounted) return;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) {
        final keyboardHeight = MediaQuery.of(sheetContext).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: StatefulBuilder(
            builder: (context, setState) => Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(sheetContext).size.height * 0.8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              ),
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
              child: SafeArea(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                      child: Container(
                        width: 40.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                          color: AppColors.border,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                      ),
                    ),
                    hSpace(14),
                    Text(
                      (isEditing
                              ? 'projects.editTask'
                              : 'projects.newProject')
                          .tr(context: context),
                      style: AppTextStyles.font20Bold,
                    ),
                    SizedBox(height: 18.h),
                    CustomTextFormField(
                      hintText: 'projects.name'.tr(context: context),
                      controller: name,
                      validator: (v) =>
                          v!.trim().isEmpty ? 'validation.required'.tr() : null,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'projects.code'.tr(context: context),
                      controller: code,
                    ),
                    SizedBox(height: 10.h),
                    CustomTextFormField(
                      hintText: 'projects.description'.tr(context: context),
                      controller: description,
                      maxLines: 3,
                    ),
                    SizedBox(height: 10.h),
                    DropdownButtonFormField<String?>(
                      initialValue: (selectedDepartmentId != null &&
                              departments.any(
                                (d) => d.id.toString() == selectedDepartmentId,
                              ))
                          ? selectedDepartmentId
                          : null,
                      decoration: InputDecoration(
                        labelText: 'projects.department'.tr(context: context),
                      ),
                      isExpanded: true,
                      items: [
                        DropdownMenuItem<String?>(
                          value: null,
                          child: Text('common.all'.tr(context: context)),
                        ),
                        ...departments.map(
                          (dept) => DropdownMenuItem<String?>(
                            value: dept.id.toString(),
                            child: Text(dept.departmentName ?? ''),
                          ),
                        ),
                      ],
                      onChanged: (val) =>
                          setState(() => selectedDepartmentId = val),
                    ),
                    SizedBox(height: 10.h),
                    DropdownButtonFormField<String?>(
                      initialValue: (selectedManagerId != null &&
                              employees.any((e) => e.id == selectedManagerId))
                          ? selectedManagerId
                          : null,
                      decoration: const InputDecoration(
                        labelText: 'الشخص المسؤول / الموظف',
                      ),
                      isExpanded: true,
                      items: [
                        const DropdownMenuItem<String?>(
                          value: null,
                          child: Text('الكل / بدون تخصيص'),
                        ),
                        ...employees.map(
                          (emp) => DropdownMenuItem<String?>(
                            value: emp.id,
                            child: Text(
                              emp.name?.isNotEmpty == true
                                  ? emp.name!
                                  : (emp.userName ?? emp.id ?? ''),
                            ),
                          ),
                        ),
                      ],
                      onChanged: (val) =>
                          setState(() => selectedManagerId = val),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(sheetContext),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.border),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.r),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                            ),
                            child: Text(
                              'common.cancel'.tr(context: context),
                              style: AppTextStyles.font14Bold.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            text: 'common.save'.tr(context: context),
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                final body = {
                                  'name': name.text.trim(),
                                  'code': code.text.trim().isEmpty
                                      ? null
                                      : code.text.trim(),
                                  'description': description.text.trim(),
                                  'departmentId': selectedDepartmentId,
                                  'managerId': selectedManagerId,
                                };
                                if (isEditing) {
                                  context
                                      .read<ProjectsCubit>()
                                      .updateProject(project.id, body);
                                } else {
                                  context
                                      .read<ProjectsCubit>()
                                      .createProject(body);
                                }
                                Navigator.pop(sheetContext);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  },
);
    await Future<void>.delayed(const Duration(milliseconds: 350));
    name.dispose();
    description.dispose();
    code.dispose();
  }
}

class ProjectBoardScreen extends StatefulWidget {
  const ProjectBoardScreen({
    required this.project,
    this.canManage = false,
    super.key,
  });
  final ProjectModel project;
  final bool canManage;

  @override
  State<ProjectBoardScreen> createState() => _ProjectBoardScreenState();
}

class _ProjectBoardScreenState extends State<ProjectBoardScreen> {
  bool isListView = true;
  String? draggingTaskId;
  String? draggingStatusId;
  String? hoveredStatusId;

  ProjectModel get project => widget.project;
  bool get canManage => widget.canManage;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProjectsCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: Text(project.name, style: AppTextStyles.font18Bold),
        actions: [
          IconButton(
            tooltip: isListView ? 'Kanban View' : 'List View',
            icon: Icon(
              isListView
                  ? Icons.view_kanban_outlined
                  : Icons.format_list_bulleted_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () => setState(() => isListView = !isListView),
          ),
        ],
      ),
      body: BlocBuilder<ProjectsCubit, ProjectsState>(
        builder: (context, state) {
          final tasks = state is ProjectsStateSuccess
              ? state.tasks
              : const <ProjectTaskModel>[];
          final boardProject = state is ProjectsStateSuccess
              ? state.projects.firstWhere(
                  (item) => item.id == project.id,
                  orElse: () => project,
                )
              : project;

          return Column(
            children: [
              if (canManage)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextButton.icon(
                        onPressed: () => _addStatus(context, cubit),
                        icon: const Icon(Icons.add, size: 18),
                        label: Text(
                          'projects.addStatus'.tr(context: context),
                        ),
                      ),
                      wSpace(8),
                      TextButton.icon(
                        onPressed: () =>
                            _createTask(context, cubit, tasks),
                        icon: const Icon(Icons.add_task_rounded, size: 18),
                        label: Text(
                          'projects.addTaskButton'.tr(context: context),
                        ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                child: isListView
                    ? _buildListView(context, cubit, boardProject, tasks)
                    : _buildKanbanView(context, cubit, boardProject, tasks),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildListView(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasks,
  ) {
    final statuses = boardProject.statuses;
    if (statuses.isEmpty) {
      return Center(
        child: Text('projects.empty'.tr(context: context)),
      );
    }

    final allTabLabel = 'common.all'.tr(context: context);

    return DefaultTabController(
      key: ValueKey('${boardProject.id}_${statuses.length}'),
      length: statuses.length + 1,
      child: Column(
        children: [
          TabBar(
            isScrollable: true,
            labelColor: AppColors.brandPrimary,
            unselectedLabelColor: AppColors.textSecondary,
            indicatorColor: AppColors.brandPrimary,
            tabs: [
              Tab(text: '$allTabLabel (${tasks.length})'),
              ...statuses.map((status) {
                final count =
                    tasks.where((t) => t.statusId == status.id).length;
                return Tab(text: '${status.name} ($count)');
              }),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildTasksList(context, cubit, boardProject, tasks),
                ...statuses.map((status) {
                  final filtered =
                      tasks.where((t) => t.statusId == status.id).toList();
                  return _buildTasksList(context, cubit, boardProject, filtered);
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTasksList(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasksList,
  ) {
    if (tasksList.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(24.r),
          child: Text(
            'projects.noTasks'.tr(context: context),
            style: AppTextStyles.font14Regular,
          ),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: tasksList.length,
      itemBuilder: (context, index) {
        final task = tasksList[index];
        return ProjectTaskCardWidget(
          task: task,
          boardProject: boardProject,
          canManage: canManage,
          onTap: () => _showTaskDetails(context, cubit, task),
          onMoveStatus: (statusId) => cubit.moveTask(task.id, statusId),
          onEdit: () => _editTask(context, cubit, task),
          onDelete: () => cubit.deleteTask(task.id),
        );
      },
    );
  }

  Widget _buildKanbanView(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectModel boardProject,
    List<ProjectTaskModel> tasks,
  ) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
      itemCount: boardProject.statuses.length,
      itemBuilder: (context, statusIndex) {
        final status = boardProject.statuses[statusIndex];
        final columnTasks =
            tasks.where((task) => task.statusId == status.id).toList();
        final isHovered = hoveredStatusId == status.id;

        return DragTarget<ProjectDragData>(
          onWillAcceptWithDetails: (details) {
            if (!canManage) return false;
            setState(() => hoveredStatusId = status.id);
            return details.data.taskId != null ||
                details.data.statusId != status.id;
          },
          onLeave: (_) => setState(() => hoveredStatusId = null),
          onAcceptWithDetails: (details) {
            setState(() {
              hoveredStatusId = null;
              draggingTaskId = null;
              draggingStatusId = null;
            });
            final data = details.data;
            if (data.taskId != null && data.sourceStatusId != status.id) {
              cubit.moveTask(data.taskId!, status.id);
            } else if (data.statusId != null && data.statusId != status.id) {
              final ids = boardProject.statuses.map((item) => item.id).toList();
              final fromIndex = ids.indexOf(data.statusId!);
              if (fromIndex >= 0) {
                ids.removeAt(fromIndex);
                ids.insert(statusIndex, data.statusId!);
                cubit.reorderStatuses(project.id, ids);
              }
            }
          },
          builder: (context, candidates, rejected) => AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            width: 280.w,
            margin: EdgeInsetsDirectional.only(end: 12.w),
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: isHovered
                  ? AppColors.softBrandBackground
                  : AppColors.pageBackground,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isHovered
                    ? AppColors.brandPrimary
                    : AppColors.border,
                width: isHovered ? 1.5 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 10.w,
                      height: 10.w,
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    wSpace(8),
                    Expanded(
                      child: Text(
                        status.name,
                        style: AppTextStyles.font14Bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text(
                        '${columnTasks.length}',
                        style: AppTextStyles.font12Bold,
                      ),
                    ),
                  ],
                ),
                hSpace(12),
                Expanded(
                  child: ListView.builder(
                    itemCount: columnTasks.length,
                    itemBuilder: (context, index) {
                      final task = columnTasks[index];
                      return ProjectTaskCardWidget(
                        task: task,
                        boardProject: boardProject,
                        canManage: canManage,
                        onTap: () => _showTaskDetails(context, cubit, task),
                        onMoveStatus: (statusId) =>
                            cubit.moveTask(task.id, statusId),
                        onEdit: () => _editTask(context, cubit, task),
                        onDelete: () => cubit.deleteTask(task.id),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showTaskDetails(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) async {
    await cubit.loadTaskAudit(task.id);
    if (!context.mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: ProjectTaskDetailSheetWidget(
          task: task,
          project: project,
          canManage: canManage,
          onEdit: () => _editTask(context, cubit, task),
        ),
      ),
    );
  }

  Color _priorityColor(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.error,
      'HIGH' => AppColors.warning,
      'NORMAL' => AppColors.brandPrimary,
      'LOW' => AppColors.textSecondary,
      _ => AppColors.info,
    };
  }

  Color _priorityBackground(String? priority) {
    return switch (priority?.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.softBrandBackground,
      'HIGH' => AppColors.infoBackground,
      'NORMAL' => AppColors.softBlueBackground,
      'LOW' => AppColors.pageBackground,
      _ => AppColors.softBlueBackground,
    };
  }

  Widget _detailHeading(BuildContext context, String text) => Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Text(text, style: AppTextStyles.font16Bold),
      );

  Widget _detailPill(
    BuildContext context,
    String label,
    String value, {
    Color? bg,
    Color? textColor,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: bg ?? AppColors.pageBackground,
          borderRadius: BorderRadius.circular(8.r),
          border: bg == null ? Border.all(color: AppColors.border) : null,
        ),
        child: Text(
          '$label: $value',
          style: AppTextStyles.font12Bold.copyWith(
            color: textColor ?? AppColors.textPrimary,
          ),
        ),
      );

  Future<void> _addStatus(BuildContext context, ProjectsCubit cubit) async {
    final controller = TextEditingController();
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 20.h),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'projects.addStatus'.tr(context: context),
                style: AppTextStyles.font20Bold,
              ),
              SizedBox(height: 16.h),
              CustomTextFormField(
                hintText: 'projects.statusName'.tr(context: context),
                controller: controller,
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'common.cancel'.tr(context: context),
                        style: AppTextStyles.font14Bold.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      text: 'common.save'.tr(context: context),
                      onTap: () {
                        if (controller.text.trim().isNotEmpty) {
                          cubit.addStatus(project.id, controller.text.trim());
                        }
                        Navigator.pop(sheetContext);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    controller.dispose();
  }

  Future<void> _createTask(
    BuildContext context,
    ProjectsCubit cubit,
    List<ProjectTaskModel> tasks,
  ) =>
      _taskDialog(
        context,
        cubit,
        null,
        tasks.expand((task) => task.assigneeIds).toSet().toList(),
      );

  Future<void> _editTask(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) =>
      _taskDialog(context, cubit, task, task.assigneeIds);

  Future<void> _taskDialog(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel? task,
    List<String> assigneeOptions,
  ) async {
    final title = TextEditingController(text: task?.title);
    final description = TextEditingController(text: task?.description);
    final expected = TextEditingController(
      text: task?.estimatedMinutes?.toString(),
    );
    final startDate = TextEditingController(text: task?.startDate);
    final dueDate = TextEditingController(text: task?.dueDate);
    final tags = TextEditingController(text: task?.tags.join(', '));
    List<String> selectedAssignees = List<String>.from(task?.assigneeIds ?? []);

    var initialStatus = (task != null &&
            project.statuses.any((s) => s.id == task.statusId))
        ? task.statusId
        : project.statuses.firstOrNull?.id;
    var statusId = initialStatus;
    var priority = task?.priority ?? 'NORMAL';

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) {
        final keyboardHeight = MediaQuery.of(sheetContext).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.only(bottom: keyboardHeight),
          child: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(sheetContext).size.height * 0.8,
            ),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            ),
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              Text(
                task == null
                    ? 'projects.newTask'.tr(context: context)
                    : 'projects.editTask'.tr(context: context),
                style: AppTextStyles.font20Bold,
              ),
              SizedBox(height: 14.h),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setState) => SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'projects.taskTitle'.tr(context: context),
                          controller: title,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText:
                              'projects.description'.tr(context: context),
                          controller: description,
                          maxLines: 3,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'projects.expectedMinutes'.tr(
                            context: context,
                          ),
                          controller: expected,
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                hintText: 'projects.startDate'.tr(
                                  context: context,
                                ),
                                controller: startDate,
                                readOnly: true,
                                suffixIcon: startDate.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () =>
                                            setState(() => startDate.clear()),
                                      )
                                    : const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                      ),
                                onTap: () async {
                                  final initial =
                                      DateTime.tryParse(startDate.text) ??
                                          DateTime.now();
                                  final picked = await showDatePicker(
                                    context: sheetContext,
                                    initialDate: initial,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      startDate.text =
                                          AppDateFormatter.formatDate(picked);
                                    });
                                  }
                                },
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: 'projects.dueDate'.tr(
                                  context: context,
                                ),
                                controller: dueDate,
                                readOnly: true,
                                suffixIcon: dueDate.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () =>
                                            setState(() => dueDate.clear()),
                                      )
                                    : const Icon(
                                        Icons.calendar_today_rounded,
                                        size: 18,
                                      ),
                                onTap: () async {
                                  final initial =
                                      DateTime.tryParse(dueDate.text) ??
                                          DateTime.now();
                                  final picked = await showDatePicker(
                                    context: sheetContext,
                                    initialDate: initial,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      dueDate.text =
                                          AppDateFormatter.formatDate(picked);
                                    });
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        DropdownButtonFormField<String>(
                          initialValue: priority,
                          decoration: InputDecoration(
                            labelText:
                                'projects.priority'.tr(context: context),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'URGENT',
                              child: Text('URGENT'),
                            ),
                            DropdownMenuItem(
                              value: 'HIGH',
                              child: Text('HIGH'),
                            ),
                            DropdownMenuItem(
                              value: 'NORMAL',
                              child: Text('NORMAL'),
                            ),
                            DropdownMenuItem(value: 'LOW', child: Text('LOW')),
                          ],
                          onChanged: (value) =>
                              setState(() => priority = value ?? 'NORMAL'),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'projects.tags'.tr(context: context),
                          controller: tags,
                        ),
                        SizedBox(height: 10.h),
                        AssigneeMultiSelectWidget(
                          selectedIds: selectedAssignees,
                          fallbackOptions: assigneeOptions,
                          onChanged: (updated) =>
                              setState(() => selectedAssignees = updated),
                        ),
                        SizedBox(height: 10.h),
                        if (project.statuses.isNotEmpty)
                          DropdownButtonFormField<String>(
                            initialValue: (statusId != null &&
                                    project.statuses
                                        .any((s) => s.id == statusId))
                                ? statusId
                                : project.statuses.first.id,
                            decoration: InputDecoration(
                              labelText:
                                  'projects.status'.tr(context: context),
                            ),
                            isExpanded: true,
                            items: project.statuses
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s.id,
                                    child: Text(s.name),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => statusId = value),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.border),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                        ),
                        child: Text(
                          'common.cancel'.tr(context: context),
                          style: AppTextStyles.font14Bold.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(
                        text: 'common.save'.tr(context: context),
                        onTap: () {
                          final ids = selectedAssignees
                              .map((item) => item.trim())
                              .where((item) => item.isNotEmpty)
                              .toList();
                          final body = <String, dynamic>{
                            'title': title.text.trim(),
                            'description': description.text.trim(),
                            'statusId': statusId,
                            'priority': priority,
                            'assigneeIds': ids,
                          };
                          body['tags'] = tags.text
                              .split(',')
                              .map((item) => item.trim())
                              .where((item) => item.isNotEmpty)
                              .toList();
                          if (startDate.text.trim().isNotEmpty) {
                            body['startDate'] = startDate.text.trim();
                          }
                          if (dueDate.text.trim().isNotEmpty) {
                            body['dueDate'] = dueDate.text.trim();
                          }
                          final expectedMinutes = int.tryParse(
                            expected.text.trim(),
                          );
                          if (expectedMinutes != null) {
                            body['estimatedMinutes'] = expectedMinutes;
                          }
                          if (task == null) {
                            cubit.createTask(project.id, body);
                          } else {
                            cubit.updateTask(task.id, body);
                            cubit.assignTask(task.id, ids);
                            cubit.updateTaskTags(
                              task.id,
                              body['tags'] as List<String>,
                            );
                          }
                          Navigator.pop(sheetContext);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
    await Future<void>.delayed(const Duration(milliseconds: 350));
    title.dispose();
    description.dispose();
    expected.dispose();
    startDate.dispose();
    dueDate.dispose();
    tags.dispose();
  }
}
