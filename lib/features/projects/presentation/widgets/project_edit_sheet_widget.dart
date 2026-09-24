import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/data/models/locations/department_response_model.dart';
import '../../data/models/project_models.dart';

class ProjectEditSheetWidget extends StatefulWidget {
  const ProjectEditSheetWidget({
    required this.project,
    required this.departments,
    required this.employees,
    required this.onSave,
    super.key,
  });

  final ProjectModel? project;
  final List<DepartmentModel> departments;
  final List<EmployeeModel> employees;
  final ValueChanged<Map<String, dynamic>> onSave;

  @override
  State<ProjectEditSheetWidget> createState() => _ProjectEditSheetWidgetState();
}

class _ProjectEditSheetWidgetState extends State<ProjectEditSheetWidget> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _codeController;
  String? _selectedDepartmentId;
  String? _selectedManagerId;

  bool get isEditing => widget.project != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.project?.name);
    _descriptionController =
        TextEditingController(text: widget.project?.description);
    _codeController = TextEditingController(text: widget.project?.code);
    _selectedDepartmentId = widget.project?.departmentId;
    _selectedManagerId = widget.project?.managerId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.85,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
      child: SafeArea(
        child: Form(
          key: _formKey,
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
                  (isEditing ? 'projects.editProject' : 'projects.newProject')
                      .tr(context: context),
                  style: AppTextStyles.font20Bold,
                ),
                SizedBox(height: 18.h),
                CustomTextFormField(
                  hintText: 'projects.name'.tr(context: context),
                  controller: _nameController,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'validation.required'.tr() : null,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  hintText: 'projects.code'.tr(context: context),
                  controller: _codeController,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  hintText: 'projects.description'.tr(context: context),
                  controller: _descriptionController,
                  maxLines: 3,
                ),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String?>(
                  initialValue: (_selectedDepartmentId != null &&
                          widget.departments.any(
                            (d) => d.id.toString() == _selectedDepartmentId,
                          ))
                      ? _selectedDepartmentId
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
                    ...widget.departments.map(
                      (dept) => DropdownMenuItem<String?>(
                        value: dept.id.toString(),
                        child: Text(dept.departmentName ?? ''),
                      ),
                    ),
                  ],
                  onChanged: (val) =>
                      setState(() => _selectedDepartmentId = val),
                ),
                SizedBox(height: 10.h),
                DropdownButtonFormField<String?>(
                  initialValue: (_selectedManagerId != null &&
                          widget.employees.any((e) => e.id == _selectedManagerId))
                      ? _selectedManagerId
                      : null,
                  decoration: InputDecoration(
                    labelText: 'projects.responsiblePerson'.tr(context: context),
                  ),
                  isExpanded: true,
                  items: [
                    DropdownMenuItem<String?>(
                      value: null,
                      child: Text('projects.allOrUnassigned'.tr(context: context)),
                    ),
                    ...widget.employees.map(
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
                      setState(() => _selectedManagerId = val),
                ),
                SizedBox(height: 20.h),
                Row(
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
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomButton(
                        text: 'common.save'.tr(context: context),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            final body = <String, dynamic>{
                              'name': _nameController.text.trim(),
                              'code': _codeController.text.trim().isEmpty
                                  ? null
                                  : _codeController.text.trim(),
                              'description': _descriptionController.text.trim(),
                              'departmentId': _selectedDepartmentId,
                              'managerId': _selectedManagerId,
                            };
                            widget.onSave(body);
                            Navigator.pop(context);
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
    );
  }
}
