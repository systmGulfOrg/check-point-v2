import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/core/di/service_locator.dart';
import 'package:check_point_v2/features/admin/data/models/employee/edit_employee_request_body.dart';
import 'package:check_point_v2/features/admin/data/models/employee/employee_model.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee/admin_employees_cubit.dart';
import 'package:check_point_v2/features/admin/presentation/cubit/employee_profile/admin_employee_profile_cubit.dart';
import 'admin_employee_document_item_widget.dart';
import 'admin_employee_profile_info_card_widget.dart';

class AdminEmployeeProfileDocumentsCardWidget extends StatefulWidget {
  const AdminEmployeeProfileDocumentsCardWidget({
    required this.employee,
    super.key,
  });

  final EmployeeModel employee;

  @override
  State<AdminEmployeeProfileDocumentsCardWidget> createState() =>
      _AdminEmployeeProfileDocumentsCardWidgetState();
}

class _AdminEmployeeProfileDocumentsCardWidgetState
    extends State<AdminEmployeeProfileDocumentsCardWidget> {
  String? _uploadingType;

  List<Map<String, dynamic>> _getDocuments() {
    final rawDocs = widget.employee.documents;
    if (rawDocs == null) return [];
    return rawDocs
        .whereType<Map>()
        .map((m) => Map<String, dynamic>.from(m))
        .toList();
  }

  Map<String, dynamic>? _findDoc(List<Map<String, dynamic>> docs, String type) {
    for (final d in docs) {
      if (d['type'] == type || d['id'] == type) return d;
    }
    return null;
  }

  Future<void> _uploadDocument(String docType, String docTitle) async {
    final empId = widget.employee.id;
    if (empId == null) return;

    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc', 'docx'],
        withData: true,
      );

      if (result == null || result.files.isEmpty) return;
      final file = result.files.first;

      setState(() => _uploadingType = docType);

      String? base64Data;
      final ext = file.extension?.toLowerCase() ?? 'pdf';
      final mimeType = ext == 'png'
          ? 'image/png'
          : (ext == 'jpg' || ext == 'jpeg')
          ? 'image/jpeg'
          : ext == 'pdf'
          ? 'application/pdf'
          : 'application/octet-stream';

      if (file.bytes != null) {
        base64Data = 'data:$mimeType;base64,${base64Encode(file.bytes!)}';
      } else if (file.path != null) {
        final bytes = await File(file.path!).readAsBytes();
        base64Data = 'data:$mimeType;base64,${base64Encode(bytes)}';
      }

      if (base64Data == null) {
        setState(() => _uploadingType = null);
        return;
      }

      final docs = _getDocuments();
      docs.removeWhere((d) => d['type'] == docType || d['id'] == docType);
      docs.add({
        'id': docType,
        'type': docType,
        'name': file.name,
        'url': base64Data,
        'mimeType': mimeType,
        'size': file.size,
        'uploadedAt': DateTime.now().toIso8601String(),
      });

      final cubit = sl<AdminEmployeesCubit>();
      final error = await cubit.editEmployee(
        empId,
        EditEmployeeRequestBody(documents: docs),
      );

      if (!mounted) return;
      setState(() => _uploadingType = null);

      if (error == null) {
        CustomSnackBar.showSuccess(
          context,
          message: 'employee.profile.docUploadedSuccess'.tr(context: context),
        );
        context.read<AdminEmployeeProfileCubit>().load(
          empId,
          initialEmployee: widget.employee,
        );
      } else {
        CustomSnackBar.showError(context, message: error.tr(context: context));
      }
    } catch (_) {
      if (mounted) setState(() => _uploadingType = null);
    }
  }

  Future<void> _deleteDocument(String docType) async {
    final empId = widget.employee.id;
    if (empId == null) return;

    final docs = _getDocuments();
    docs.removeWhere((d) => d['type'] == docType || d['id'] == docType);

    setState(() => _uploadingType = docType);
    final cubit = sl<AdminEmployeesCubit>();
    final error = await cubit.editEmployee(
      empId,
      EditEmployeeRequestBody(documents: docs),
    );

    if (!mounted) return;
    setState(() => _uploadingType = null);

    if (error == null) {
      CustomSnackBar.showSuccess(
        context,
        message: 'employee.profile.docDeletedSuccess'.tr(context: context),
      );
      context.read<AdminEmployeeProfileCubit>().load(
        empId,
        initialEmployee: widget.employee,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final docs = _getDocuments();
    final contractDoc = _findDoc(docs, 'contract');
    final degreeDoc = _findDoc(docs, 'degree');
    final criminalDoc = _findDoc(docs, 'criminal_record');
    final insuranceDoc = _findDoc(docs, 'insurance');

    final otherDocs = docs.where((d) {
      final t = d['type'] ?? d['id'];
      return t != 'contract' &&
          t != 'degree' &&
          t != 'criminal_record' &&
          t != 'insurance';
    }).toList();

    return AdminEmployeeProfileInfoCardWidget(
      title: 'employee.profile.sectionDocuments'.tr(context: context),
      icon: Icons.folder_copy_outlined,
      children: [
        AdminEmployeeDocumentItemWidget(
          title: 'employee.profile.docContract'.tr(context: context),
          fileName: contractDoc?['name'] as String?,
          isUploaded: contractDoc != null,
          isUploading: _uploadingType == 'contract',
          onUpload: () => _uploadDocument('contract', 'Employment Contract'),
          onDelete: contractDoc != null
              ? () => _deleteDocument('contract')
              : null,
        ),
        AdminEmployeeDocumentItemWidget(
          title: 'employee.profile.docDegree'.tr(context: context),
          fileName: degreeDoc?['name'] as String?,
          isUploaded: degreeDoc != null,
          isUploading: _uploadingType == 'degree',
          onUpload: () => _uploadDocument('degree', 'Graduation Certificate'),
          onDelete: degreeDoc != null ? () => _deleteDocument('degree') : null,
        ),
        AdminEmployeeDocumentItemWidget(
          title: 'employee.profile.docCriminal'.tr(context: context),
          fileName: criminalDoc?['name'] as String?,
          isUploaded: criminalDoc != null,
          isUploading: _uploadingType == 'criminal_record',
          onUpload: () => _uploadDocument('criminal_record', 'Criminal Record'),
          onDelete: criminalDoc != null
              ? () => _deleteDocument('criminal_record')
              : null,
        ),
        AdminEmployeeDocumentItemWidget(
          title: 'employee.profile.docInsurance'.tr(context: context),
          fileName: insuranceDoc?['name'] as String?,
          isUploaded: insuranceDoc != null,
          isUploading: _uploadingType == 'insurance',
          onUpload: () => _uploadDocument('insurance', 'Social Insurance Form'),
          onDelete: insuranceDoc != null
              ? () => _deleteDocument('insurance')
              : null,
        ),
        ...otherDocs.map((d) {
          final type = (d['type'] ?? d['id'] ?? 'other').toString();
          return AdminEmployeeDocumentItemWidget(
            title: (d['name'] ?? 'Additional Document').toString(),
            fileName: d['name'] as String?,
            isUploaded: true,
            isUploading: _uploadingType == type,
            onUpload: () =>
                _uploadDocument(type, d['name']?.toString() ?? 'Document'),
            onDelete: () => _deleteDocument(type),
          );
        }),
        hSpace(4),
        OutlinedButton.icon(
          onPressed: () {
            final customId = 'other_${DateTime.now().millisecondsSinceEpoch}';
            _uploadDocument(customId, 'Additional Document');
          },
          icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
          label: Text('employee.profile.addOtherDoc'.tr(context: context)),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.brandPrimary,
            side: const BorderSide(color: AppColors.brandPrimary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(vertical: 10.h),
          ),
        ),
      ],
    );
  }
}
