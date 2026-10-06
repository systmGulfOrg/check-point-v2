import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class AdminDeletedActionButtonWidget extends StatelessWidget {
  const AdminDeletedActionButtonWidget({
    required this.icon,
    required this.color,
    required this.background,
    required this.tooltip,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final Color color;
  final Color background;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: tooltip,
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.all(8.r),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, size: 18.r, color: color),
      ),
    ),
  );
}
