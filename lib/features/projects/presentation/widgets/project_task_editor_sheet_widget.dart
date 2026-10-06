import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/projects/data/models/project_models.dart';
import 'package:check_point_v2/features/projects/presentation/widgets/assignee_multi_select_widget.dart';

class ProjectTaskEditorSheetWidget extends StatefulWidget {
  const ProjectTaskEditorSheetWidget({
    required this.project,
    required this.onSave,
    this.task,
    this.assigneeOptions = const [],
    super.key,
  });

  final ProjectModel project;
  final ProjectTaskModel? task;
  final List<String> assigneeOptions;
  final void Function({
    required Map<String, dynamic> body,
    required List<String> assigneeIds,
    required List<String> tags,
  })
  onSave;

  @override
  State<ProjectTaskEditorSheetWidget> createState() =>
      _ProjectTaskEditorSheetWidgetState();
}

class _ProjectTaskEditorSheetWidgetState
    extends State<ProjectTaskEditorSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _expectedController;
  late final TextEditingController _startDateController;
  late final TextEditingController _dueDateController;
  late final TextEditingController _tagsController;
  late List<String> _selectedAssignees;
  String? _statusId;
  late String _priority;

  bool get isEditing => widget.task != null;

  @override
  void initState() {
    super.initState();
    final task = widget.task;
    _titleController = TextEditingController(text: task?.title);
    _descriptionController = TextEditingController(text: task?.description);
    _expectedController = TextEditingController(
      text: task?.estimatedMinutes?.toString(),
    );
    _startDateController = TextEditingController(text: task?.startDate);
    _dueDateController = TextEditingController(text: task?.dueDate);
    _tagsController = TextEditingController(text: task?.tags.join(', '));
    _selectedAssignees = List<String>.from(task?.assigneeIds ?? []);

    final initialStatus =
        (task != null &&
            widget.project.statuses.any((s) => s.id == task.statusId))
        ? task.statusId
        : widget.project.statuses.firstOrNull?.id;
    _statusId = initialStatus;
    _priority = task?.priority ?? 'NORMAL';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _expectedController.dispose();
    _startDateController.dispose();
    _dueDateController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final ids = _selectedAssignees
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();
    final tagList = _tagsController.text
        .split(',')
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    final body = <String, dynamic>{
      'title': _titleController.text.trim(),
      'description': _descriptionController.text.trim(),
      'statusId': _statusId,
      'priority': _priority,
      'assigneeIds': ids,
      'tags': tagList,
    };

    if (_startDateController.text.trim().isNotEmpty) {
      body['startDate'] = _startDateController.text.trim();
    }
    if (_dueDateController.text.trim().isNotEmpty) {
      body['dueDate'] = _dueDateController.text.trim();
    }
    final expectedMinutes = int.tryParse(_expectedController.text.trim());
    if (expectedMinutes != null) {
      body['estimatedMinutes'] = expectedMinutes;
    }

    widget.onSave(body: body, assigneeIds: ids, tags: tagList);
    Navigator.pop(context);
  }

  Color _priorityColor(String priority) {
    return switch (priority.toUpperCase()) {
      'URGENT' || 'CRITICAL' => AppColors.error,
      'HIGH' => AppColors.warning,
      'NORMAL' => AppColors.brandPrimary,
      'LOW' => AppColors.textSecondary,
      _ => AppColors.info,
    };
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.88,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        ),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header handle & title
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          width: 44.w,
                          height: 4.h,
                          decoration: BoxDecoration(
                            color: AppColors.border,
                            borderRadius: BorderRadius.circular(2.r),
                          ),
                        ),
                      ),
                      hSpace(14),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isEditing
                                ? 'projects.editTask'.tr(context: context)
                                : 'projects.newTask'.tr(context: context),
                            style: AppTextStyles.font20Bold,
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.close_rounded,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Divider(height: 1, color: AppColors.border),

                // Scrollable Form Fields
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Task Title Field
                        Text(
                          'projects.taskTitle'.tr(context: context),
                          style: AppTextStyles.font14Bold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          hintText: 'projects.taskTitle'.tr(context: context),
                          controller: _titleController,
                          validator: AppValidators.required(context: context),
                        ),
                        hSpace(14),

                        // Description Field
                        Text(
                          'projects.description'.tr(context: context),
                          style: AppTextStyles.font14Bold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          hintText: 'projects.description'.tr(context: context),
                          controller: _descriptionController,
                          maxLines: 3,
                        ),
                        hSpace(14),

                        // Start & Due Dates Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'projects.startDate'.tr(context: context),
                                    style: AppTextStyles.font14Bold,
                                  ),
                                  hSpace(6),
                                  CustomTextFormField(
                                    hintText: 'projects.startDate'.tr(
                                      context: context,
                                    ),
                                    controller: _startDateController,
                                    readOnly: true,
                                    suffixIcon:
                                        _startDateController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.clear_rounded,
                                              size: 18,
                                            ),
                                            onPressed: () => setState(
                                              () =>
                                                  _startDateController.clear(),
                                            ),
                                          )
                                        : const Icon(
                                            Icons.calendar_today_rounded,
                                            size: 18,
                                          ),
                                    onTap: () async {
                                      final initial =
                                          DateTime.tryParse(
                                            _startDateController.text,
                                          ) ??
                                          DateTime.now();
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: initial,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _startDateController.text =
                                              AppDateFormatter.formatDate(
                                                picked,
                                              );
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            wSpace(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'projects.dueDate'.tr(context: context),
                                    style: AppTextStyles.font14Bold,
                                  ),
                                  hSpace(6),
                                  CustomTextFormField(
                                    hintText: 'projects.dueDate'.tr(
                                      context: context,
                                    ),
                                    controller: _dueDateController,
                                    readOnly: true,
                                    suffixIcon:
                                        _dueDateController.text.isNotEmpty
                                        ? IconButton(
                                            icon: const Icon(
                                              Icons.clear_rounded,
                                              size: 18,
                                            ),
                                            onPressed: () => setState(
                                              () => _dueDateController.clear(),
                                            ),
                                          )
                                        : const Icon(
                                            Icons.calendar_today_rounded,
                                            size: 18,
                                          ),
                                    onTap: () async {
                                      final initial =
                                          DateTime.tryParse(
                                            _dueDateController.text,
                                          ) ??
                                          DateTime.now();
                                      final picked = await showDatePicker(
                                        context: context,
                                        initialDate: initial,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          _dueDateController.text =
                                              AppDateFormatter.formatDate(
                                                picked,
                                              );
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        hSpace(14),

                        // Expected Time Field
                        Text(
                          'projects.expectedMinutes'.tr(context: context),
                          style: AppTextStyles.font14Bold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          hintText: 'projects.expectedMinutesHint'.tr(
                            context: context,
                          ),
                          controller: _expectedController,
                          keyboardType: TextInputType.number,
                          prefixIcon: const Icon(
                            Icons.timer_outlined,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                        hSpace(14),

                        // Priority Selector (Modern Segmented Chips)
                        Text(
                          'projects.priority'.tr(context: context),
                          style: AppTextStyles.font14Bold,
                        ),
                        hSpace(8),
                        Row(
                          children: [
                            for (final p in ['LOW', 'NORMAL', 'HIGH', 'URGENT'])
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 3.w,
                                  ),
                                  child: InkWell(
                                    onTap: () => setState(() => _priority = p),
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: AnimatedContainer(
                                      duration: const Duration(
                                        milliseconds: 150,
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: _priority == p
                                            ? _priorityColor(p).withAlpha(25)
                                            : AppColors.pageBackground,
                                        borderRadius: BorderRadius.circular(
                                          10.r,
                                        ),
                                        border: Border.all(
                                          color: _priority == p
                                              ? _priorityColor(p)
                                              : AppColors.border,
                                          width: _priority == p ? 1.5 : 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          p,
                                          style: AppTextStyles.font11Medium
                                              .copyWith(
                                                color: _priority == p
                                                    ? _priorityColor(p)
                                                    : AppColors.textSecondary,
                                                fontWeight: _priority == p
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        hSpace(14),

                        // Status Dropdown
                        if (widget.project.statuses.isNotEmpty) ...[
                          Text(
                            'projects.status'.tr(context: context),
                            style: AppTextStyles.font14Bold,
                          ),
                          hSpace(6),
                          DropdownButtonFormField<String>(
                            initialValue:
                                (_statusId != null &&
                                    widget.project.statuses.any(
                                      (s) => s.id == _statusId,
                                    ))
                                ? _statusId
                                : widget.project.statuses.first.id,
                            decoration: const InputDecoration(),
                            isExpanded: true,
                            items: widget.project.statuses
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s.id,
                                    child: Text(
                                      s.name,
                                      style: AppTextStyles.font14Medium,
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) =>
                                setState(() => _statusId = value),
                          ),
                          hSpace(14),
                        ],

                        // Assignee Multi Select
                        AssigneeMultiSelectWidget(
                          selectedIds: _selectedAssignees,
                          fallbackOptions: widget.assigneeOptions,
                          onChanged: (updated) =>
                              setState(() => _selectedAssignees = updated),
                        ),
                        hSpace(14),

                        // Tags Input
                        Text(
                          'projects.tags'.tr(context: context),
                          style: AppTextStyles.font14Bold,
                        ),
                        hSpace(6),
                        CustomTextFormField(
                          hintText: 'projects.tagsHint'.tr(context: context),
                          controller: _tagsController,
                          prefixIcon: const Icon(
                            Icons.tag_rounded,
                            color: AppColors.textSecondary,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const Divider(height: 1, color: AppColors.border),

                // Bottom Action Buttons
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
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
                      wSpace(12),
                      Expanded(
                        child: CustomButton(
                          text: 'common.save'.tr(context: context),
                          onTap: _handleSubmit,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
