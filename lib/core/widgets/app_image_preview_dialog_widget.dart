import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/utils/app_image_provider.dart';
import 'package:check_point_v2/core/widgets/app_avatar_fallback_initials_widget.dart';

class AppImagePreviewDialogWidget extends StatelessWidget {
  const AppImagePreviewDialogWidget({
    this.imageUrl,
    this.name,
    this.subtitle,
    super.key,
  });

  final String? imageUrl;
  final String? name;
  final String? subtitle;

  static Future<void> show(
    BuildContext context, {
    String? imageUrl,
    String? name,
    String? subtitle,
  }) => showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Dismiss',
    barrierColor: Colors.black.withValues(alpha: 0.75),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, anim1, anim2) => AppImagePreviewDialogWidget(
      imageUrl: imageUrl,
      name: name,
      subtitle: subtitle,
    ),
    transitionBuilder: (context, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 8 * anim1.value,
        sigmaY: 8 * anim1.value,
      ),
      child: FadeTransition(
        opacity: anim1,
        child: ScaleTransition(
          scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
          child: child,
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final imageProvider = AppImageProvider.resolve(imageUrl);
    final initials = AppImageProvider.getInitials(name);

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    if (name != null && name!.isNotEmpty) ...[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name!,
                              style: AppTextStyles.font16Bold.copyWith(
                                color: AppColors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (subtitle != null && subtitle!.isNotEmpty) ...[
                              hSpace(2),
                              Text(
                                subtitle!,
                                style: AppTextStyles.font12Regular.copyWith(
                                  color: AppColors.white.withValues(alpha: 0.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),
                      wSpace(12),
                    ] else
                      const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.white,
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),
                hSpace(16),
                Flexible(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.r),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 380.w,
                        maxHeight: 440.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(24.r),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: 0.15),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: imageProvider != null
                          ? InteractiveViewer(
                              minScale: 0.8,
                              maxScale: 4.0,
                              child: Image(
                                image: imageProvider,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (context, error, stackTrace) =>
                                    AppAvatarFallbackInitialsWidget(
                                      initials: initials,
                                    ),
                              ),
                            )
                          : AppAvatarFallbackInitialsWidget(initials: initials),
                    ),
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
