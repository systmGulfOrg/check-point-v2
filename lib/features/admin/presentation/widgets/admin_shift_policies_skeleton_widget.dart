import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_shift_policy_skeleton_card_widget.dart';

class AdminShiftPoliciesSkeletonWidget extends StatefulWidget {
  const AdminShiftPoliciesSkeletonWidget({
    this.itemCount = 3,
    super.key,
  });

  final int itemCount;

  @override
  State<AdminShiftPoliciesSkeletonWidget> createState() =>
      _AdminShiftPoliciesSkeletonWidgetState();
}

class _AdminShiftPoliciesSkeletonWidgetState
    extends State<AdminShiftPoliciesSkeletonWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 0.35, end: 0.85).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Opacity(
          opacity: _animation.value,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.itemCount,
            separatorBuilder: (_, _) => hSpace(10),
            itemBuilder: (_, _) =>
                const AdminShiftPolicySkeletonCardWidget(),
          ),
        );
      },
    );
  }
}
