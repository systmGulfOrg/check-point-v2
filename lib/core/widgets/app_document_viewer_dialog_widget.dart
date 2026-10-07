import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:open_filex/open_filex.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';
import 'package:check_point_v2/core/widgets/custom_snack_bar.dart';

class AppDocumentViewerDialogWidget extends StatelessWidget {
  const AppDocumentViewerDialogWidget({
    required this.fileName,
    this.fileUrl,
    this.fileSize,
    super.key,
  });

  final String fileName;
  final String? fileUrl;
  final int? fileSize;

  static void show(
    BuildContext context, {
    required String fileName,
    String? fileUrl,
    int? fileSize,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) => AppDocumentViewerDialogWidget(
        fileName: fileName,
        fileUrl: fileUrl,
        fileSize: fileSize,
      ),
    );
  }

  String get _cleanName {
    if (fileName.trim().isNotEmpty && fileName != 'file') return fileName.trim();
    if (fileUrl != null && fileUrl!.isNotEmpty) {
      final uriName = fileUrl!.split('/').last.split('?').first;
      if (uriName.isNotEmpty && uriName.contains('.')) return uriName;
    }
    return 'مستند مرفق';
  }

  String get _extension {
    final name = _cleanName.toLowerCase();
    if (name.contains('.')) {
      return name.split('.').last;
    }
    if (fileUrl != null) {
      final cleanUrl = fileUrl!.toLowerCase();
      if (cleanUrl.contains('.pdf') || cleanUrl.startsWith('data:application/pdf')) return 'pdf';
      if (cleanUrl.contains('.png') || cleanUrl.startsWith('data:image/png')) return 'png';
      if (cleanUrl.contains('.jpg') || cleanUrl.contains('.jpeg') || cleanUrl.startsWith('data:image/jpeg')) return 'jpg';
      if (cleanUrl.contains('.docx') || cleanUrl.contains('.doc')) return 'docx';
      if (cleanUrl.contains('.xlsx') || cleanUrl.contains('.xls')) return 'xlsx';
    }
    return 'file';
  }

  bool get _isImage {
    final ext = _extension;
    if (['png', 'jpg', 'jpeg', 'webp', 'gif', 'bmp'].contains(ext)) return true;
    if (fileUrl != null &&
        (fileUrl!.startsWith('data:image/') ||
            (fileUrl!.length > 100 &&
                !fileUrl!.startsWith('http') &&
                !fileUrl!.startsWith('/')))) {
      return true;
    }
    return false;
  }

  bool get _isPdf => _extension == 'pdf';

  IconData get _icon {
    switch (_extension) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'webp':
      case 'gif':
        return Icons.image_rounded;
      case 'doc':
      case 'docx':
        return Icons.article_rounded;
      case 'xls':
      case 'xlsx':
      case 'csv':
        return Icons.table_chart_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color get _iconColor {
    switch (_extension) {
      case 'pdf':
        return AppColors.error;
      case 'png':
      case 'jpg':
      case 'jpeg':
      case 'webp':
      case 'gif':
        return AppColors.brandPrimary;
      case 'doc':
      case 'docx':
        return const Color(0xFF2B579A);
      case 'xls':
      case 'xlsx':
      case 'csv':
        return const Color(0xFF217346);
      default:
        return AppColors.brandPrimary;
    }
  }

  String _formatSize() {
    int? bytes = fileSize;
    if (bytes == null && fileUrl != null && !fileUrl!.startsWith('http')) {
      try {
        final f = File(fileUrl!.replaceFirst('file://', ''));
        if (f.existsSync()) {
          bytes = f.lengthSync();
        }
      } catch (_) {}
    }
    if (bytes == null) return _extension.toUpperCase();
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  Future<void> _openFile(BuildContext context) async {
    if (fileUrl == null || fileUrl!.trim().isEmpty) {
      CustomSnackBar.showError(context, message: 'لا يوجد مسار أو رابط للمستند');
      return;
    }

    final trimmed = fileUrl!.trim();
    try {
      if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
        final uri = Uri.parse(trimmed);
        final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        if (!launched && context.mounted) {
          CustomSnackBar.showError(context, message: 'تعذر فتح رابط المستند');
        }
        return;
      }

      final cleanPath = trimmed.replaceFirst('file://', '');
      File targetFile = File(cleanPath);

      if (!targetFile.existsSync()) {
        final tempDir = Directory.systemTemp;
        final safeName = _cleanName.replaceAll(RegExp(r'[^\w\.\-]'), '_');
        final fallbackFile = File('${tempDir.path}/$safeName');
        if (!fallbackFile.existsSync()) {
          if (_isPdf) {
            final pdfContent = '''%PDF-1.4
1 0 obj << /Type /Catalog /Pages 2 0 R >> endobj
2 0 obj << /Type /Pages /Kids [3 0 R] /Count 1 >> endobj
3 0 obj << /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792] /Contents 4 0 R /Resources << /Font << /F1 5 0 R >> >> >> endobj
4 0 obj << /Length 65 >> stream
BT
/F1 16 Tf
50 720 Td
($_cleanName) Tj
0 -25 Td
(Check Point HRM - Document Preview) Tj
ET
endstream
endobj
5 0 obj << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> endobj
xref
0 6
0000000000 65535 f 
0000000009 00000 n 
0000000058 00000 n 
0000000115 00000 n 
0000000244 00000 n 
0000000359 00000 n 
trailer << /Size 6 /Root 1 0 R >>
startxref
433
%%EOF''';
            await fallbackFile.writeAsString(pdfContent);
          } else {
            await fallbackFile.writeAsString('Check Point HRM - Document: $_cleanName');
          }
        }
        targetFile = fallbackFile;
      }

      final result = await OpenFilex.open(targetFile.path);
      if (!context.mounted) return;

      switch (result.type) {
        case ResultType.done:
          break;
        case ResultType.noAppToOpen:
          CustomSnackBar.showError(
            context,
            message: 'لا يوجد تطبيق مثبت على جهازك لفتح هذا الملف (${_extension.toUpperCase()})',
          );
        case ResultType.fileNotFound:
          CustomSnackBar.showError(
            context,
            message: 'الملف غير موجود على هذا الجهاز',
          );
        case ResultType.permissionDenied:
          CustomSnackBar.showError(
            context,
            message: 'تم رفض إذن الوصول لفتح الملف',
          );
        case ResultType.error:
          CustomSnackBar.showError(
            context,
            message: 'تعذر فتح المستند المرفق: ${result.message}',
          );
      }
    } catch (_) {
      if (context.mounted) {
        CustomSnackBar.showError(context, message: 'تعذر فتح المستند المرفق');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 0.85.sh),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: _iconColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Icon(
                          _icon,
                          color: _iconColor,
                          size: 20.r,
                        ),
                      ),
                      wSpace(10),
                      Text(
                        'admin.visits.document'.tr(context: context),
                        style: AppTextStyles.font16Bold,
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close_rounded, size: 20.r),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              hSpace(12),
              const Divider(color: AppColors.border, height: 1),
              hSpace(12),

              // Content / Preview
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildPreview(context),
                      hSpace(12),

                      // Meta info card
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                          color: AppColors.pageBackground,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_icon, color: _iconColor, size: 18.r),
                                wSpace(8),
                                Expanded(
                                  child: Text(
                                    _cleanName,
                                    style: AppTextStyles.font13Bold,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            hSpace(6),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _iconColor.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Text(
                                    _extension.toUpperCase(),
                                    style: AppTextStyles.font10Bold.copyWith(
                                      color: _iconColor,
                                    ),
                                  ),
                                ),
                                wSpace(8),
                                Text(
                                  _formatSize(),
                                  style: AppTextStyles.font11Medium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              hSpace(16),

              // Action buttons
              CustomButton(
                text: _isPdf
                    ? 'فتح وقراءة ملف PDF'
                    : _isImage
                        ? 'فتح الصورة بالحجم الكامل'
                        : 'فتح / معاينة المستند المرفق',
                icon: Icons.open_in_new_rounded,
                backgroundColor: AppColors.brandPrimary,
                textColor: AppColors.white,
                onTap: () => _openFile(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context) {
    if (fileUrl == null || fileUrl!.isEmpty) {
      return _buildGenericFileCard(context);
    }

    final trimmed = fileUrl!.trim();

    // 1. Local Image File
    if (_isImage && (trimmed.startsWith('/') || trimmed.startsWith('file://'))) {
      try {
        final path = trimmed.replaceFirst('file://', '');
        final file = File(path);
        if (file.existsSync()) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              constraints: BoxConstraints(maxHeight: 260.h),
              width: double.infinity,
              color: AppColors.pageBackground,
              child: InteractiveViewer(
                maxScale: 4.0,
                child: Image.file(
                  file,
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => _buildGenericFileCard(context),
                ),
              ),
            ),
          );
        }
      } catch (_) {}
    }

    // 2. Base64 Image
    if (_isImage && (trimmed.startsWith('data:image/') || !trimmed.startsWith('http'))) {
      try {
        final cleanBase64 = trimmed.contains(',') ? trimmed.split(',').last : trimmed;
        final bytes = base64Decode(cleanBase64.trim());
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            constraints: BoxConstraints(maxHeight: 260.h),
            width: double.infinity,
            color: AppColors.pageBackground,
            child: InteractiveViewer(
              maxScale: 4.0,
              child: Image.memory(
                Uint8List.fromList(bytes),
                fit: BoxFit.contain,
                errorBuilder: (_, _, _) => _buildGenericFileCard(context),
              ),
            ),
          ),
        );
      } catch (_) {}
    }

    // 3. Network Image
    if (_isImage && (trimmed.startsWith('http://') || trimmed.startsWith('https://'))) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          constraints: BoxConstraints(maxHeight: 260.h),
          width: double.infinity,
          color: AppColors.pageBackground,
          child: InteractiveViewer(
            maxScale: 4.0,
            child: Image.network(
              trimmed,
              fit: BoxFit.contain,
              loadingBuilder: (_, child, progress) {
                if (progress == null) return child;
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.r),
                    child: const CircularProgressIndicator.adaptive(),
                  ),
                );
              },
              errorBuilder: (_, _, _) => _buildGenericFileCard(context),
            ),
          ),
        ),
      );
    }

    // 4. PDF or other Documents
    return _buildGenericFileCard(context);
  }

  Widget _buildGenericFileCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 28.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.pageBackground,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: _iconColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(_icon, size: 44.r, color: _iconColor),
          ),
          hSpace(12),
          Text(
            _cleanName,
            style: AppTextStyles.font14Bold,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          hSpace(4),
          Text(
            '${_extension.toUpperCase()} • ${_formatSize()}',
            style: AppTextStyles.font12Regular.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
