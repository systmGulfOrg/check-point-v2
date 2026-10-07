import 'package:flutter/material.dart';
import 'package:check_point_v2/core/widgets/app_document_viewer_dialog_widget.dart';

class AdminCustomerVisitDocViewerDialogWidget extends StatelessWidget {
  const AdminCustomerVisitDocViewerDialogWidget({
    required this.fileName,
    this.fileUrl,
    super.key,
  });

  final String fileName;
  final String? fileUrl;

  @override
  Widget build(BuildContext context) {
    return AppDocumentViewerDialogWidget(
      fileName: fileName,
      fileUrl: fileUrl,
    );
  }
}
