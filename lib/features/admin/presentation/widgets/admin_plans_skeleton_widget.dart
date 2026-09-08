import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_plan_skeleton_card_widget.dart';

class AdminPlansSkeletonWidget extends StatefulWidget {
  const AdminPlansSkeletonWidget({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  State<AdminPlansSkeletonWidget> createState() =>
      _AdminPlansSkeletonWidgetState();
}

class _AdminPlansSkeletonWidgetState extends State<AdminPlansSkeletonWidget>
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
    _animation = Tween<double>(
      begin: 0.35,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
            itemBuilder: (_, _) => const AdminPlanSkeletonCardWidget(),
          ),
        );
      },
    );
  }
}
