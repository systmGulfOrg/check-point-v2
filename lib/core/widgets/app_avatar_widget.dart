import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';
import 'package:check_point_v2/core/utils/app_image_provider.dart';
import 'package:check_point_v2/core/widgets/app_image_preview_dialog_widget.dart';

class AppAvatarWidget extends StatefulWidget {
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
  State<AppAvatarWidget> createState() => _AppAvatarWidgetState();
}

class _AppAvatarWidgetState extends State<AppAvatarWidget> {
  bool _hasError = false;

  @override
  void didUpdateWidget(covariant AppAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.imageUrl != widget.imageUrl) {
      _hasError = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final avatarRadius = widget.radius ?? 22.r;
    final imageProvider = _hasError
        ? null
        : AppImageProvider.resolve(widget.imageUrl);
    final displayInitials =
        (widget.initials != null && widget.initials!.isNotEmpty)
        ? widget.initials!
        : AppImageProvider.getInitials(widget.name);

    final avatar = CircleAvatar(
      radius: avatarRadius,
      backgroundColor: widget.backgroundColor ?? AppColors.softBrandBackground,
      backgroundImage: imageProvider,
      onBackgroundImageError: imageProvider != null
          ? (_, _) {
              if (mounted) setState(() => _hasError = true);
            }
          : null,
      child: imageProvider == null
          ? Text(
              displayInitials,
              style:
                  widget.textStyle ??
                  AppTextStyles.font14SemiBold.copyWith(
                    color: widget.textColor ?? AppColors.brandPrimary,
                    fontSize: (avatarRadius * 0.7).clamp(10, 28).sp,
                  ),
            )
          : null,
    );

    Widget result = widget.badge != null
        ? Stack(
            clipBehavior: Clip.none,
            children: [
              avatar,
              PositionedDirectional(bottom: 0, end: 0, child: widget.badge!),
            ],
          )
        : avatar;

    if (widget.heroTag != null && widget.heroTag!.isNotEmpty) {
      result = Hero(tag: widget.heroTag!, child: result);
    }

    if (widget.enablePreview || widget.onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
          } else if (widget.enablePreview) {
            AppImagePreviewDialogWidget.show(
              context,
              imageUrl: widget.imageUrl,
              name: widget.name,
              subtitle: widget.subtitle,
            );
          }
        },
        child: result,
      );
    }

    return result;
  }
}
