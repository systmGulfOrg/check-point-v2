import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/widgets/custom_button.dart';

class ContractorReportExportButtonWidget extends StatelessWidget {
  const ContractorReportExportButtonWidget({
    super.key,
    required this.csvBuilder,
  });

  final String Function() csvBuilder;

  Future<void> _export(BuildContext context) async {
    final directory = await getTemporaryDirectory();
    final file = File(
      '${directory.path}/attendance-report-${DateTime.now().millisecondsSinceEpoch}.csv',
    );
    await file.writeAsString('\ufeff${csvBuilder()}');
    if (!context.mounted) return;
    await Share.shareXFiles([
      XFile(file.path, mimeType: 'text/csv'),
    ], subject: 'contractor.reports.title'.tr());
  }

  @override
  Widget build(BuildContext context) => CustomButton(
    text: 'contractor.reports.exportReport'.tr(),
    onTap: () => _export(context),
    backgroundColor: AppColors.brandPrimary,
    height: 48.h,
  );
}
