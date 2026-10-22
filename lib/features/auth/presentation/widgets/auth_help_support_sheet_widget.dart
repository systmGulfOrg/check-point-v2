import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:check_point_v2/core/core.dart';
import 'package:check_point_v2/features/support/presentation/support_ticket_dialog_widget.dart';

/// Shows the Help & Support bottom sheet from the company code screen.
void showAuthHelpSupportSheet(BuildContext context) {
  final navigatorContext = AppRouter.navigatorKey.currentContext ?? context;
  showModalBottomSheet<void>(
    context: navigatorContext,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _AuthHelpSupportSheet(),
  );
}

class _AuthHelpSupportSheet extends StatelessWidget {
  const _AuthHelpSupportSheet();

  Future<void> _launchEmail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: 'support@systmgulf.com',
      query: 'subject=CHECK-POINT Support',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        CustomSnackBar.showError(
          context,
          message: 'auth.companyCode.supportEmail'.tr(context: context),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              margin: EdgeInsets.only(top: 12.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: 20.w,
                vertical: 16.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.companyCode.helpTitle'.tr(context: context),
                    style: AppTextStyles.font16Bold,
                  ),
                  hSpace(20),

                  // Contact support
                  _HelpOptionTile(
                    icon: Icons.mail_outline_rounded,
                    labelKey: 'auth.companyCode.contactSupport',
                    onTap: () {
                      Navigator.pop(context);
                      _launchEmail(context);
                    },
                  ),

                  // Send feedback
                  _HelpOptionTile(
                    icon: Icons.chat_bubble_outline_rounded,
                    labelKey: 'auth.companyCode.sendFeedback',
                    onTap: () {
                      Navigator.pop(context);
                      showSupportTicketDialog(context, type: 'feedback');
                    },
                  ),

                  // Report bug
                  _HelpOptionTile(
                    icon: Icons.bug_report_outlined,
                    labelKey: 'auth.companyCode.reportBug',
                    onTap: () {
                      Navigator.pop(context);
                      showSupportTicketDialog(context, type: 'bug');
                    },
                  ),

                  hSpace(16),
                  Divider(color: AppColors.border, height: 1),
                  hSpace(12),

                  // Email footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 14.r,
                        color: AppColors.placeholder,
                      ),
                      wSpace(6),
                      Text(
                        'auth.companyCode.supportEmail'.tr(context: context),
                        style: AppTextStyles.font12Regular.copyWith(
                          color: AppColors.placeholder,
                        ),
                      ),
                    ],
                  ),
                  hSpace(8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HelpOptionTile extends StatelessWidget {
  const _HelpOptionTile({
    required this.icon,
    required this.labelKey,
    required this.onTap,
  });

  final IconData icon;
  final String labelKey;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
          horizontal: 4.w,
          vertical: 14.h,
        ),
        child: Row(
          children: [
            Container(
              width: 40.r,
              height: 40.r,
              decoration: BoxDecoration(
                color: AppColors.softBrandBackground,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(icon, size: 20.r, color: AppColors.brandPrimary),
            ),
            wSpace(14),
            Expanded(
              child: Text(
                labelKey.tr(context: context),
                style: AppTextStyles.font14SemiBold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.r,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
