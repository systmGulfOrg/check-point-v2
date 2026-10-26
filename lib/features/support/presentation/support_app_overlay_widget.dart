import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'support_contact_button_widget.dart';

class SupportAppOverlayWidget extends StatefulWidget {
  const SupportAppOverlayWidget({required this.child, super.key});

  final Widget child;

  @override
  State<SupportAppOverlayWidget> createState() =>
      SupportAppOverlayWidgetState();
}

class SupportAppOverlayWidgetState extends State<SupportAppOverlayWidget> {
  Offset? position;
  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final buttonSize = 48.r;
        final currentPosition =
            position ??
            Offset(
              constraints.maxWidth - buttonSize - 16.w,
              constraints.maxHeight - buttonSize - 110.h,
            );

        return Stack(
          children: [
            widget.child,
            AnimatedPositioned(
              duration: isDragging
                  ? Duration.zero
                  : const Duration(milliseconds: 140),
              curve: Curves.easeOut,
              left: currentPosition.dx,
              top: currentPosition.dy,
              child: SupportContactButtonWidget(
                onPanStart: () {
                  setState(() {
                    isDragging = true;
                  });
                },
                onPanUpdate: (delta) {
                  final nextPosition = currentPosition + delta;
                  setState(() {
                    position = Offset(
                      nextPosition.dx.clamp(
                        0,
                        constraints.maxWidth - buttonSize,
                      ),
                      nextPosition.dy.clamp(
                        MediaQuery.paddingOf(context).top,
                        constraints.maxHeight - buttonSize,
                      ),
                    );
                  });
                },
                onPanEnd: () {
                  final edgePosition =
                      currentPosition.dx + buttonSize / 2 <
                          constraints.maxWidth / 2
                      ? 0.0
                      : constraints.maxWidth - buttonSize;
                  setState(() {
                    isDragging = false;
                    position = Offset(edgePosition, currentPosition.dy);
                  });
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
