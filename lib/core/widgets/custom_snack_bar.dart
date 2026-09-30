import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:check_point_v2/core/app/app_spaces.dart';
import 'package:check_point_v2/core/routes/app_router.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';
import 'package:check_point_v2/core/styles/app_text_styles.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static OverlayEntry? _activeEntry;
  static Timer? _activeTimer;

  static void hide() {
    _activeTimer?.cancel();
    _activeTimer = null;
    try {
      _activeEntry?.remove();
    } catch (_) {}
    _activeEntry = null;
  }

  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onDismissed,
  }) {
    hide();

    final overlay = Overlay.maybeOf(context, rootOverlay: true) ??
        AppRouter.navigatorKey.currentState?.overlay;
    if (overlay == null) return;

    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (ctx) => TopSnackBarOverlayWidget(
        message: message,
        backgroundColor: backgroundColor ?? const Color(0xFF1E293B),
        textColor: textColor ?? AppColors.white,
        icon: icon,
        onDismiss: () {
          if (_activeEntry == entry) {
            hide();
            onDismissed?.call();
          }
        },
      ),
    );

    _activeEntry = entry;
    overlay.insert(entry);

    _activeTimer = Timer(duration, () {
      if (_activeEntry == entry) {
        hide();
        onDismissed?.call();
      }
    });
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle_outline_rounded,
      duration: duration,
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline_rounded,
      duration: duration,
    );
  }

  static void showWarning(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.warning,
      icon: Icons.warning_amber_rounded,
      duration: duration,
    );
  }

  static void showInfo(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 4),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.info,
      icon: Icons.info_outline_rounded,
      duration: duration,
    );
  }
}

class TopSnackBarOverlayWidget extends StatefulWidget {
  const TopSnackBarOverlayWidget({
    required this.message,
    required this.backgroundColor,
    required this.textColor,
    required this.onDismiss,
    this.icon,
    super.key,
  });

  final String message;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;
  final VoidCallback onDismiss;

  @override
  State<TopSnackBarOverlayWidget> createState() =>
      _TopSnackBarOverlayWidgetState();
}

class _TopSnackBarOverlayWidgetState extends State<TopSnackBarOverlayWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller.forward();
  }

  Future<void> _handleDismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return Positioned(
      top: topPadding + 8.h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Dismissible(
            key: UniqueKey(),
            direction: DismissDirection.up,
            onDismissed: (_) => widget.onDismiss(),
            child: Material(
              color: AppColors.transparent,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 14.w,
                  vertical: 12.h,
                ),
                decoration: BoxDecoration(
                  color: widget.backgroundColor,
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 16,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (widget.icon != null) ...[
                      Icon(
                        widget.icon,
                        color: widget.textColor,
                        size: 20.r,
                      ),
                      wSpace(10),
                    ],
                    Expanded(
                      child: Text(
                        widget.message,
                        style: AppTextStyles.font14Medium.copyWith(
                          color: widget.textColor,
                        ),
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    wSpace(8),
                    GestureDetector(
                      onTap: _handleDismiss,
                      behavior: HitTestBehavior.opaque,
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.close_rounded,
                          color: widget.textColor.withValues(alpha: 0.8),
                          size: 18.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Color? textColor,
  IconData? icon,
  Duration duration = const Duration(seconds: 4),
}) {
  CustomSnackBar.show(
    context,
    message: message,
    backgroundColor: backgroundColor,
    textColor: textColor,
    icon: icon,
    duration: duration,
  );
}
