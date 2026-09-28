import 'package:flutter/material.dart';
import 'package:check_point_v2/core/styles/app_colors.dart';

class GeofenceBoundaryPainter extends CustomPainter {
  const GeofenceBoundaryPainter({required this.isPolygon});
  final bool isPolygon;

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = AppColors.brandPrimary.withValues(alpha: 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final fillPaint = Paint()
      ..color = AppColors.brandPrimary.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    if (isPolygon) {
      final path = Path()
        ..moveTo(size.width * 0.20, size.height * 0.30)
        ..lineTo(size.width * 0.80, size.height * 0.25)
        ..lineTo(size.width * 0.75, size.height * 0.75)
        ..lineTo(size.width * 0.30, size.height * 0.80)
        ..close();
      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, borderPaint);
    } else {
      final center = Offset(size.width * 0.5, size.height * 0.5);
      final radius = size.height * 0.32;
      canvas.drawCircle(center, radius, fillPaint);
      canvas.drawCircle(center, radius, borderPaint);
    }

    final greenPin = Paint()..color = AppColors.success;
    final redPin = Paint()..color = AppColors.error;

    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.48), 5.0, greenPin);
    canvas.drawCircle(Offset(size.width * 0.55, size.height * 0.52), 5.0, greenPin);
    canvas.drawCircle(Offset(size.width * 0.38, size.height * 0.60), 5.0, greenPin);
    canvas.drawCircle(Offset(size.width * 0.68, size.height * 0.42), 5.0, greenPin);

    canvas.drawCircle(Offset(size.width * 0.88, size.height * 0.65), 5.5, redPin);
    canvas.drawCircle(Offset(size.width * 0.12, size.height * 0.22), 5.5, redPin);
  }

  @override
  bool shouldRepaint(covariant GeofenceBoundaryPainter oldDelegate) =>
      oldDelegate.isPolygon != isPolygon;
}
