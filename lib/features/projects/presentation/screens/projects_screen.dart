import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_cubit.dart';
import 'package:check_point_v2/features/auth/presentation/cubit/profile/auth_profile_state.dart';
import '../../data/models/project_models.dart';
import '../cubit/projects_cubit.dart';
import '../cubit/projects_state.dart';

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
          role.toLowerCase() == 'admin' || role.toLowerCase() == 'hr',
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
          ProjectsStateLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          ProjectsStateSuccess(:final projects) => RefreshIndicator(
            onRefresh: context.read<ProjectsCubit>().loadProjects,
            child: ListView(
              padding: EdgeInsets.all(16.r),
              children: [
                if (canManage)
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton.icon(
                      onPressed: () => _createProject(context),
                      icon: const Icon(Icons.add),
                      label: Text('projects.newProject'.tr(context: context)),
                    ),
                  ),
                if (projects.isEmpty)
                  SizedBox(
                    height: 220.h,
                    child: Center(
                      child: Text('projects.empty'.tr(context: context)),
                    ),
                  )
                else
                  ...projects.map(
                    (project) => Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: AppCardContainerWidget(
                        padding: EdgeInsets.zero,
                        onTap: () => _openBoard(project),
                        child: ListTile(
                          title: Text(
                            project.name,
                            style: AppTextStyles.font16Bold,
                          ),
                          subtitle: Text(
                            project.description ?? project.code ?? '',
                          ),
                          trailing: const Icon(Icons.chevron_right),
                        ),
                      ),
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
        role.toLowerCase() == 'admin' || role.toLowerCase() == 'hr',
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

  Future<void> _createProject(BuildContext context) async {
    final name = TextEditingController();
    final description = TextEditingController();
    final code = TextEditingController();
    final formKey = GlobalKey<FormState>();
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(
          20.w,
          24.h,
          20.w,
          MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: SafeArea(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'projects.newProject'.tr(context: context),
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
                  SizedBox(height: 18.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(sheetContext),
                        child: Text('common.cancel'.tr(context: context)),
                      ),
                      SizedBox(width: 8.w),
                      SizedBox(
                        width: 110.w,
                        child: CustomButton(
                          text: 'common.save'.tr(context: context),
                          icon: Icons.save_outlined,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              context.read<ProjectsCubit>().createProject({
                                'name': name.text.trim(),
                                'code': code.text.trim().isEmpty
                                    ? null
                                    : code.text.trim(),
                                'description': description.text.trim(),
                              });
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
                  padding: EdgeInsetsDirectional.only(end: 12.w, top: 4.h),
                  child: Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Wrap(
                      spacing: 4.w,
                      children: [
                        TextButton.icon(
                          onPressed: () => _addStatus(context, cubit),
                          icon: const Icon(Icons.add),
                          label: Text(
                            'projects.addStatus'.tr(context: context),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () =>
                              _createTask(context, cubit, const []),
                          icon: const Icon(Icons.add),
                          label: Text(
                            'projects.addTaskButton'.tr(context: context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsetsDirectional.fromSTEB(
                    16.w,
                    8.h,
                    16.w,
                    24.h,
                  ),
                  itemCount: boardProject.statuses.length,
                  itemBuilder: (context, statusIndex) {
                    final status = boardProject.statuses[statusIndex];
                    final columnTasks = tasks
                        .where((task) => task.statusId == status.id)
                        .toList();
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
                        if (data.taskId != null &&
                            data.sourceStatusId != status.id) {
                          cubit.moveTask(data.taskId!, status.id);
                        } else if (data.statusId != null &&
                            data.statusId != status.id) {
                          final ids = boardProject.statuses
                              .map((item) => item.id)
                              .toList();
                          final fromIndex = ids.indexOf(data.statusId!);
                          if (fromIndex >= 0) {
                            ids.removeAt(fromIndex);
                            ids.insert(statusIndex, data.statusId!);
                            cubit.reorderStatuses(project.id, ids);
                          }
                        }
                      },
                      builder: (context, candidates, rejected) =>
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            curve: Curves.easeOut,
                            width: 270.w,
                            margin: EdgeInsetsDirectional.only(end: 12.w),
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: isHovered
                                  ? AppColors.softBrandBackground
                                  : AppColors.pageBackground,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: isHovered
                                    ? AppColors.brandPrimary
                                    : AppColors.transparent,
                                width: isHovered ? 1.5 : 0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LongPressDraggable<ProjectDragData>(
                                  data: ProjectDragData(statusId: status.id),
                                  maxSimultaneousDrags: canManage ? 1 : 0,
                                  onDragStarted: () => setState(
                                    () => draggingStatusId = status.id,
                                  ),
                                  onDragEnd: (_) => setState(() {
                                    draggingStatusId = null;
                                    hoveredStatusId = null;
                                  }),
                                  feedback: Material(
                                    color: AppColors.transparent,
                                    child: SizedBox(
                                      width: 240.w,
                                      child: AppCardContainerWidget(
                                        child: Text(
                                          status.name,
                                          style: AppTextStyles.font14SemiBold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  child: AnimatedScale(
                                    scale: draggingStatusId == status.id
                                        ? .96
                                        : 1,
                                    duration: const Duration(milliseconds: 160),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.drag_indicator,
                                          size: 18,
                                        ),
                                        Expanded(
                                          child: Text(
                                            status.name,
                                            style: AppTextStyles.font14SemiBold,
                                          ),
                                        ),
                                        Text(
                                          '${columnTasks.length}',
                                          style: AppTextStyles.font12Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Expanded(
                                  child: ListView.separated(
                                    itemCount: columnTasks.length,
                                    separatorBuilder: (_, _) =>
                                        SizedBox(height: 8.h),
                                    itemBuilder: (context, index) {
                                      final task = columnTasks[index];
                                      return LongPressDraggable<
                                        ProjectDragData
                                      >(
                                        data: ProjectDragData(
                                          taskId: task.id,
                                          sourceStatusId: status.id,
                                        ),
                                        maxSimultaneousDrags: canManage ? 1 : 0,
                                        onDragStarted: () => setState(
                                          () => draggingTaskId = task.id,
                                        ),
                                        onDragEnd: (_) => setState(() {
                                          draggingTaskId = null;
                                          hoveredStatusId = null;
                                        }),
                                        feedback: Material(
                                          color: AppColors.transparent,
                                          child: SizedBox(
                                            width: 250.w,
                                            child: AppCardContainerWidget(
                                              child: Text(
                                                task.title,
                                                style: AppTextStyles
                                                    .font14SemiBold,
                                              ),
                                            ),
                                          ),
                                        ),
                                        childWhenDragging: Opacity(
                                          opacity: .35,
                                          child: _taskCard(
                                            context,
                                            cubit,
                                            task,
                                            boardProject,
                                          ),
                                        ),
                                        child: AnimatedScale(
                                          scale: draggingTaskId == task.id
                                              ? .97
                                              : 1,
                                          duration: const Duration(
                                            milliseconds: 160,
                                          ),
                                          child: _taskCard(
                                            context,
                                            cubit,
                                            task,
                                            boardProject,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _taskCard(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
    ProjectModel boardProject,
  ) => AppCardContainerWidget(
    padding: EdgeInsets.zero,
    onTap: () => _showTaskDetails(context, cubit, task),
    child: Padding(
      padding: EdgeInsets.all(10.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(task.title, style: AppTextStyles.font14SemiBold),
          if ((task.description ?? '').isNotEmpty) ...[
            SizedBox(height: 5.h),
            Text(
              task.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font12Regular,
            ),
          ],
          SizedBox(height: 8.h),
          Row(
            children: [
              if (task.priority != null)
                Chip(
                  label: Text(task.priority!),
                  visualDensity: VisualDensity.compact,
                ),
              const Spacer(),
              if (canManage)
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_horiz),
                  onSelected: (value) => value == 'delete'
                      ? cubit.deleteTask(task.id)
                      : cubit.moveTask(task.id, value),
                  itemBuilder: (_) => [
                    ...boardProject.statuses.map(
                      (item) =>
                          PopupMenuItem(value: item.id, child: Text(item.name)),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('common.delete'.tr(context: context)),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    ),
  );

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
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (sheetContext) => BlocProvider.value(
        value: cubit,
        child: BlocBuilder<ProjectsCubit, ProjectsState>(
          builder: (context, state) {
            final audit = state is ProjectsStateSuccess
                ? state.audit
                : const <TaskAuditModel>[];
            return SafeArea(
              child: FractionallySizedBox(
                heightFactor: .92,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              task.title,
                              style: AppTextStyles.font20Bold,
                            ),
                          ),
                          if (canManage)
                            IconButton(
                              onPressed: () {
                                Navigator.pop(sheetContext);
                                _editTask(context, cubit, task);
                              },
                              icon: const Icon(Icons.edit_outlined),
                            ),
                        ],
                      ),
                      SizedBox(height: 14.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          _detailPill(
                            context,
                            'projects.status'.tr(context: context),
                            project.statuses
                                .firstWhere(
                                  (item) => item.id == task.statusId,
                                  orElse: () => project.statuses.first,
                                )
                                .name,
                          ),
                          _detailPill(
                            context,
                            'projects.priority'.tr(context: context),
                            task.priority ?? 'NORMAL',
                          ),
                          _detailPill(
                            context,
                            'projects.expectedMinutes'.tr(context: context),
                            '${task.estimatedMinutes ?? 0} min',
                          ),
                          if (task.startDate != null)
                            _detailPill(
                              context,
                              'projects.startDate'.tr(context: context),
                              task.startDate!,
                            ),
                          if (task.dueDate != null)
                            _detailPill(
                              context,
                              'projects.dueDate'.tr(context: context),
                              task.dueDate!,
                            ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _detailHeading(
                        context,
                        'projects.description'.tr(context: context),
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(14.r),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          task.description?.isNotEmpty == true
                              ? task.description!
                              : 'projects.noDescription'.tr(context: context),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      _detailHeading(
                        context,
                        'projects.assignees'.tr(context: context),
                      ),
                      if (task.assigneeIds.isEmpty)
                        Text(
                          'projects.noAssignees'.tr(context: context),
                          style: AppTextStyles.font13Regular,
                        )
                      else
                        ...task.assigneeIds.map(
                          (id) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              child: Text(id.characters.first.toUpperCase()),
                            ),
                            title: Text(id),
                          ),
                        ),
                      SizedBox(height: 12.h),
                      _detailHeading(
                        context,
                        'projects.attachments'.tr(context: context),
                      ),
                      if (task.attachments.isEmpty)
                        Text(
                          'projects.noAttachments'.tr(context: context),
                          style: AppTextStyles.font13Regular,
                        )
                      else
                        ...task.attachments.map(
                          (file) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.attach_file),
                            title: Text(file.fileName ?? 'file'),
                          ),
                        ),
                      SizedBox(height: 12.h),
                      _detailHeading(
                        context,
                        'projects.activity'.tr(context: context),
                      ),
                      if (audit.isEmpty)
                        Text(
                          'projects.noActivity'.tr(context: context),
                          style: AppTextStyles.font13Regular,
                        )
                      else
                        ...audit.map(
                          (item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.history),
                            title: Text(item.action ?? ''),
                            subtitle: Text(
                              '${item.actorName ?? ''}  ${item.createdAt ?? ''}',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _detailHeading(BuildContext context, String text) => Padding(
    padding: EdgeInsets.only(bottom: 8.h),
    child: Text(text, style: AppTextStyles.font16Bold),
  );

  Widget _detailPill(BuildContext context, String label, String value) =>
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
        decoration: BoxDecoration(
          color: AppColors.pageBackground,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text('$label: $value', style: AppTextStyles.font12Regular),
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(sheetContext),
                    child: Text('common.cancel'.tr(context: context)),
                  ),
                  SizedBox(
                    width: 110.w,
                    child: CustomButton(
                      text: 'common.save'.tr(context: context),
                      icon: Icons.add,
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
  ) => _taskDialog(
    context,
    cubit,
    null,
    tasks.expand((task) => task.assigneeIds).toSet().toList(),
  );

  Future<void> _editTask(
    BuildContext context,
    ProjectsCubit cubit,
    ProjectTaskModel task,
  ) => _taskDialog(context, cubit, task, task.assigneeIds);

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
    final assignees = TextEditingController(text: task?.assigneeIds.join(', '));
    final startDate = TextEditingController(text: task?.startDate);
    final dueDate = TextEditingController(text: task?.dueDate);
    final tags = TextEditingController(text: task?.tags.join(', '));
    var statusId = task?.statusId ?? project.statuses.firstOrNull?.id;
    var priority = task?.priority ?? 'NORMAL';
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (sheetContext) => Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        padding: EdgeInsets.fromLTRB(
          20.w,
          24.h,
          20.w,
          MediaQuery.of(context).viewInsets.bottom + 20.h,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
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
                StatefulBuilder(
                  builder: (context, setState) => SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          hintText: 'projects.taskTitle'.tr(context: context),
                          controller: title,
                        ),
                        SizedBox(height: 10.h),
                        CustomTextFormField(
                          hintText: 'projects.description'.tr(context: context),
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
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: CustomTextFormField(
                                hintText: 'projects.dueDate'.tr(
                                  context: context,
                                ),
                                controller: dueDate,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        DropdownButtonFormField<String>(
                          initialValue: priority,
                          decoration: InputDecoration(
                            labelText: 'projects.priority'.tr(context: context),
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
                        CustomTextFormField(
                          hintText: 'projects.assignees'.tr(context: context),
                          controller: assignees,
                          readOnly: assigneeOptions.isNotEmpty,
                          suffixIcon: assigneeOptions.isEmpty
                              ? null
                              : DropdownButton<String>(
                                  underline: const SizedBox.shrink(),
                                  items: assigneeOptions
                                      .map(
                                        (id) => DropdownMenuItem(
                                          value: id,
                                          child: Text(id),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    if (value != null) assignees.text = value;
                                  },
                                ),
                        ),
                        DropdownButton<String>(
                          value: statusId,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(sheetContext),
                      child: Text('common.cancel'.tr(context: context)),
                    ),
                    SizedBox(
                      width: 110.w,
                      child: CustomButton(
                        text: 'common.save'.tr(context: context),
                        icon: Icons.save_outlined,
                        onTap: () {
                          final ids = assignees.text
                              .split(',')
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
      ),
    );
    await Future<void>.delayed(const Duration(milliseconds: 350));
    title.dispose();
    description.dispose();
    expected.dispose();
    assignees.dispose();
    startDate.dispose();
    dueDate.dispose();
    tags.dispose();
  }
}
