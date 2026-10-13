import 'dart:async';
import 'package:flutter/material.dart';

import '../styles/app_colors.dart';
import 'top_snack_bar_overlay_widget.dart';

class CustomSnackBar {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    dismiss();

    final overlayState = Overlay.maybeOf(context, rootOverlay: true);
    if (overlayState == null) return;

    _overlayEntry = OverlayEntry(
      builder: (ctx) => TopSnackBarOverlayWidget(
        message: message,
        backgroundColor: backgroundColor ?? AppColors.textPrimary,
        textColor: textColor ?? AppColors.white,
        icon: icon,
        onDismiss: dismiss,
      ),
    );

    overlayState.insert(_overlayEntry!);

    _timer = Timer(duration, () {
      dismiss();
    });
  }

  static void dismiss() {
    _timer?.cancel();
    _timer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  static void showSuccess(
    BuildContext context, {
    required String message,
    Duration duration = const Duration(seconds: 3),
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
    Duration duration = const Duration(seconds: 3),
  }) {
    show(
      context,
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error_outline_rounded,
      duration: duration,
    );
  }
}

void showCustomSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Color? textColor,
  IconData? icon,
  Duration duration = const Duration(seconds: 3),
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

