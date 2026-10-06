import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/utils/app_image_provider.dart';
import 'package:check_point_v2/core/widgets/app_image_preview_dialog_widget.dart';

class AppAvatarWidget extends StatelessWidget {
  const AppAvatarWidget({
    this.imageUrl,
    this.name,
    this.initials,
    this.subtitle,
    this.radius,
    this.backgroundColor,
    this.textColor,
    this.textStyle,
    this.badge,
    this.enablePreview = true,
    this.onTap,
    this.heroTag,
    super.key,
  });

  final String? imageUrl;
  final String? name;
  final String? initials;
  final String? subtitle;
  final double? radius;
  final Color? backgroundColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final Widget? badge;
  final bool enablePreview;
  final VoidCallback? onTap;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final avatarRadius = radius ?? 22.r;
    final imageProvider = AppImageProvider.resolve(imageUrl);
    final displayInitials = (initials != null && initials!.isNotEmpty)
        ? initials!
        : AppImageProvider.getInitials(name);

    final avatar = CircleAvatar(
      radius: avatarRadius,
      backgroundColor: backgroundColor ?? AppColors.softBrandBackground,
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Text(
              displayInitials,
              style:
                  textStyle ??
                  AppTextStyles.font14SemiBold.copyWith(
                    color: textColor ?? AppColors.brandPrimary,
                    fontSize: (avatarRadius * 0.7).clamp(10, 28).sp,
                  ),
            )
          : null,
    );

    Widget result = badge != null
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,
              PositionedDirectional(bottom: 0, end: 0, child: badge!),
            ],
          )
        : avatar;

    if (heroTag != null && heroTag!.isNotEmpty) {
      result = Hero(tag: heroTag!, child: result);
    }

    if (enablePreview || onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (onTap != null) {
            onTap!();
          } else if (enablePreview) {
            AppImagePreviewDialogWidget.show(
              context,
              imageUrl: imageUrl,
              name: name,
              subtitle: subtitle,
            );
          }
        },
        child: result,
      );
    }

    return result;
  }
}
