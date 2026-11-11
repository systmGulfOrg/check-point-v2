import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_employee_contact_action_tile_widget.dart';

class AdminEmployeeContactDialogWidget extends StatelessWidget {
  const AdminEmployeeContactDialogWidget({
    required this.name,
    required this.phone,
    super.key,
  });

  final String name;
  final String phone;

  static Future<void> show(
    BuildContext context, {
    required String name,
    required String phone,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          AdminEmployeeContactDialogWidget(name: name, phone: phone),
    );
  }

  Future<void> _makeCall(BuildContext context) async {
    Navigator.of(context).pop();
    final uri = Uri.parse('tel:$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        CustomSnackBar.showError(
          context,
          message: 'employee.profile.cannotLaunchCall'.tr(context: context),
        );
      }
    }
  }

  Future<void> _openWhatsApp(BuildContext context) async {
    Navigator.of(context).pop();
    String cleanNumber = phone.replaceAll(RegExp(r'[^\d+]'), '');
    if (cleanNumber.startsWith('00')) {
      cleanNumber = cleanNumber.substring(2);
    } else if (cleanNumber.startsWith('+')) {
      cleanNumber = cleanNumber.substring(1);
    } else if (cleanNumber.startsWith('01') && cleanNumber.length == 11) {
      cleanNumber = '2$cleanNumber';
    }

    final uri = Uri.parse('https://wa.me/$cleanNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        CustomSnackBar.showError(
          context,
          message: 'employee.profile.cannotLaunchWhatsApp'.tr(context: context),
        );
      }
    }
  }

  void _copyNumber(BuildContext context) {
    Navigator.of(context).pop();
    Clipboard.setData(ClipboardData(text: phone));
    CustomSnackBar.show(
      context,
      message: 'employee.profile.phoneCopied'.tr(context: context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 24.h),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            hSpace(16),
            Text(
              name,
              style: AppTextStyles.font16Bold.copyWith(
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            hSpace(4),
            Directionality(
              textDirection: ui.TextDirection.ltr,
              child: Text(
                phone,
                style: AppTextStyles.font14Medium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            hSpace(20),
            AdminEmployeeContactActionTileWidget(
              icon: Icons.phone_in_talk_rounded,
              title: 'employee.profile.actionCall'.tr(context: context),
              subtitle: 'employee.profile.actionCallDesc'.tr(context: context),
              color: AppColors.success,
              onTap: () => _makeCall(context),
            ),
            hSpace(10),
            AdminEmployeeContactActionTileWidget(
              icon: Icons.chat_outlined,
              title: 'employee.profile.actionWhatsApp'.tr(context: context),
              subtitle: 'employee.profile.actionWhatsAppDesc'.tr(
                context: context,
              ),
              color: AppColors.whatsApp,
              onTap: () => _openWhatsApp(context),
            ),
            hSpace(10),
            AdminEmployeeContactActionTileWidget(
              icon: Icons.copy_rounded,
              title: 'employee.profile.actionCopyPhone'.tr(context: context),
              subtitle: 'employee.profile.actionCopyPhoneDesc'.tr(
                context: context,
              ),
              color: AppColors.brandPrimary,
              onTap: () => _copyNumber(context),
            ),
          ],
        ),
      ),
    );
  }
}
