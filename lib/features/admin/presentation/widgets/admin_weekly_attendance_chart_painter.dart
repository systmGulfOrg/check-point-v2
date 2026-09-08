import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class AdminWeeklyAttendanceChartPainter extends CustomPainter {
  const AdminWeeklyAttendanceChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final chartLeft = 38.0;
    final chartTop = 4.0;
    final chartRight = size.width - 4.0;
    final chartBottom = size.height - 26.0;
    final chartWidth = chartRight - chartLeft;
    final chartHeight = chartBottom - chartTop;

    final gridPaint = Paint()
      ..color = AppColors.border.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = AppColors.brandPrimary
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotPaint = Paint()..color = AppColors.brandPrimary;

    for (var index = 0; index < 5; index++) {
      final y = chartTop + (chartHeight / 4) * index;
      canvas.drawLine(Offset(chartLeft, y), Offset(chartRight, y), gridPaint);
    }

    const values = <double>[0.45, 0.72, 0.58, 0.84, 0.5, 0.68, 0.92];
    final points = <Offset>[
      for (var index = 0; index < values.length; index++)
        Offset(
          chartLeft + (chartWidth / (values.length - 1)) * index,
          chartBottom - chartHeight * values[index],
        ),
    ];

    final linePath = Path()..moveTo(points.first.dx, points.first.dy);
    for (var index = 1; index < points.length; index++) {
      linePath.lineTo(points[index].dx, points[index].dy);
    }
    canvas.drawPath(linePath, linePaint);
    for (final point in points) {
      canvas.drawCircle(point, 3.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
