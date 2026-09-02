import 'package:flutter/material.dart';

/// Wraps a list item in a staggered fade + slide-up entrance animation.
/// Pass the [index] to offset each item's animation delay.
class AnimatedListItemWidget extends StatelessWidget {
  const AnimatedListItemWidget({
    required this.index,
    required this.child,
    super.key,
  });

  final int index;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final delayMs = (index * 70).clamp(0, 420);

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 320 + delayMs),
      curve: Curves.easeOutCubic,
      builder: (_, value, childWidget) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, 22 * (1 - value)),
          child: childWidget,
        ),
      ),
      child: child,
    );
  }
}
