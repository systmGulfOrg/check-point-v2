import 'package:flutter/material.dart';

import '../../../../core/core.dart';
import 'admin_task_skeleton_card_widget.dart';

class AdminTasksSkeletonWidget extends StatefulWidget {
  const AdminTasksSkeletonWidget({
    this.itemCount = 4,
    super.key,
  });

  final int itemCount;

  @override
  State<AdminTasksSkeletonWidget> createState() =>
      _AdminTasksSkeletonWidgetState();
}

class _AdminTasksSkeletonWidgetState extends State<AdminTasksSkeletonWidget>
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
            itemBuilder: (_, _) => const AdminTaskSkeletonCardWidget(),
          ),
        );
      },
    );
  }
}
