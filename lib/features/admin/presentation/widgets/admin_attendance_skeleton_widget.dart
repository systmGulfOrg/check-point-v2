import 'package:flutter/material.dart';

import 'package:check_point_v2/core/core.dart';
import 'admin_attendance_skeleton_card_widget.dart';

class AdminAttendanceSkeletonWidget extends StatefulWidget {
  const AdminAttendanceSkeletonWidget({this.itemCount = 4, super.key});

  final int itemCount;

  @override
  State<AdminAttendanceSkeletonWidget> createState() =>
      _AdminAttendanceSkeletonWidgetState();
}

class _AdminAttendanceSkeletonWidgetState
    extends State<AdminAttendanceSkeletonWidget>
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
            separatorBuilder: (_, _) => hSpace(12),
            itemBuilder: (_, _) => const AdminAttendanceSkeletonCardWidget(),
          ),
        );
      },
    );
  }
}
